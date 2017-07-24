package com.lz.img.pojo;

import java.io.Serializable;

/**
 * 排序实体
 * 
 * @author liuz@aotian.com
 * @date 2017年7月24日 下午3:06:16
 */
public class RequestBase implements Serializable {
	private static final long serialVersionUID = -2514374592196403309L;
	private String sortName;
	private String sortOrder;

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	@Override
	public String toString() {
		return "RequestBase [sortName=" + sortName + ", sortOrder=" + sortOrder + "]";
	}

}
