package com.lx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lx.model.*;
import com.lx.service.*;
import com.lx.util.CookieUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class VideoController {

    @Autowired
    private VideoService videoServiceImpl;

    @Autowired
    private UserSerivce userSerivceImpl;

    @Autowired
    private VideoTypeService videoTypeServiceImpl;

    @Autowired
    private FollowService followServiceImpl;

    @Autowired
    private UserCollectVideoService userCollectVideoServiceImpl;

    @Autowired
    private MessageService messageServiceImpl;

    @Autowired
    private UserPraiseIconService userPraiseIconServiceImpl;

    private CookieUtil cookieUtil = new CookieUtil();
    private List<Video> videoList = new ArrayList<>();
    private  List<VideoType> types = new ArrayList<>();

    @RequestMapping("bilibili.do")
    public String bilibili(@RequestParam(value="page",defaultValue="1")int page, Model model, HttpServletRequest request,Integer videoType)
    {
        PageHelper.startPage(page,8);
        videoList = videoServiceImpl.list();
        PageInfo pageInfo;
        if(videoType==null)
        {
            pageInfo = pagelist(videoList);  //没有点击导航栏视频分类，默认视频列表
        }
        else
        {
            pageInfo = pagelist(videoServiceImpl.selectVideoByType(videoType));  //根据视频类型列出视频集合
            model.addAttribute("videoType",videoType);
        }

        User userList = userSerivceImpl.selectInfoByUserName(cookieUtil.getCookieName(request));   //根据Cookie获取个人信息
        List<Video> rank = videoServiceImpl.rank_list(); //排行榜
        types = videoTypeServiceImpl.selectAll();//导航栏


        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("types",types);
        model.addAttribute("u",userList);
        model.addAttribute("rank",rank);


        return "bilibili";
    }

    public PageInfo pagelist(List<Video> videos)
    {
        PageInfo pageInfo = new PageInfo(videos);  //把视频列表分页
        return pageInfo;
    }


    @RequestMapping("video.do")
    public String video(Integer vid,Model model,HttpServletRequest request)
    {
        Video video = videoServiceImpl.selectByPrimaryKey(vid); //根据视频id获取视频信息

        User user = userSerivceImpl.selectByPrimaryKey(video.getUserid()); //根据用户id获取视频发布者信息


        VideoType videoType = videoTypeServiceImpl.selectByPrimaryKey(video.getTypeId());  //获取视频类型

        Integer fans_count = followServiceImpl.fan_count(video.getUserid());//获取粉丝数

        Integer collect_count = userCollectVideoServiceImpl.user_collect_video_count(vid); //视频收藏数

        String username = cookieUtil.getCookieName(request);//获取当前登录用户
        User login_user = userSerivceImpl.selectInfoByUserName(username);

        Integer if_follow = 0;
        Integer if_praise = 0;
        Integer if_coin = 0;
        Integer if_collect = 0;
        if(username!=null && username!="") {
            /*查询用户是否已经关注*/
            if_follow = followServiceImpl.select_if_follow(login_user.getUserid(), video.getUserid());

            //查询用户是否已经点赞视频  1 表示已经点赞 , 0 表示未点赞
            if_praise = userPraiseIconServiceImpl.if_praised(login_user.getUserid(), vid);


            //查询用户是否已经投币
            if_coin = userPraiseIconServiceImpl.if_giveCoin(login_user.getUserid(), vid);

            //查询用户是否已经收藏
            if_collect = userCollectVideoServiceImpl.if_collect(login_user.getUserid(), vid);
        }


        //获取该视频下的评论
        List<Message> messageList = messageServiceImpl.selectMessByVid(vid);


        model.addAttribute("if_follow",if_follow); //是否关注
        model.addAttribute("if_praise",if_praise); //是否点赞
        model.addAttribute("if_coin",if_coin);  //是否投币
        model.addAttribute("if_collect",if_collect); //是否收藏
        model.addAttribute("login_user",login_user);    //登录信息
        model.addAttribute("videoInfo",video); //视频信息
        model.addAttribute("v_user",user);  //视频发布者
        model.addAttribute("videoType",videoType); //视频类型
        model.addAttribute("fans_count",fans_count); //视频发布者粉丝数
        model.addAttribute("collect_count",collect_count); //视频收藏数
        model.addAttribute("messageList",messageList); //显示该视频下的评论

        return "video";
    }

    // 关注
    @RequestMapping("follow.do")
    public String follow(Integer userid,Integer followId,Integer vid)
    {
        followServiceImpl.follow_user(userid,followId);
        return "redirect:video.do?vid="+vid;
    }

    // 取消关注
    @RequestMapping("cancelfollow.do")
    public String cancelfollow(Integer userid,Integer followId,Integer vid)
    {
        followServiceImpl.cancel_follow(userid,followId);
        return "redirect:video.do?vid="+vid;
    }

    // 发送评论
    @RequestMapping("sendMess.do")
    public String sendMessage(Message message)
    {
       SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
       String time = df.format(new Date());// new Date()为获取当前系统时间
       message.setSendTime(time);       //设置时间
       if(message.getComment()!="" && message.getComment()!=null)
       {
           messageServiceImpl.sendMess(message);    //发送
       }

       return "redirect:video.do?vid="+message.getVid();
    }


    //删除自己的评论
    @RequestMapping("deleteMess.do")
    public String deleteMess(Integer messId,Integer vid)
    {
        messageServiceImpl.deleteMess(messId);
        return "redirect:video.do?vid="+vid;
    }

    // 点赞
    @ResponseBody
    @RequestMapping("praise.do")
    public Information praise(Integer vid,Integer userid)
    {
        Information info ;
        int res = videoServiceImpl.praise(vid);//点赞数加一
        //变更点赞状态 state_praise = 1
        int count = userPraiseIconServiceImpl.praised(userid,vid); //如果不存在点赞记录表中 count = 0

        if(count<=0)
        {
            userPraiseIconServiceImpl.add_praise_tab(1,userid,vid);//加入点赞记录
            /*点赞者获得经验*/
            userSerivceImpl.getExp(userid);
        }

        if(res == 1)
            info = new Information(String.valueOf(ReFresh_PrasieNum(vid)));
        else
            info = new Information("no");

        return info;
    }

    //取消点赞
    @ResponseBody
    @RequestMapping("cancel_praise.do")
    public Information cancel_praise(Integer vid,Integer userid)
    {
        Information info ;
        //取消点赞 ，State_Praise = 0
        userPraiseIconServiceImpl.Cancel_praised(userid,vid);
        // 视频点赞数减一
        int res = videoServiceImpl.Subtract_praise(vid);

        if(res == 1 )
            info = new Information(String.valueOf(ReFresh_PrasieNum(vid)));
        else
            info = new Information("no");

        return info;
    }

    // 投币
    @ResponseBody
    @RequestMapping("giveCoin.do")
    public Information giveCoin(Integer vid,Integer userid,Integer video_userId)
    {
        Information info;
        int res = videoServiceImpl.giveCoin(vid);//投币操作
        //变更投币状态
        int coin_state = userPraiseIconServiceImpl.giveCoined(userid,vid);

        if(coin_state<=0)
        {
            userPraiseIconServiceImpl.add_Coin_tab(1,userid,vid);
            /*投币者获得经验*/
            userSerivceImpl.getExp(userid);
            /*作者同时也获得经验*/
            userSerivceImpl.getExp(video_userId);
            /*扣除投币者硬币*/
            userSerivceImpl.deduct_coin(userid);
            /*作者获得硬币*/
            userSerivceImpl.author_get_coin(video_userId);
        }
        if(res == 1 ){info = new Information("yes");}else {info = new Information("no");}
        return info;
    }

    // 收藏
    @ResponseBody
    @RequestMapping("collect.do")
    public Information collect(Integer vid ,Integer userid)
    {
        Information info;
        UserCollectVideo userCollectVideo = new UserCollectVideo();
        userCollectVideo.setVid(vid);
        userCollectVideo.setUserid(userid);
        int res = userCollectVideoServiceImpl.collect(userCollectVideo);

        if(res > 0)
            info = new Information(String.valueOf(ReFresh_CollectNum(vid)));
        else
            info = new Information("no");

        return  info;
    }

    @ResponseBody
    @RequestMapping("cancel_collect.do")
    public Information cancel_collect(Integer vid ,Integer userid)
    {
        Information info;
        int res = userCollectVideoServiceImpl.cancel_collect(userid,vid);  //取消收藏


        if(res == 1)
            info = new Information(String.valueOf(ReFresh_CollectNum(vid)));
        else
            info = new Information("no");

        return info;
    }


    //刷新收藏数
    public Integer ReFresh_CollectNum(Integer vid)
    {
        Integer new_collect_num = userCollectVideoServiceImpl.user_collect_video_count(vid); //视频收藏数
        return new_collect_num;
    }

    //刷新点赞数
    public Integer ReFresh_PrasieNum(Integer vid)
    {
        Integer new_praise_num = videoServiceImpl.selectByPrimaryKey(vid).getPraise(); //视频点赞数
        return new_praise_num;
    }

}
