<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/main/common.jsp" flush="true"></jsp:include>
<script src="${scriptPath}/page_upload.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酷比乐图片服务</title>

<style type="text/css">
#wrapper {
	margin: 4px 10px 4px 10px;
}

#wrapper div {
	vertical-align: middle;
}

#naviDiv {
	display: inline-block;
	height: 700px;
}

#bodyDiv {
	display: inline-block;
	height: 700px;
}

body {
	font-family: "Trebuchet MS", sans-serif;
	margin: 50px;
}

.headers {
	margin-top: 2em;
}

.ui-tabs-vertical {
	width: 110em;
}

.ui-tabs-vertical .ui-tabs-nav {
	padding: .2em .1em .2em .2em;
	float: left;
	width: 12em;
}

.ui-tabs-vertical .ui-tabs-nav li {
	clear: left;
	width: 100%;
	border-bottom-width: 1px !important;
	border-right-width: 0 !important;
	margin: 0 -1px .2em 0;
}

.ui-tabs-vertical .ui-tabs-nav li a {
	display: block;
	cursor: pointer;
}

.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active {
	padding-bottom: 0;
	padding-right: .1em;
	border-right-width: 1px;
	border-right-width: 1px;
}

.ui-tabs-vertical .ui-tabs-panel {
	padding: 1em;
	float: right;
	width: 95em;
}

.fieldset{
	margin-bottom: 10px;
}
#showImage {float: right;width:470px;height:300px;}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		var $uploadGrid = $("#uploadGrid");
		initWidow();
		initTestDatas();
	});

	function openImages() {
		SPopupBox.alert("打开文件","提示");
	}

	function uploadImages() {
		SPopupBox.confirm("上传文件","系统提示");
	}

	function initWidow() {
		$("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
		$("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
		$("#tabs ul li a").width($("#tabs ul li").width() - 35);
		$("#button-open-images").button({
			icon : "ui-icon-folder-open",
			showLabel : true
		});
		$("#button-upload-images").button({
			icon : "ui-icon-circle-arrow-n",
			showLabel : true
		});
		$("#button-open-images").click(function() {
			openImages();
		});
		$("#button-upload-images").click(function() {
			uploadImages();
		});
		
	}
	
	function changeImage(name,url) {
		$("#showImage").attr('src',url); 
		$("#showImage").attr('title',name); 
	}
	
</script>
</head>
<body>
	<h1>酷比乐·匹克切</h1>
	<div class="ui-widget">
		<p>
			致力于为全人类提供图片存储服务，但目前先实现为自己服务的小目标！大家好,我是酷比乐，我为我的匹克切代言！
		</p>
	</div>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">来吧匹克切</a></li>
			<li><a href="#tabs-2">我的匹克切</a></li>
		</ul>
		<div id="tabs-1">
			<img id="showImage" alt="无图片" title="请选择需要展示的图片">
			<!-- <fieldset> -->
			<div class="fieldset">
				<!-- <legend>图片上传</legend> -->
				<button id="button-open-images">图片浏览</button>
				<button id="button-upload-images">图片上传</button>
			<!-- </fieldset> -->
			</div>
			<table id="uploadGrid" class="lztable simple">
				<thead>
				<tr><th></th><th>图片文件名</th><th>本地路径</th><th>上传进度</th><th>操作</th></tr>
				</thead>
				<tbody></tbody>
			</table>
			<div id="uploadGridPager"></div>
		</div>
		<div id="tabs-2">
			<h2>图片查询</h2>
		</div>
	</div>
</body>
</html>