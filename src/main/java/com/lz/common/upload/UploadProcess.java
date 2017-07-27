package com.lz.common.upload;

/**
 * 文件上传进度
 * 
 * @author liuz@aotian.com
 * @date 2017年7月27日 上午11:28:06
 */
public class UploadProcess {
	private long bytesRead;
	private long contentLength;
	private long items;

	public long getBytesRead() {
		return bytesRead;
	}

	public void setBytesRead(long bytesRead) {
		this.bytesRead = bytesRead;
	}

	public long getContentLength() {
		return contentLength;
	}

	public void setContentLength(long contentLength) {
		this.contentLength = contentLength;
	}

	public long getItems() {
		return items;
	}

	public void setItems(long items) {
		this.items = items;
	}

	@Override
	public String toString() {
		return "UploadProcess [bytesRead=" + bytesRead + ", contentLength=" + contentLength + ", items=" + items + "]";
	}

}
