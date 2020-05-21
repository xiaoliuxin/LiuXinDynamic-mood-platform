package com.gph.service.Impl;

import com.gph.service.FileService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Service
public class FileSerivceImpl implements FileService {

    @Override
    public void fileuploadFile(MultipartFile uploadFile, HttpServletRequest request) {
        String fileName = uploadFile.getOriginalFilename();//获取上传文件的名字
        String filepath = request.getSession().getServletContext().getRealPath("/img");
        //判断文件夹是否存在,不存在则创建
        File file = new File(filepath);

        if(!file.exists())
        {
            file.mkdirs();

        }
        String newFilePath  = filepath+"/"+fileName; //新文件的路径
        try
        {

            uploadFile.transferTo(new File(newFilePath)); //将传来的新文件存入文件夹


        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deletefile(String delete_fileUrl,HttpServletRequest request) {

        String realPath = request.getSession().getServletContext().getRealPath("/img");
        File file = new File(realPath+"/"+delete_fileUrl);
        if(file.exists())
        {
            file.delete();
        }
    }

}
