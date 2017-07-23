package com.lz.img.utils;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

/**
 * 配置文件工具
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
@Component
public class PropertiesUtils
{
    /*
     * @Value("#{settings['']}") public String UPLOAD_PATH = "upload.dir";
     * 
     * @Value("#{settings['upload.imageDir']}") public String UPLOAD_IMAGE_PATH;
     */
    public String UPLOAD_PATH = "upload.dir";

    public String UPLOAD_IMAGE_PATH = "upload.imageDir";

    @Resource(name = "settings")
    private Properties prop;

    /**
     * 图片上传保存路径
     *
     * @return
     * @throws IOException
     */
    public String getImageUploadSavePath()
    {
        return get(UPLOAD_PATH) + File.separator + get(UPLOAD_IMAGE_PATH) + File.separator;
    }

    /**
     * 获取配置文件中的值
     *
     * @param key
     * @return
     * @throws IOException
     */
    public String get(String key)
    {
        return prop.getProperty(key);
    }

    /**
     * 图片远程目录
     *
     * @return
     */
    public String getImageRemoteDir()
    {
        return File.separator + prop.getProperty(UPLOAD_IMAGE_PATH) + File.separator;
    }
}
