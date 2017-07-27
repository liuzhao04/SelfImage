package com.lz.img.controller;

import java.io.IOException;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.lz.common.message.ResponseMessage;
import com.lz.common.page.Page;
import com.lz.common.upload.InputStreamSaveThread;
import com.lz.common.utils.BackGroupCache;
import com.lz.common.utils.FileUtils;
import com.lz.common.utils.Md5Utils;
import com.lz.img.pojo.ImageInfor;
import com.lz.img.service.IImageService;
import com.lz.img.utils.ImageUploadUtils;
import com.lz.img.utils.PropertiesUtils;

@Controller
@RequestMapping("/image")
@SessionAttributes("UploadProcess")
public class ImageUploadController implements Serializable {
	private static final long serialVersionUID = 4374001474262575313L;

	private static final Logger logger = LoggerFactory.getLogger(ImageUploadController.class);

	@Resource
	private IImageService imageService = null;

	@Autowired
	private PropertiesUtils putils;

	@RequestMapping("/submit.do")
	@ResponseBody
	public ResponseMessage submitImageInfor(@RequestParam("files") List<MultipartFile> files,
			HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		logger.info("Submit Thread Id:" + Thread.currentThread().getId() + " " + this);
		ResponseMessage msg = new ResponseMessage();
		msg.setSuccess(true);
		msg.setCount(files.size());
		msg.setPage(false);

		List<InputStreamSaveThread> ths = new ArrayList<InputStreamSaveThread>();
		List<ImageInfor> infors = new ArrayList<ImageInfor>();
		String batchId = System.currentTimeMillis() + "_" + files.get(0).getOriginalFilename();
		try {
			batchId = Md5Utils.encrpt(batchId);
		} catch (NoSuchAlgorithmException e1) {
		}
		for (MultipartFile file : files) {
			logger.info("文件：" + file.getOriginalFilename() + " - " + file.getSize());
			ImageInfor infor = ImageUploadUtils.parse(file);
			infor.setBatchId(batchId);
			infors.add(infor);
			try {
				String saveUrl = putils.getImageUploadSavePath() + infor.getSaveName();
				infor.setRemoteUrl(putils.getImageRemoteDir() + infor.getSaveName());
				InputStreamSaveThread th = new InputStreamSaveThread(file.getInputStream(), saveUrl);
				ths.add(th);
			} catch (IOException e) {
				e.printStackTrace();
				msg.setSuccess(false);
				msg.setMessage(e.getMessage());
				logger.error("待上传文件提交失败:" + file.getOriginalFilename(), e);
			}
		}
		if (msg.isSuccess()) {
			// 不再缓存进度
			//Map<String, Object> map = new HashMap<String, Object>();
			//map.put(batchId + "image_upload_thread_list", ths);
			//map.put(batchId + "image_upload_image_list", infors);
			//model.addAttribute("UploadProcess", map); 
			
			try {
				for (int i = 0; i < infors.size(); i++) {
					InputStreamSaveThread th = ths.get(i);
					ImageInfor infor = infors.get(i);
					th.save(true); // 同步保存文件
					// 写入数据库
					imageService.insert(infor);
				}
			} catch (Exception e) {
				logger.error("数据写入失败", e);
				msg.setMessage(e.getMessage());
			}
			msg.setData(infors);
		}
		return msg;
	}

