<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%
	String agent = request.getHeader("USER-AGENT");
	String browserName = "None";
	if (null != agent && -1 != agent.indexOf("MSIE")) {
		browserName = "MSIE";
	} else if (null != agent && -1 != agent.indexOf("Firefox")) {
		browserName = "Firefox";
	} else if (null != agent && -1 != agent.indexOf("Safari")) {
		browserName = "Safari";
	} else {
	}
%>

<!-- js 加载 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="ctx" value="${contextPath}" />
<c:set var="browserName" value="<%=browserName%>" />
<c:set var="cssPath" value="${contextPath}/resources/css" />
<c:set var="scriptPath" value="${contextPath}/resources/js" />
<c:set var="imagePath" value="${contextPath}/resources/images" />
<c:set var="jspPath" value="${contextPath}/main" />

<script src="${scriptPath}/jquery/jquery-3.2.1.js" type="text/javascript"></script>
<script src="${scriptPath}/jquery/i18n/grid.locale-cn.js" type="text/javascript"></script>
<script src="${scriptPath}/jquery/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="${scriptPath}/jquery/jquery-ui.min.js" type="text/javascript"></script>
<script src="${scriptPath}/jquery/jquery.serialize.js" type="text/javascript"></script>

<script src="${scriptPath}/ajaxfileupload.js" type="text/javascript"></script>
<script src="${scriptPath}/common/tooltip.js" type="text/javascript"></script>
<script src="${scriptPath}/common/simple-popup-box.js" type="text/javascript"></script>
<script src="${scriptPath}/common/simple-popup-box.js" type="text/javascript"></script>
<script src="${scriptPath}/common/jquery-ui-lz-table.js" type="text/javascript"></script>
<script>var JS_CTX = '${ctx}';</script>

<!-- meta 加载 -->
<%
	//Set no- cache on program  
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Layout Template" content="<%=request.getRequestURL()%>" />
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1" />

<!-- CSS 加载 -->
<link rel="stylesheet" type="text/css" href="${cssPath}/jqgrid/ui.jqgrid.css" />
<%-- <link rel="stylesheet" type="text/css" href="${cssPath}/jqgrid/jquery-ui-1.8.16.custom.css" /> --%>
<link rel="stylesheet" type="text/css" href="${cssPath}/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${cssPath}/jquery-ui/jquery-ui-lz-table.css" />
