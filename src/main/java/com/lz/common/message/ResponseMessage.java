package com.lz.common.message;

import java.io.Serializable;

import com.lz.common.page.Page;

/**
 * 后台数据返回格式
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ResponseMessage implements Serializable{ 
	private static final long serialVersionUID = -2867571757278640401L;

	private boolean success;

	private String message;

	private Object data;

	private boolean isPage;

	private Integer pageIndex;

	private Integer pageSize;

	private Integer count;

	private Object userData;
	
	public ResponseMessage() {
		setSuccess(true);
	}
	
	public ResponseMessage(Page page) {
		setSuccess(true);
		setCount(page.getTotalCount());
    	setPageIndex(page.getPageNo());
    	setData(page.getPageSize());
	}

	public Object getUserData() {
		return userData;
	}

	public void setUserData(Object userData) {
		this.userData = userData;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public boolean isPage() {
		return isPage;
	}

	public void setPage(boolean isPage) {
		this.isPage = isPage;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "ResponseMessage [success=" + success + ", message=" + message + ", data=" + data + ", isPage=" + isPage
				+ ", pageIndex=" + pageIndex + ", pageSize=" + pageSize + ", count=" + count + ", userData=" + userData
				+ "]";
	}

}
