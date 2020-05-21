package com.lx.controller;

import com.lx.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class UploadController {
    @Autowired
    private FileService fileServiceImpl;

    @RequestMapping("toUpload.do")
    public String toupload()
    {
        return "upload";
    }


}
