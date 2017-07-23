package com.lz.common.upload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 输入流保存线程工具
 *
 * @author Administrator
 * @version 1.0, 2017年7月23日
 */
public class InputStreamSaveThread
{
    private Logger logger = LoggerFactory.getLogger(InputStreamSaveThread.class);

    private Thread th;

    private InputStream stream;

    private String path;

    private boolean finished = false;

    private Long readedSize = 0L;

    private String error;
    
    public InputStreamSaveThread(InputStream is, String path)
    {
        this.stream = is;
        this.path = path;

        th = new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                threadRun();
            }
        });
    }
    
    public boolean isFinished() {
        return finished;
    }
    
    public Long getReadedSize() {
        return readedSize;
    }
    
    public String getError() {
        return this.error;
    }
    
    public void save() {
        th.start();
    }

    private void threadRun()
    {
        int length = 4096;
        byte[] bufferd = new byte[length];
        int readLength = -1;
        FileOutputStream fos = null;
        File saveFile = new File(this.path);
        if (!com.lz.common.utils.FileUtils.makeSureParentExist(saveFile))
        {
            this.error = "文件保存失败，路径异常:" + this.path;
            return;
        }
        try
        {
            fos = new FileOutputStream(saveFile);
            while ((readLength = stream.read(bufferd)) != -1)
            {
                readedSize += readLength;
                fos.write(bufferd, 0, readLength);
            }
            fos.flush();
        }
        catch (IOException e)
        {
            logger.error("文件保存失败-" + path, e);
        }
        finally
        {
            finished = true;
            if (stream != null)
            {
                try
                {
                    stream.close();
                }
                catch (IOException e)
                {
                    logger.debug("文件流关闭异常" + path, e);
                }
                stream = null;
            }
            if (fos != null)
            {
                try
                {
                    fos.close();
                }
                catch (IOException e)
                {
                    logger.debug("文件流关闭异常" + path, e);
                }
                fos = null;
            }
        }
    }
}
