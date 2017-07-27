package com.lz.common.upload;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;
import org.springframework.stereotype.Component;

/**
 * 文件上传监控
 * 
 * @author liuz@aotian.com
 * @date 2017年7月27日 上午11:30:29
 */
@Component
public class FileUploadProgressListener implements ProgressListener {

	private HttpSession session;

	public void setSession(HttpSession session) {
		this.session = session;
		UploadProcess status = new UploadProcess();// 保存上传状态
		session.setAttribute("status", status);
	}

	@Override
	public void update(long bytesRead, long contentLength, int items) {
		UploadProcess status = (UploadProcess) session.getAttribute("status");
		status.setBytesRead(bytesRead);
		status.setContentLength(contentLength);
		status.setItems(items);
	}

}
