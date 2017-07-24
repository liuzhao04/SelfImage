package com.lz.img.controller;

import java.io.IOException;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lz.common.message.ResponseMessage;
import com.lz.common.page.Page;
import com.lz.common.upload.InputStreamSaveThread;
import com.lz.common.utils.BackGroupCache;
import com.lz.common.utils.Md5Utils;
import com.lz.img.pojo.ImageInfor;
import com.lz.img.service.IImageService;
import com.lz.img.utils.ImageUploadUtils;
import com.lz.img.utils.PropertiesUtils;

@Controller
@RequestMapping("/image")
@Scope("session")
public class ImageUploadController implements Serializable
{
	private static final long serialVersionUID = 4374001474262575313L;

	private static final Logger logger = LoggerFactory.getLogger(ImageUploadController.class);

    @Resource
    private IImageService imageService = null;

    @Autowired
    private PropertiesUtils putils;

    @RequestMapping("/submit.do")
    @ResponseBody
    public ResponseMessage submitImageInfor(@RequestParam("files") List<MultipartFile> files,
                                            HttpServletRequest request,
                                            HttpServletResponse response)
    {
    	System.out.println("Submit Thread Id:"+Thread.currentThread().getId()+" "+this);
        ResponseMessage msg = new ResponseMessage();
        msg.setSuccess(true);
        msg.setCount(files.size());
        msg.setPage(false);

        List<InputStreamSaveThread> ths = new ArrayList<InputStreamSaveThread>();
        List<ImageInfor> infors = new ArrayList<ImageInfor>();
        String batchId =  System.currentTimeMillis()+"_"+files.get(0).getOriginalFilename();
        try
        {
            batchId = Md5Utils.encrpt(batchId);
        }
        catch (NoSuchAlgorithmException e1)
        {
        }
        for (MultipartFile file : files)
        {
            logger.info("文件：" + file.getOriginalFilename() + " - " + file.getSize());
            ImageInfor infor = ImageUploadUtils.parse(file);
            infor.setBatchId(batchId);
            infors.add(infor);
            try
            {
                String saveUrl = putils.getImageUploadSavePath() + infor.getSaveName();
                infor.setRemoteUrl(putils.getImageRemoteDir()+infor.getSaveName());
                InputStreamSaveThread th = new InputStreamSaveThread(file.getInputStream(), saveUrl);
                ths.add(th);
            }
            catch (IOException e)
            {
                e.printStackTrace();
                msg.setSuccess(false);
                msg.setMessage(e.getMessage());
                logger.error("待上传文件提交失败:" + file.getOriginalFilename(), e);
            }
        }
        if (msg.isSuccess())
        {
            BackGroupCache.put(batchId+"image_upload_thread_list", ths);
            BackGroupCache.put(batchId+"image_upload_image_list", infors);
            for (InputStreamSaveThread th : ths)
            {
                th.save();
            }
            msg.setData(infors);
        }
        return msg;
    }

    @RequestMapping("/process.do")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public synchronized ResponseMessage submitProcess(@RequestParam( "batchId")String batchId)
    {
    	System.out.println("Process Thread Id:"+Thread.currentThread().getId()+" "+this);
        ResponseMessage msg = new ResponseMessage();
        msg.setSuccess(true);
        List<InputStreamSaveThread> ths = (List<InputStreamSaveThread>)BackGroupCache.get(batchId+"image_upload_thread_list");
        List<ImageInfor> infors = (List<ImageInfor>)BackGroupCache.get(batchId+"image_upload_image_list");
        if (ths != null && infors != null)
        {
            boolean uploadFinished = true;
            for (int i = 0; i < infors.size(); i++)
            {
                InputStreamSaveThread th = ths.get(i);
                ImageInfor infor = infors.get(i);

                infor.setUploadSize(th.getReadedSize());

                // 出错，将错误给前台
                if (th.getError() != null)
                {
                    infor.setError(th.getError());
                    continue;
                }

                if (!th.isFinished())
                {
                    uploadFinished = false;
                } else {
                    if(!th.isHasSaveToDB()) {
                    	try{
                    		imageService.insert(infor);
                    		th.setHasSaveToDB(true);
                    	} catch(Exception e){
                    		logger.error("数据写入失败",e);
                    		th.setHasSaveToDB(false);
                    		infor.setError(e.getMessage());
                    		uploadFinished = true;
                    	}
                    }
                }
            }
            
            msg.setSuccess(uploadFinished);
            msg.setData(infors);
            
            if(uploadFinished) {
                BackGroupCache.clear(batchId+"image_upload_thread_list");
                BackGroupCache.clear(batchId+"image_upload_image_list");
            }
        }
        return msg;
    }
    
    @RequestMapping("/initTable.do")
    @ResponseBody
    public  ResponseMessage initTable(ImageInfor imageInfor,Page page) {
    	/*root : 'data',
		page : 'pageIndex',
		total : 'pageSize',
		records : 'count',
		repeatitems : false,
		userdata : 'userData'*/
			
    	System.out.println(imageInfor);
    	System.out.println(page);
    	Page rs = imageService.list(imageInfor);
    	ResponseMessage msg = new ResponseMessage(rs);
    	msg.setData(rs.getData());
    	System.out.println(msg);
		return msg;
    }
}
