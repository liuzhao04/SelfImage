package com.lz.img.pojo;

import java.io.Serializable;

/**
 * 排序实体
 * 
 * @author liuz@aotian.com
 * @date 2017年7月24日 下午3:06:16
 */
public class RequestBase implements Serializable
{
    private static final long serialVersionUID = -2514374592196403309L;

    private String sortName;

    private String sortOrder;
    
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

    public String getSortName()
    {
        return sortName;
    }

    public void setSortName(String sortName)
    {
        this.sortName = sortName;
    }

    public String getSortOrder()
    {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder)
    {
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString()
    {
        return "RequestBase [sortName="
               + sortName
               + ", sortOrder="
               + sortOrder
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
