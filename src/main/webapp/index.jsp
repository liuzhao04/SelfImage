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
<link rel="stylesheet" href="resources/css/jqgrid/jquery-ui-1.8.16.custom.css" />
<link rel="stylesheet" href="resources/css/jquery-ui/jquery-ui.min.css" />

<script type="text/javascript" src="resources/js/jquery/jquery-3.2.1.js"></script>
<script type="text/javascript" src="resources/js/jquery/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="resources/js/jquery/jquery-ui.min.js"></script>

<script src="resources/js/tooltip.js"></script>
	
<style type="text/css">

/* #wrapper {margin: 4px 10px 4px 10px;}
#wrapper div{vertical-align:bottom;}
#wrapper div {vertical-align:bottom;}

#imgListDiv {display: inline-block; height:900px;}

#imgImportDiv {display: inline-block; height:900px;}
 */
body{
		font-family: "Trebuchet MS", sans-serif;
		margin: 50px;
	}
	.demoHeaders {
		margin-top: 2em;
	}
	#dialog-link {
		padding: .4em 1em .4em 20px;
		text-decoration: none;
		position: relative;
	}
	#dialog-link span.ui-icon {
		margin: 0 5px 0 0;
		position: absolute;
		left: .2em;
		top: 50%;
		margin-top: -8px;
	}
	#icons {
		margin: 0;
		padding: 0;
	}
	#icons li {
		margin: 2px;
		position: relative;
		padding: 4px 0;
		cursor: pointer;
		float: left;
		list-style: none;
	}
	#icons span.ui-icon {
		float: left;
		margin: 0 4px;
	}
	.fakewindowcontain .ui-widget-overlay {
		position: absolute;
	}
	select {
		width: 200px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		//initWidow();
		$( "#accordion" ).accordion();
		
		var availableTags = [
			"ActionScript",
			"AppleScript",
			"Asp",
			"BASIC",
			"C",
			"C++",
			"Clojure",
			"COBOL",
			"ColdFusion",
			"Erlang",
			"Fortran",
			"Groovy",
			"Haskell",
			"Java",
			"JavaScript",
			"Lisp",
			"Perl",
			"PHP",
			"Python",
			"Ruby",
			"Scala",
			"Scheme"
		];
		$( "#autocomplete" ).autocomplete({
			source: availableTags
		});
	});
	
	
	function initWidow() {
		var width = $(document.body).width();
		var mergeWidth = 32;
		var importWidth = width * 0.35;
		var bodyWidth = width - mergeWidth - importWidth;
		$("#imgImportDiv").css("width", importWidth + "px");
		$("#imgListDiv").css("width", bodyWidth + "px");
	}
</script>
</head>
<body>
			<h1>酷比乐图片私服</h1>
<div class="ui-widget">
	<p>This page demonstrates the widgets and theme you selected in Download Builder. Please make sure you are using them with a compatible jQuery version.</p>
</div>

<h1>YOUR COMPONENTS:</h1>
			<h2 class="demoHeaders">Accordion</h2>
			<div id="accordion">
				<h3>First</h3>
				<div>Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.</div>
				<h3>Second</h3>
				<div>Phasellus mattis tincidunt nibh.</div>
				<h3>Third</h3>
				<div>Nam dui erat, auctor a, dignissim quis.</div>
			</div>
			
			<h2 class="demoHeaders">Autocomplete</h2>
<div>
	<input id="autocomplete" title="type &quot;a&quot;">
</div>
	<!-- <div id="wrapper">
		</div>
		<div id="imgListDiv">
		<div id="imgImportDiv">
			<span id="title"><strong>图片上传</strong></span>
		</div>
	</div> -->
</body>
</html>