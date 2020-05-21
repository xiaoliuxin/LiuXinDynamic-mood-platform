package com.lx.controller;

import com.lx.model.*;

import com.lx.service.*;
import com.lx.util.CookieUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserSerivce userSerivceImpl;

    @Autowired
    private FollowService followServiceImpl;

    @Autowired
    private UserCollectVideoService userCollectVideoServiceImpl;

    @Autowired
    private FileService fileServiceImpl;

    @Autowired
    private VideoService videoServiceImpl;

    @Autowired
    private VideoTypeService videoTypeServiceImpl;


    private CookieUtil cookieUtil = new CookieUtil();



    @RequestMapping("userInfo.do")
    public String userInfo(Integer userid, Model model,HttpServletRequest request)
    {
        //获取当前登录的用户信息
        String login_name= cookieUtil.getCookieName(request);
        User login_user = userSerivceImpl.selectInfoByUserName(login_name);


        //获取 ID = userid 用户信息
        User user = userSerivceImpl.selectByPrimaryKey(userid);
        //获取等级和经验
        Integer maxExp = level_if(user.getLevel(),user.getExp(),userid);

        //获取关注数
        Integer fans_count = followServiceImpl.fan_count(userid);
        Integer follow_count = followServiceImpl.follow_count(userid);

        //获取用户发布的视频
        List<User> videoList = userSerivceImpl.select_user_release_videos(userid);

        //获取收藏夹的视频
        List<UserCollectVideo> userCollectVideoList = userCollectVideoServiceImpl.user_collect_videos(userid);

        //获取关注列表
        List<User> user_follow_list = userSerivceImpl.follow_list(userid);

        //获取粉丝列表
        List<User> user_fans_list = userSerivceImpl.fans_list(userid);

        //获取视频类型
        List<VideoType> types = videoTypeServiceImpl.selectAll();

        //判断 是否已经关注 粉丝  的 某个用户   把结果加入一个集合
        List<Integer> if_follow_fans = new ArrayList<>();

        for(User fans:user_fans_list)
        {
            //<!--查询 当前登录 的用户是否已经关注 ID = fans.getUserid() 的用户 -->
            int res = followServiceImpl.select_if_follow(login_user.getUserid(),fans.getUserid());
            if(res > 0) //如果已经关注
            {
                if_follow_fans.add(fans.getUserid());  // 把该用户 ID 加入已关注集合
            }
        }





        model.addAttribute("types",types);
        model.addAttribute("user",login_user);
        model.addAttribute("TA_user",user);
        model.addAttribute("maxExp",maxExp);
        model.addAttribute("user_fans_list",user_fans_list);
        model.addAttribute("user_follow_list",user_follow_list);
        model.addAttribute("user_collects",userCollectVideoList);
        model.addAttribute("fans_count",fans_count);
        model.addAttribute("follow_conut",follow_count);
        model.addAttribute("videoList",videoList);


        if(login_user.getUserid() == userid)    //如果当前登录的用户 与 点击的用户ID相等，说明进入自己主页,否则进入Ta的主页
        {
            model.addAttribute("if_follow_fans",if_follow_fans);
            System.out.println("进入"+login_user.getUsername()+"的主页......");
            return "userInfo";
        }
        else
        {
            List<Integer> if_follow_Ta_followed = new ArrayList<>();
            for(User fol:user_follow_list)
            {
                //<!--查询 当前登录 的用户是否已经关注 Ta的关注 ID = fol.getUserid() 的用户 -->
                int res = followServiceImpl.select_if_follow(login_user.getUserid(),fol.getUserid());
                if(res == 1 ) //如果已经关注
                {
                    if_follow_Ta_followed.add(fol.getUserid());  // 把该用户 ID 加入已关注集合
                }
            }

            List<Integer> if_follow_Ta_fans = new ArrayList<>();
            for(User fans:user_fans_list)
            {
                //<!--查询 当前登录 的用户是否已经关注 Ta的关注 ID = fans.getUserid() 的用户 -->
                int res = followServiceImpl.select_if_follow(login_user.getUserid(),fans.getUserid());
                if(res == 1 ) //如果已经关注
                {
                    if_follow_Ta_fans.add(fans.getUserid());  // 把该用户 ID 加入已关注集合
                }
            }


            model.addAttribute("if_follow_Ta_fans",if_follow_Ta_fans);
            model.addAttribute("if_follow_Ta_followed",if_follow_Ta_followed);
            System.out.println("进入"+user.getUsername()+"的主页......");
            return "TA";
        }
    }


    @ResponseBody
    @RequestMapping("update_vname_typeid.do")
    public Information update_vname_typeid(HttpServletRequest request)
    {
        Information info;
        String vname = request.getParameter("vname");
        Integer typeid = Integer.parseInt(request.getParameter("typeid"));
        Integer vid = Integer.parseInt(request.getParameter("vid"));
        int res = videoServiceImpl.update_vname_type(vname,typeid,vid);

        if(res > 0)
        {
            info = new Information("yes");
        }
        else
        {
            info = new Information("no");
        }

        return info;
    }


    @ResponseBody
    @RequestMapping("deleteManu_Video.do")
    public Information deleteManu_Video(HttpServletRequest request)
    {
        Information info;
        Integer vid = Integer.parseInt(request.getParameter("vid"));
        int res = videoServiceImpl.deleteByPrimaryKey(vid);

        if(res > 0)
        {
            info = new Information("yes");
        }
        else
        {
            info = new Information("no");
        }
        return info;
    }

    @RequestMapping("update_user_info.do")
    public String update_user_info(@RequestParam("headImg")MultipartFile headImg, Integer userid,String username, String password, HttpServletRequest request)
    {
        //保存新信息
        userSerivceImpl.update_user_info(username,password,headImg.getOriginalFilename(),userid);
        //上传新头像
        fileServiceImpl.fileuploadFile(headImg,request);

        return "redirect:userInfo.do?userid="+userid;
    }

    @RequestMapping("saveContent.do")
    public String saveContent(String content,Integer uid)
    {
        userSerivceImpl.updateContentById(content,uid);
        return "redirect:userInfo.do?userid="+uid;
    }


    /*上传视频*/
    @RequestMapping("uploadvideo.do")
    public String upload_video(@RequestParam(value = "upfile")MultipartFile[] upfile, HttpServletRequest request,String vname ,Integer typeId) throws ParseException {
        User userInfo = userSerivceImpl.selectInfoByUserName(cookieUtil.getCookieName(request));
        String vImage = "";
        String vsrc = "";
        for(MultipartFile file : upfile)
        {
            fileServiceImpl.fileuploadFile(file,request);
            String filename = file.getOriginalFilename();

            String [] str = filename.split("\\.");
            if(str[1].equals("jpg") || str[1].equals("png"))
            {
                vImage = filename;
            }
            else
            {
                vsrc = filename;
            }
        }


        Date date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));//获取系统时间
        Timestamp date1=new Timestamp(date.getTime());//把java.util.Date类型转换为java.sql.Timestamp类型
        Video video = new Video();
            video.setVname(vname);
            video.setTypeId(typeId);
            video.setUserid(userInfo.getUserid());
            video.setVsrc(vsrc);
            video.setvImage(vImage);
            video.setVtime(date1);
        videoServiceImpl.Contribution(video);
        return "redirect:userInfo.do?userid="+userInfo.getUserid();
    }

    @ResponseBody
    @RequestMapping("deleteFollow.do")
    public Information deleteFollow(HttpServletRequest request)
    {
        String userid_str = request.getParameter("userid");
        String myid_str = request.getParameter("myid");
        Integer userid = Integer.parseInt(userid_str);
        Integer myid = Integer.parseInt(myid_str);

        // myid 取消关注 userid
        int res = followServiceImpl.cancel_follow(myid,userid);

        Information info;
        if(res == 1)
        {
            info = new Information("yes");
        }
        else
        {
            info = new Information("no");
        }
        return info;
    }


    @ResponseBody
    @RequestMapping("addFollow.do")
    public Information addFollow(HttpServletRequest request)
    {
        System.out.println("addingFollow........");
        String fansId = request.getParameter("fansId");
        String userid = request.getParameter("myid");

        Information info;

        //<!--取消关注功能 /* ID = userid 的用户取消关注  ID = follow_id 的用户 */-->
        int res = followServiceImpl.follow_user(Integer.parseInt(userid),Integer.parseInt(fansId));

        if(res == 1)
        {
            info = new Information("yes");
        }
        else
        {
            info = new Information("no");
        }
        return info;
    }


    public Integer level_if(Integer level, Integer EXP,Integer userid) //根据等级变更升级所需经验值
    {
        /*升级奖励对应等级硬币*/
        int LEVELUP_REWARD[] = {50,100,200,350,500,800};
        Integer maxExp = 0;
        boolean flag = true;
        while(flag) {
            if(level==0)
            { maxExp = 1000;}
            else if(level==1)
            { maxExp = 3000;}
            else if(level==2)
            { maxExp = 6000;}
            else if(level==3)
            { maxExp = 10000;}
            else if(level==4)
            { maxExp = 15000;}
            else if(level==5)
            { maxExp = 21000;}
            else if(level==6)
            { maxExp = 30000;}

            if(EXP>=maxExp && level<6)  //根据经验进行升级
            {
                System.out.println("-------升级--------");
                userSerivceImpl.LEVEL_UP(userid);
                level++;
                /*升级获得硬币*/
                userSerivceImpl.levelup_getCoin(LEVELUP_REWARD[level-1],userid);
            }
            else
            {
                flag=false;
                break;
            }
        }
        return maxExp;
    }

}
