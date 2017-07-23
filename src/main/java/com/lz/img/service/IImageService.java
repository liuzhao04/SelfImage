package com.lz.img.service;

import com.lz.img.pojo.ImageInfor;

/**
 * 图片服务
 * 
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public interface IImageService
{
    /**
     * 写入一条图片信息 
     *
     * @param imageInfor
     */
    public void insert(ImageInfor imageInfor);
}
