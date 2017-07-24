package com.lz.common.page;

import java.util.List;

/**
 * 分页管理类
 * 
 * @author liuz@aotian.com
 * @date 2017年7月24日 下午1:53:22
 */
public class Page extends BasePage {
    private static final long serialVersionUID = -970177928709377315L;

    public static ThreadLocal<Page> threadLocal = new ThreadLocal<Page>();

    private List<?> data; 
    
    public Page() {
    }

    public Page(int currentPage, int pageSize, int totalCount) {
        super(currentPage, pageSize, totalCount);
    }

    public Page(int currentPage, int pageSize, int totalCount, List<?> data) {
        super(currentPage, pageSize, totalCount);
        this.data = data;
    }

    public List<?> getData() {
        return data;
    }

    public void setData(List<?> data) {
        this.data = data;
    }

	@Override
	public String toString() {
		return "Page [data=" + data +","+ super.toString()+"]";
	}
    
}