<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酷比乐图片服务</title>

<!-- jqGrid组件基础样式包-必要 -->
<link rel="stylesheet" href="resources/css/jqgrid/ui.jqgrid.css" />
<!-- jqGrid主题包-非必要 -->
<!-- 在jqgrid/css/css这个目录下还有其他的主题包，可以尝试更换看效果 -->
<!-- <link rel="stylesheet" href="resources/css/jqgrid/jquery-ui-1.8.16.custom.css" /> -->
<link rel="stylesheet" href="resources/css/jquery-ui/jquery-ui.min.css" />

<script type="text/javascript" src="resources/js/jquery/jquery-3.2.1.js"></script>
<script type="text/javascript" src="resources/js/jquery/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery-ui.min.js"></script>

<script src="resources/js/tooltip.js"></script>
	
<style type="text/css">
	#wrapper {margin: 4px 10px 4px 10px;}
	#wrapper div{vertical-align:middle;}
	#naviDiv {display: inline-block; height:700px;}
	#bodyDiv {display: inline-block; height:700px;}
	body{
		font-family: "Trebuchet MS", sans-serif;
		margin: 50px;
	}
	.headers {
		margin-top: 2em;
	}
	
  .ui-tabs-vertical { width: 100em; }
  .ui-tabs-vertical .ui-tabs-nav { padding: .2em .1em .2em .2em; float: left; width: 12em; }
  .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; }
  .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
  .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; border-right-width: 1px; }
  .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 85em;}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		//$( "#selectable" ).selectable();
		//$( "#tabs" ).tabs();
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	    $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
		initWidow();
	});
	
	
	function initWidow() {
		$("#tabs ul li a").width($("#tabs ul li").width());
	}
</script>
</head>
<body>
	<h1>酷比乐图片私服</h1>
	<div class="ui-widget">
		<p>致力于为全人类提供图片存储服务，但现阶段先努力为自己服务！</p>
	</div>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">图片上传</a></li>
			<li><a href="#tabs-2">图片查询</a></li>
		</ul>
		<div id="tabs-1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>
		<div id="tabs-2">Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.</div>
	</div>
		
	
</div>
</body>
</html>