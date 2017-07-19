<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JQuery Learning Project</title>

<!-- jqGrid组件基础样式包-必要 -->
<link rel="stylesheet" href="resources/css/jqgrid/ui.jqgrid.css" />
<!-- jqGrid主题包-非必要 --> 
<!-- 在jqgrid/css/css这个目录下还有其他的主题包，可以尝试更换看效果 -->
<link rel="stylesheet" href="resources/css/jqgrid/jquery-ui-1.8.16.custom.css" />

<script src="resources/js/jquery/jquery-3.2.1.js"></script>

<!-- jqGrid插件的多语言包-非必要 -->
<!-- 在jqgrid/js/i18n下还有其他的多语言包，可以尝试更换看效果 -->
<script type="text/javascript" src="resources/js/jquery/i18n/grid.locale-cn.js"></script>
<!-- jqGrid插件包-必要 -->
<script type="text/javascript" src="resources/js/jquery/jquery.jqGrid.src.js"></script>

<script src="resources/js/tooltip.js"></script>

<style type="text/css">
.block {
	display: block;
	margin-top: 20px;
	margin-left: 30px;
	margin-right: 30px;
	border: 2px solid lightgrey;
}

.block button {
	margin-top: 10px;
}

.block .title {
	padding: 3px 10px;
	background-color: #aaf;
	margin-bottom: 5px;
	font-size: 12px;
	font-weight: bold;
}

.hiden {
	display: inline-block;
}

.fade {
	display: inline-block;
	width: 80px;
	height: 80px;
}

.fade[bid='1'] {
	background: #f00;
}

.fade[bid='2'] {
	background: #0f0;
}

.fade[bid='3'] {
	background: #00f;
}
</style>

<script type="text/javascript">
	function changeStatus() {
		var $tatus = $('#status');
		$tatus.text("Page load finished.");
		$tatus.css({
			"color" : "#f00"
		});
	}

	$(document).ready(function() {
		setTimeout('changeStatus()', 2000);

		var tip = new ToolTip('ttipTitle', 'ttip','<span>从前冬天冷啊<br>夏天雨呀&nbsp;&nbsp;水呀<br>秋天远处传来你声音&nbsp;&nbsp;暖呀暖呀<br>...</span>');
		tip.bgColor('#000',0.8).color('#fff').timeout(1000).html().fontSize('12pt').register();
		
		// 滑动
		$("#trigger").click(function(){
			  $("#data").slideDown();
		});
		
		aheight = $("#animateBlock .content").height();
		
		tableInit();
	});
	
	function showOrHiden() {
		$("#hideBlock span").toggle(1000, function() {
			//alert("处理完成");
		});
		/* $("#hideBlock span").hide(1000,function(){
			alert("处理完成");
		}); */
		/*  $("#hideBlock span").show(1000,function(){
			alert("处理完成");
		});  */
	}

	function fadeInOrOut() {
		$("#slideBlock .content [bid=1]").fadeOut(10000, function() {
		});
		$("#fadeBlock .content [bid=2]").hide();
		$("#fadeBlock .content [bid=2]").fadeIn(1000, function() {
		});
		$("#fadeBlock .content [bid=3]").fadeToggle(10000, function() {

		});
	}
	
	function slideUp(){
		$("#slideBlock .content").slideUp();
	}
	function slideDown(){
		$("#slideBlock .content").slideDown();
	}
	function slide(){
		$("#slideBlock .content").slideToggle();
	}
	
	function animateStart() {
		$("#animateBlock .content").animate({height:'+=150px'},3000);
		$("#animateBlock .content p").animate({left:'+=300px',top:'+=100px'},3000);
	}
	function animateStop() {
		$("#animateBlock .content").stop();
	}
	function animateReset() {
		$("#animateBlock .content").animate({height:aheight},3000);
		$("#animateBlock .content p").animate({left:'-=300px',top:'-=100px'},3000);
	}
	
	function tableInit(){
		//创建jqGrid组件
		$("#jqgridTab").jqGrid(
				{
					url : 'resources/data/JSONData.json',//组件创建完成之后请求数据的url
					datatype : "json",//请求数据返回的类型。可选json,xml,txt
					colNames : [ 'Inv No', 'Date', 'Client', 'Amount', 'Tax','Total', 'Notes' ],//jqGrid的列显示名字
					colModel : [ //jqGrid每一列的配置信息。包括名字，索引，宽度,对齐方式.....
					             {name : 'id',index : 'id',width : 55}, 
					             {name : 'invdate',index : 'invdate',width : 90}, 
					             {name : 'name',index : 'name asc, invdate',width : 100}, 
					             {name : 'amount',index : 'amount',width : 80,align : "right"}, 
					             {name : 'tax',index : 'tax',width : 80,align : "right"}, 
					             {name : 'total',index : 'total',width : 80,align : "right"}, 
					             {name : 'note',index : 'note',width : 150,sortable : false} 
					           ],
					rowNum : 10,//一页显示多少条
					rowList : [ 10, 20, 30 ],//可供用户选择一页显示多少条
					pager : '#jqgridPage',//表格页脚的占位符(一般是div)的id
					sortname : 'id',//初始化的时候排序的字段
					sortorder : "desc",//排序方式,可选desc,asc
					mtype : "post",//向后台请求数据的ajax的类型。可选post,get
					viewrecords : true,
					caption : "JSON Example"//表格的标题名字
				});
		/*创建jqGrid的操作按钮容器*/
		/*可以控制界面上增删改查的按钮是否显示*/
		$("#jqgridTab").jqGrid('navGrid', '#jqgridPage', {edit : true,add : true,del : true});
	}
