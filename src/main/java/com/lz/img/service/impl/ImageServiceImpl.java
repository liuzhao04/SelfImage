package com.lz.img.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lz.img.dao.IImageDao;
import com.lz.img.pojo.ImageInfor;
import com.lz.img.service.IImageService;

/**
 * 图片管理服务 
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
@Service("imageService")
public class ImageServiceImpl implements IImageService
{
    @Autowired
    private IImageDao dao;
    @Override
    public void insert(ImageInfor imageInfor)
    {
        dao.insert(imageInfor);
    }

}