	@RequestMapping("/process.do")
	@ResponseBody
	@SuppressWarnings("unchecked")
	@Deprecated
	public synchronized ResponseMessage submitProcess(@RequestParam("batchId") String batchId,
			@ModelAttribute("UploadProcess") Map<String, Object> processData, ModelMap model) {
		logger.info("Process Thread Id:" + Thread.currentThread().getId() + " " + this);
		ResponseMessage msg = new ResponseMessage();
		msg.setSuccess(true);
		List<InputStreamSaveThread> ths = (List<InputStreamSaveThread>) processData
				.get(batchId + "image_upload_thread_list");
		List<ImageInfor> infors = (List<ImageInfor>) processData.get(batchId + "image_upload_image_list");
		if (ths != null && infors != null) {
			boolean uploadFinished = true;
			for (int i = 0; i < infors.size(); i++) {
				InputStreamSaveThread th = ths.get(i);
				ImageInfor infor = infors.get(i);

				infor.setUploadSize(th.getReadedSize());

				// 出错，将错误给前台
				if (th.getError() != null) {
					infor.setError(th.getError());
					continue;
				}

				if (!th.isFinished()) {
					uploadFinished = false;
				} else {
					if (!th.isHasSaveToDB()) {
						try {
							imageService.insert(infor);
							th.setHasSaveToDB(true);
						} catch (Exception e) {
							logger.error("数据写入失败", e);
							th.setHasSaveToDB(false);
							infor.setError(e.getMessage());
							uploadFinished = true;
						}
					}
				}
			}

			msg.setSuccess(uploadFinished);
			msg.setData(infors);

			if (uploadFinished) {
				BackGroupCache.clear(batchId + "image_upload_thread_list");
				BackGroupCache.clear(batchId + "image_upload_image_list");
			}
		}
		return msg;
	}

	@RequestMapping("/initTable.do")
	@ResponseBody
	public ResponseMessage initTable(ImageInfor imageInfor) {
		Page rs = imageService.listByPage(imageInfor);
		ResponseMessage msg = new ResponseMessage(rs);
		msg.setData(rs.getData());
		return msg;
	}

	@RequestMapping("/delImage.do")
	@ResponseBody
	public ResponseMessage delImage(ImageInfor imageInfor) {
		ResponseMessage msg = new ResponseMessage();
		try {
			Page page = imageService.listByPage(imageInfor);
			if (page.getData().size() < 0) {
				msg.setSuccess(false);
				msg.setMessage("指定图片不存在");
				return msg;
			}
			Boolean rs = imageService.delImage(imageInfor);
			msg.setSuccess(rs);
			if (!rs) {
				msg.setMessage("未删除任何数据");
				return msg;
			} else {
				ImageInfor infor = (ImageInfor) page.getData().get(0);
				String error = delImage(infor.getSaveName());
				if (null != error) {
					msg.setSuccess(false);
					msg.setMessage(error);
				}
			}
		} catch (Exception e) {
			logger.error("图片删除失败:" + imageInfor.toString(), e);
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return msg;
	}

	@RequestMapping("/batchDelImage.do")
	@ResponseBody
	public ResponseMessage batchDelImage(@RequestParam("imageIds") String imageIds) {
		ResponseMessage msg = new ResponseMessage();
		String[] imageIdArr = StringUtils.split(imageIds, ",");
		try {
			for (String imageId : imageIdArr) {
				ImageInfor imageInfor = new ImageInfor();
				imageInfor.setImageId(Long.parseLong(imageId));

				Page page = imageService.listByPage(imageInfor);
				if (page.getData().size() < 0) {
					msg.setSuccess(false);
					msg.setMessage("指定图片不存在:"+imageId);
					return msg;
				}
				Boolean rs = imageService.delImage(imageInfor);
				msg.setSuccess(rs);
				if (!rs) {
					msg.setMessage("未删除任何数据:"+imageId);
					return msg;
				} else {
					ImageInfor infor = (ImageInfor) page.getData().get(0);
					String error = delImage(infor.getSaveName());
					if (null != error) {
						msg.setSuccess(false);
						msg.setMessage(error);
					}
				}
			}
		} catch (Exception e) {
			logger.error("图片删除失败:" + imageIds, e);
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return msg;
	}

	private String delImage(String saveName) {
		String path = putils.getImageUploadSavePath() + saveName;
		try {
			if (FileUtils.deleteFile(path)) {
				return null;
			}
			return "服务器删除硬盘文件失败";
		} catch (Exception e) {
			logger.error("硬盘删除文件失败：" + path, e);
			return e.getMessage();
		}
	}
}