</script>
</head>
<body>
	<div>
		<div class="block">
			<div class="title">JS定时器</div>
			<span id="status">Page is loading ...</span>
		</div>
		<div id='hideBlock' class="block">
			<div class="title">隐藏与显示</div>
			<div class="content">
				<span class="hidden">Block to be hidden.</span>
			</div>
			<button onclick="showOrHiden()">隐藏/显示</button>
		</div>
		<div id='fadeBlock' class="block">
			<div class="title">淡入淡出</div>
			<div class="content">
				<span class="fade" bid='1'></span> <span class="fade" bid='2'></span>
				<span class="fade" bid='3'></span>
			</div>
			<button onclick="fadeInOrOut()">淡入/淡出</button>
		</div>
		<div id='toolTipBlock' class="block">
			<div class="title">Tool Tip</div>
			<div class="content">
				<span id="ttipTitle">万物生 - 萨顶顶</span>
			</div>
			<div id='ttip'></div>
		</div>
		<div id='slideBlock' class="block">
			<div class="title">滑动</div>
			<div class="content">
				<p>中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
				<p>中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
				<p>中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
			</div>
			<button onclick='slideDown()'>下滑</button>
			<button onclick='slideUp()'>上滑</button>
			<button onclick='slide()'>滑动</button>
		</div>
		<div id='animateBlock' class="block">
			<div class="title">动画</div>
			<div class="content" style="width:100%;background: rgba(0,200,0,0.7);">
				<p style="position: relative;">中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
				<p style="position: relative;">中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
				<p style="position: relative;">中共中央总书记、国家主席、中央军委主席习近平29日中午乘专机抵达香港，出席将于7月1日举行的庆祝香港回归祖国20周年大会暨香港特别行政区第五届政府就职典礼并视察香港。</p>
			</div>
			<button onclick='animateStart()'>开始</button>
			<button onclick='animateStop()'>停止</button>
			<button onclick='animateReset()'>重置</button>
		</div>
		
		<div id='jqGridBlock' class="block">
			<div class="title">jqGrid Demo</div>
			<div class="content">
				<table id="jqgridTab"></table>
				<div id="jqgridPage"></div>
			</div>
		</div>
	</div>

</body>
</html>