package com.lz.img.dao;

import com.lz.img.pojo.ImageInfor;

/**
 * 图片数据库操作接口
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public interface IImageDao
{
    /**
     * 新增一条图片记录 
     *
     * @param infor
     */
    public void insert(ImageInfor infor);
}
