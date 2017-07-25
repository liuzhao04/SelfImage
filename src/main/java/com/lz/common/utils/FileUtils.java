package com.lz.common.utils;

import java.io.File;

/**
 * 文件工具箱
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class FileUtils
{
    /**
     * 保证指定的文件的父目录存在，不存在时，会尝试创建父路径
     * 
     * @param file
     * @return 如果路径存在问题，则返回false
     */
    public static boolean makeSureParentExist(File file)
    {
        if (file.exists())
        {
            return true;
        }
        File pFile = file.getParentFile();
        if (pFile.exists() && pFile.isDirectory())
        {
            return true;
        }

        if (pFile.exists() && !pFile.isDirectory())
        {
            return false;
        }

        if (pFile.mkdirs())
        {
            return true;
        }
        return false;
    }

    /**
     * 删除文件
     *
     * @param path
     * @return
     */
    public static boolean deleteFile(String path)
    {
        File file = new File(path);
        if (file.exists())
        {
            return file.delete();
        }
        return true;
    }
}
