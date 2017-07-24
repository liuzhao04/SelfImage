package com.lz.common.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 分页拦截器
 * 
 * @author liuz@aotian.com
 * @date 2017年7月24日 下午2:54:22
 */
public class PageInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		Page page = Page.threadLocal.get();
		if (page != null) {
			request.setAttribute("page", page);
		}
		Page.threadLocal.remove();
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String pageSize = request.getParameter("pageSize");
		String pageNo = request.getParameter("pageIndex");
		Page page = new Page();
		if (NumberUtils.isNumber(pageSize)) {
			page.setPageSize(NumberUtils.toInt(pageSize));
		}
		if (NumberUtils.isNumber(pageNo)) {
			page.setPageNo(NumberUtils.toInt(pageNo));
		}
		Page.threadLocal.set(page);
		return true;
	}

}