package com.lz.img.utils;

import java.security.NoSuchAlgorithmException;

import org.springframework.web.multipart.MultipartFile;

import com.lz.common.utils.Md5Utils;
import com.lz.img.pojo.ImageInfor;

/**
 * 图片上传工具包
 * 
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ImageUploadUtils
{
    public static ImageInfor parse(MultipartFile file) {
        ImageInfor infor = new ImageInfor();
        infor.setName(file.getOriginalFilename());
        String fileNameStr = file.getOriginalFilename()+System.currentTimeMillis();
        int pos  = infor.getName().lastIndexOf(".");
        String suffix = infor.getName().substring(pos);
        try
        {
            infor.setSaveName(Md5Utils.encrpt(fileNameStr)+suffix);
        }
        catch (NoSuchAlgorithmException e)
        {
            infor.setSaveName(fileNameStr+suffix);
        }
        infor.setFileSize(file.getSize());
        infor.setUploadSize(0L);
        return infor;
    }
}
