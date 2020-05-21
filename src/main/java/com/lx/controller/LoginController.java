package com.lx.controller;

import com.lx.model.Information;
import com.lx.model.User;
import com.lx.service.FileService;
import com.lx.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

@Controller
public class LoginController {

    @Autowired
    private UserSerivce userSerivceImpl;

    @Autowired
    private FileService fileServiceImpl;

    @ResponseBody
    @RequestMapping(value = "login.do",method= RequestMethod.POST)
    public Information login(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        List<User> list_user_info = userSerivceImpl.login(username,password);
        Information info;
        if(!list_user_info.isEmpty())
        {
            Cookie cookie = new Cookie("loginName", URLEncoder.encode(username,"UTF-8"));
            cookie.setMaxAge(-1);
            cookie.setPath("/");
            response.addCookie(cookie);
            info = new Information("loginSuccess");
            return info;
        }
        else
        {
            info = new Information("loginFailed");
            return info;
        }
    }


    @RequestMapping("exit_login.do")
    public String exit_login(HttpSession session,HttpServletRequest request ,HttpServletResponse response)
    {
        session.removeAttribute("loginName");
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie :cookies){
            if(cookie.getName().equals("loginName")){
                cookie.setMaxAge(0);
                cookie.setPath("/");//很关键，设置成跟写入cookies一样的，全路径共享Cookie
                response.addCookie(cookie);//重新响应
                return "redirect:bilibili.do";
            }
        }
        return "redirect:bilibili.do";
    }


    @RequestMapping("register.do")
    public String register(String username,String password,@RequestParam(value = "headImg")MultipartFile headImg,String content,HttpServletRequest request)
    {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setHeadImg(headImg.getOriginalFilename());
        user.setContent(content);

        userSerivceImpl.register(user);
        fileServiceImpl.fileuploadFile(headImg,request);
        return "redirect:bilibili.do";
    }

    @ResponseBody
    @RequestMapping(value="checkUserName.do", method= RequestMethod.POST)
    public Information ajaxValidate(HttpServletRequest request) {
        //String username = JSONObject.parseObject(json).getString("username");
        String username = request.getParameter("username");

        User user = userSerivceImpl.selectInfoByUserName(username);

        if(user==null){//user为空，说明没有找到该用户，可以注册。反之。
            Information info = new Information("yes");
            return info;//然后返回给前端执行success方法。
        }else{
            Information info = new Information("no");
            return info;
        }
    }







}
