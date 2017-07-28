<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/main/common.jsp" flush="true"></jsp:include>
<script src="${scriptPath}/page_upload.js" type="text/javascript"></script>
<script src="${scriptPath}/page_query.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酷比乐图片服务</title>

<style type="text/css">

.process {
	width: 180px;
	height: 10px;
	display: inline-block;
	margin-right: 20px;
}

.img_name {
	width: 200px;
}

.processtxt span {
	width: 80px;
}

.actiontd {
	padding: 0px !important;
}

a:hover {
	cursor: pointer;
}
td a{
	margin-right:4px;
}

#showImageNames {
	width: 300px;
	height: 24px;
}

#parent{width:550px; height:10px; border:2px solid #09F;}
#son{width:0; height:100%; background-color:#09F; text-align:center; line-height:10px; font-size:20px; font-weight:bold;}

#searchFrom input{
width:150px;
}
#searchFrom input #datepickerStart,#searchFrom input #datepickerEnd {
width:200px;
}
.img-ui-imgdetail{
font-size: 14px;
display: inline-block;
}
.img-ui-imgdetail *{
	line-height: 35px;
}
.img-ui-imgdetail span{
	margin-left: 10px;
}
.img-ui-imgdetail input[type='text']{
	width:250px;
	height:23px;
}
.img-ui-imgdetail span[tit='title']{
	display:inline-block;
	width:76px;
}
.img-ui-imgdetail span span[tit='keyword']{
	display: inline-block;
	line-height: 25px;
	margin-bottom: 10px;
}
.img-ui-imgdetail span span[tit='keyword']{
	border: 1px solid #77a;
	margin-left: 0px;
	margin-right: 10px;
	padding-left: 5px;
	padding-right: 5px;
}.img-ui-imgdetail span span[tit='keyword'] span{
	margin-left: 0px;
}
.img-ui-imgdetail input {
	margin-left:10px;
}

</style>

<script type="text/javascript">
    var $process;
    
    $(document).ready(function()
    {
        var $uploadGrid = $("#uploadGrid");
        initWidow();
        $process = new ImgUiProcess("img-upload-process");
        $process.init();
        imageInit();
    });

    function openImages()
    {
        $('#imageOpen').click();
    }

    function uploadImages()
    {
    	var val = $("#showImageNames").val();
    	if( val == '') {
    		SPopupBox.alert("请选择图片文件！");
    		return;
    	}
        var formData = new FormData($("#uploadImagesForm")[0]);
        $.ajax(
        {
            url : "image/submit.do",
            type : "post",
            data : formData,
            processData : false,
            contentType : false,
            dataType : "json",
            success : function(rs)
            {
                if (rs.success)
                {
                	SPopupBox.alert_callback("成功上传：" + rs.data.length+"张图片",undefined,clearFileInput);
                }
                else
                {
                    SPopupBox.alert("上传失败：" + rs.message);
                }
            },
            error : function(e)
            {
                SPopupBox.alert("服务器异常");
            },
            xhr : function() {
            	var xhr = $.ajaxSettings.xhr();
				if(onprogress && xhr.upload) {
					xhr.upload.addEventListener("progress" , onprogress, false);
					return xhr;
				}
            }
        });
    }
    
    function clearFileInput() {
    	$("#uploadImagesForm")[0].reset();
    	$("#showImageNames").val("");
    	$process.init();
    	reloadQueryGrid();
    }
    
   	// 上传进度处理
    function onprogress(evt) {
    	$process.init();
    	$process.updateProcess(evt.loaded,evt.total);
    }

    
    function initWidow()
    {
    	$( "#accordion" ).accordion( {
    	      heightStyle: "fill"
        });
        $("#button-open-images").button(
        {
            icon : "ui-icon-folder-open",
            showLabel : true
        });
        $("#button-upload-images").button(
        {
            icon : "ui-icon-circle-arrow-n",
            showLabel : true
        });
        $("#button-open-images").click(function()
        {
            openImages();
        });
        $("#button-upload-images").click(function()
        {
            uploadImages();
        });
        $('#imageOpen').on('change', function()
        {
            var t_files = this.files;
            var fileNames = new Array(t_files.length);
            $.each(t_files, function(i, file)
            {
                fileNames[i] = '"' + file.name + '"';
            });
            $("#showImageNames").val(fileNames.join(','));
        });
        
        $("#remoteUrlSpan").css("opacity",0.0);
        
        // 页面切换时，重新加载数据
        $("#queryImageMenu").on('click',function(){
            reloadQueryGrid();
        });
    }
    
    function clearInput(id) {
    	$("#"+id).val(null);
    }
</script>
</head>
<body>
	<h1>酷比乐·匹克切</h1>
	<div class="ui-widget">
		<p>致力于为全人类提供图片存储服务，但目前先实现为自己服务的小目标！大家好,我是酷比乐，我为匹克切代言！</p>
	</div>
	<hr>
	<div class="img-ui-panel">
		<div class="img-ui-panel-item panel-west">
			<div id="accordion" class="full line-item">
				<h6>上传</h6>
				<div>
					<div class="searchArea">
						<button id="button-open-images" class="serarch-title">图片浏览</button>
						<input type="text" id="showImageNames" readonly="true" />
						<button id="button-upload-images">图片上传</button>
						<br>
						<div id="img-upload-process" class="img-ui-process serarch-title">
							<span class="process-bar"></span>
							<span class="process-percent"></span>
							<span class="process-describe"></span>
						</div>
					</div>
					<form id="uploadImagesForm"
						enctype="multipart/form-data">
						<input type="file" id="imageOpen" name="files" accept="image/*"  style="display: none;" multiple="multiple"/>
					</form>
				</div>
				<h6>查询</h6>
				<div>
					<div id="searchArea" class="searchArea">
						<form id="searchFrom">
							<label>起始时间:</label><input id="datepickerStart" name="timeStart" type="text">
							<sub><a onclick="clearInput('datepickerStart')" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-trash"></span></a></sub>
							<label>结束时间:</label><input id="datepickerEnd" name="timeEnd" type="text">
							<sub><a onclick="clearInput('datepickerEnd')" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-trash"></span></a></sub>
							<label>图片名称:</label><input name="name" type="text">
							<span class="button serarch-title" id="button-search-images">查询</span>
						</form>
					</div>
				</div>
			</div>
			
			<table id="queryGrid" class="full line-item"></table>
			<div id="queryGridPager"></div>
		</div>
		<div class="img-ui-panel-item panel-east">
				<div class="img-ui-img-border line-item" title="请选择需要展示的图片" >
					<img id="showImageQuery" /><%-- src="${imagePath}/default_img_02.png" --%>
				</div>
				<div id="imageTitle" class="line-item img-ui-fold-title">
					<span tit="icon"></span><span tit="title"></span>
				</div>
				<div id="detailPanel" class="line-item searchArea" style="display: none;">
					<div id="item-link" class="img-ui-imgdetail">
						<span tit="title">图片链接：</span><input type="text" readonly="readonly"/><span title="复制链接" tit="icon" class="ui-state-default ui-corner-all ui-icon ui-icon-copy img-ui-cursor-pointer" onclick="copyUrl()"></span>
					</div>
					<div id="item-label" class="img-ui-imgdetail">
						<span tit="title">关键词：</span><span tit="keywords"></span>
					</div>
				</div>
		</div>
		<div class="img-ui-panel-item panel-bottom">
			<div class="footer">
			<p>Copyright &copy;2008 酷比乐·匹克切 Powered By simage Version 1.0.0</p>
			</div>
		</div>
	</div>
	<span id="remoteUrlSpan"></span>
</body>
</html>