package com.lz.img.dao;

import java.util.List;

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

    /**
     * 查询图片记录
     * @param imageInfor
     */
	public List<ImageInfor> selectByPage(ImageInfor imageInfor);
}
