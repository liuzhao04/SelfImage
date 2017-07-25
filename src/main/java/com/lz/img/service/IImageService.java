package com.lz.img.service;

import com.lz.common.page.Page;
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

    /**
     * 分页查询
     * @param imageInfor
     * @return
     */
	public Page list(ImageInfor imageInfor);

	/**
	 * 图片删除
	 * @param imageInfor
	 * @return
	 */
	public Boolean delImage(ImageInfor imageInfor);
}
