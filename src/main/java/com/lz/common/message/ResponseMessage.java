package com.lz.common.message;

import java.io.Serializable;

import com.lz.common.page.Page;
import com.lz.img.pojo.RequestBase;

/**
 * 后台数据返回格式
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ResponseMessage implements Serializable
{
    private static final long serialVersionUID = -2867571757278640401L;

    private boolean success;

    private String message;

    private Object data;

    private boolean isPage;

    private Integer pageIndex;

    private Integer pageSize;

    private Integer pageCount;

    private Integer count;

    private Object userData;
    
    private Integer draw;

    private Integer start;

    private Integer length;

    private Integer recordsTotal;

    private Integer recordsFiltered; // 前台过滤条件过滤后的数据

    public Integer getDraw()
    {
        return draw;
    }

    public void setDraw(Integer draw)
    {
        this.draw = draw;
    }

    public Integer getStart()
    {
        return start;
    }

    public void setStart(Integer start)
    {
        this.start = start;
    }

    public Integer getLength()
    {
        return length;
    }

    public void setLength(Integer length)
    {
        this.length = length;
    }

    public Integer getRecordsTotal()
    {
        return recordsTotal;
    }

    public void setRecordsTotal(Integer recordsTotal)
    {
        this.recordsTotal = recordsTotal;
    }

    public Integer getRecordsFiltered()
    {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Integer recordsFiltered)
    {
        this.recordsFiltered = recordsFiltered;
    }

    public ResponseMessage()
    {
        setSuccess(true);
    }

    public ResponseMessage(Page page)
    {
        setSuccess(true);
        setCount(page.getTotalCount());
        setPageIndex(page.getPageNo());
        setPageSize(page.getPageSize());
        setPageCount(page.getTotalPage());
    }
    
    public ResponseMessage(Page page,RequestBase base)
    {
        setSuccess(true);
        setCount(page.getTotalCount());
        setPageIndex(page.getPageNo());
        setPageSize(page.getPageSize());
        setPageCount(page.getTotalPage());
        
        setStart(base.getStart());
        setDraw(base.getDraw());
        setLength(base.getLength());
        setRecordsTotal(page.getTotalCount());
        setRecordsFiltered(page.getTotalCount());
    }

    
    public Integer getPageCount()
    {
        return pageCount;
    }

    public void setPageCount(Integer pageCount)
    {
        this.pageCount = pageCount;
    }

    public Object getUserData()
    {
        return userData;
    }

    public void setUserData(Object userData)
    {
        this.userData = userData;
    }

    public boolean isSuccess()
    {
        return success;
    }

    public void setSuccess(boolean success)
    {
        this.success = success;
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public Object getData()
    {
        return data;
    }

    public void setData(Object data)
    {
        this.data = data;
    }

    public boolean isPage()
    {
        return isPage;
    }

    public void setPage(boolean isPage)
    {
        this.isPage = isPage;
    }

    public Integer getPageIndex()
    {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex)
    {
        this.pageIndex = pageIndex;
    }

    public Integer getPageSize()
    {
        return pageSize;
    }

    public void setPageSize(Integer pageSize)
    {
        this.pageSize = pageSize;
    }

    public Integer getCount()
    {
        return count;
    }

    public void setCount(Integer count)
    {
        this.count = count;
    }

    @Override
    public String toString()
    {
        return "ResponseMessage [success="
               + success
               + ", message="
               + message
               + ", data="
               + data
               + ", isPage="
               + isPage
               + ", pageIndex="
               + pageIndex
               + ", pageSize="
               + pageSize
               + ", pageCount="
               + pageCount
               + ", count="
               + count
               + ", userData="
               + userData
               + ", draw="
               + draw
               + ", start="
               + start
               + ", length="
               + length
               + ", recordsTotal="
               + recordsTotal
               + ", recordsFiltered="
               + recordsFiltered
               + "]";
    }

}
