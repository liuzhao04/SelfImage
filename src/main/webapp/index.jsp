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
<script type="text/javascript"
	src="resources/js/jquery/i18n/grid.locale-cn.js"></script>
<script type="text/javascript"
	src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript"
	src="resources/js/jquery/jquery.jqGrid.src.js"></script>
<script type="text/javascript"
	src="resources/js/jquery/jquery-ui.min.js"></script>

<script src="resources/js/tooltip.js"></script>

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
		debugger
		initWidow();
		initUploadGrid($uploadGrid);
	});

	function openImages() {
		alert_sure("打开文件","提示");
	}

	function uploadImages() {
		alert_sure("上传文件","提示");
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
		$( "#dialog" ).dialog({
			autoOpen: false,
			width: 400,
			buttons: [
				{
					text: "确定",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
	}

	function alert_sure(message,title) {
		if (title) {
			$("#dialog").dialog({title:title});
		}
		$("#dialog p").text(message);
		$("#dialog").dialog("open");
	}
	
	function changeImage(name,url) {
		$("#showImage").attr('src',url); 
		$("#showImage").attr('title',name); 
	}
	
	function initUploadGrid($table){
		$table.jqGrid({
			url : 'resources/data/imageData.json',
			mtype : 'POST',
			loadonce : false,
			datatype : 'json',
			shrinkToFit : true,
			rownumbers: true,
			width: 1000,
			colNames : [ '文件名','路径','上传进度','操作','远程路径'],
			colModel : [ 
						 {name : 'name', align : 'center',hidden: false,sortable : false, width: 150},
						 {name : 'localPath', align : 'center',hidden: false,sortable : false, width: 200},
						 {name : 'process', align : 'left',hidden: false,sortable : false, width: 150},
						 {name : 'operator', align : 'center',hidden: false,sortable : false, width: 150},
						 {name : 'remotePath', align : 'center',hidden: true,sortable : false, width: 150}
			           ],
			rowNum : 10,
			rowList : [ 10, 20, 30 ],
			pager : '#uploadGridPager',
			gridview : true,
			postData:{
				//alarmId:'${alarm.alarmId}'
			},
			viewrecords : true,
			jsonReader : {
				root : 'data',
				page : 'page',
				total : 'total',
				records : 'records',
				repeatitems : false,
				userdata: 'userData'
			},
			gridComplete : function() {
				var indexs = $table.jqGrid('getDataIDs');
				for ( var i = 0; i < indexs.length; i++) {
					var rowId = indexs[i];
					var currentRow = $table.jqGrid('getRowData', rowId);
				}
			},
			loadComplete : function() {
				
			},
			onPaging : function(pgButton) {
				var curPage = $table.getGridParam('page'), totalPage = $table
						.getGridParam('lastpage'), pageParam = curPage > totalPage ? totalPage
						: curPage;
				$table.setGridParam({
					page : pageParam
				});
				return true;
			},
			prmNames : {
				page : 'pageIndex',
				rows : 'pageSize',
				sort : 'sortName',
				order : 'sortOrder',
				search : '_search'
			}
		});
		$table.on("click", 'tr[role="row"]', function() {
			var remotePath =  $(this).find('td')[5].title;
			var name =  $(this).find('td')[1].title;
			changeImage(name,remotePath);
			//alert_sure(remotePath);
		})
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
			<img id="showImage" alt="图片展示" src="#" title="请选择需要展示的图片">
			<!-- <fieldset> -->
			<div class="fieldset">
				<!-- <legend>图片上传</legend> -->
				<button id="button-open-images">图片浏览</button>
				<button id="button-upload-images">图片上传</button>
			<!-- </fieldset> -->
			</div>
			<table id="uploadGrid"></table>
			<div id="uploadGridPager"></div>
		</div>
		<div id="tabs-2">
			<h2>图片查询</h2>
		</div>
	</div>
	<div id="dialog" title="系统提示">
		<p></p>
	</div>
</body>
</html>