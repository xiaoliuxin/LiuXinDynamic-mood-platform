package com.lx.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class CookieUtil {

    public String getCookieName (HttpServletRequest request)  {
        Cookie[] cookie = request.getCookies();
        String str = "";
        for(Cookie cookie1:cookie)
        {
            if(cookie1.getName().equals("loginName"))
            {
                try {
                    str = URLDecoder.decode(cookie1.getValue(), "UTF-8");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
        return str;
    }
}
