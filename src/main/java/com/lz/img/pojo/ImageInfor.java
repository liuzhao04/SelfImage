package com.lz.img.pojo;

import java.util.Date;

/**
 * 文件上传信息
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ImageInfor extends RequestBase {
	private static final long serialVersionUID = 2524308929369629730L;

	private Long imageId;

	private String name;

	private String saveName;

	private Long fileSize;

	private String error; // 上传是否出错

	private Long uploadSize;

	private String remoteUrl;

	private String batchId; // 上传批次

	private Date createTime;

	private String createTimeStr;

	private String timeStart; // 查询区间
	private String timeEnd;

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateTimeStr() {
		return createTimeStr;
	}

	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public String getRemoteUrl() {
		return remoteUrl;
	}

	public void setRemoteUrl(String remoteUrl) {
		this.remoteUrl = remoteUrl;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public Long getImageId() {
		return imageId;
	}

	public void setImageId(Long imageId) {
		this.imageId = imageId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSaveName() {
		return saveName;
	}

	public void setSaveName(String saveName) {
		this.saveName = saveName;
	}

	public Long getFileSize() {
		return fileSize;
	}

	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}

	public Long getUploadSize() {
		return uploadSize;
	}

	public void setUploadSize(Long uploadSize) {
		this.uploadSize = uploadSize;
	}

	@Override
	public String toString() {
		return "ImageInfor [imageId=" + imageId + ", name=" + name + ", saveName=" + saveName + ", fileSize=" + fileSize
				+ ", error=" + error + ", uploadSize=" + uploadSize + ", remoteUrl=" + remoteUrl + ", batchId="
				+ batchId + ", createTime=" + createTime + ", createTimeStr=" + createTimeStr + ", timeStart="
				+ timeStart + ", timeEnd=" + timeEnd + "]";
	}

}
