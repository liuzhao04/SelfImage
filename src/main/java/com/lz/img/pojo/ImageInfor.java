package com.lz.img.pojo;

/**
 * 文件上传信息
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class ImageInfor
{
    private Long imageId;

    private String name;

    private String saveName;

    private Long fileSize;

    private String error; // 上传是否出错

    private Long uploadSize;
    
    private String remoteUrl;
    
    private String batchId; // 上传批次
    
    public String getBatchId()
    {
        return batchId;
    }

    public void setBatchId(String batchId)
    {
        this.batchId = batchId;
    }

    public String getRemoteUrl()
    {
        return remoteUrl;
    }

    public void setRemoteUrl(String remoteUrl)
    {
        this.remoteUrl = remoteUrl;
    }

    public String getError()
    {
        return error;
    }

    public void setError(String error)
    {
        this.error = error;
    }

    public Long getImageId()
    {
        return imageId;
    }

    public void setImageId(Long imageId)
    {
        this.imageId = imageId;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getSaveName()
    {
        return saveName;
    }

    public void setSaveName(String saveName)
    {
        this.saveName = saveName;
    }

    public Long getFileSize()
    {
        return fileSize;
    }

    public void setFileSize(Long fileSize)
    {
        this.fileSize = fileSize;
    }

    public Long getUploadSize()
    {
        return uploadSize;
    }

    public void setUploadSize(Long uploadSize)
    {
        this.uploadSize = uploadSize;
    }

    @Override
    public String toString()
    {
        return "ImageInfor [imageId="
               + imageId
               + ", name="
               + name
               + ", saveName="
               + saveName
               + ", fileSize="
               + fileSize
               + ", error="
               + error
               + ", uploadSize="
               + uploadSize
               + "]";
    }

}
