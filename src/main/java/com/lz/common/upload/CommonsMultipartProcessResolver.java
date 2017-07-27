package com.lz.common.upload;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 文件上传进度条解析器
 * 
 * @author liuz@aotian.com
 * @date 2017年7月27日 上午11:21:55
 */
public class CommonsMultipartProcessResolver extends CommonsMultipartResolver {
	// 注入第二步写的FileUploadProgressListener
	@Autowired
	private FileUploadProgressListener progressListener;

	public void setFileUploadProgressListener(FileUploadProgressListener progressListener) {
		this.progressListener = progressListener;
	}

	@Override
	public MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {
		String encoding = determineEncoding(request);
		FileUpload fileUpload = prepareFileUpload(encoding);
		progressListener.setSession(request.getSession());
		fileUpload.setProgressListener(progressListener);
		try {
			List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
			return parseFileItems(fileItems, encoding);
		} catch (FileUploadBase.SizeLimitExceededException ex) {
			throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
		} catch (FileUploadException ex) {
			throw new MultipartException("Could not parse multipart servlet request", ex);
		}
	}
}
