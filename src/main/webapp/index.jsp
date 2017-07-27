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

.showImage {
	height: 300px;
}

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

</style>

<script type="text/javascript">
    var $process;
    
    $(document).ready(function()
    {
        var $uploadGrid = $("#uploadGrid");
        initWidow();
        $process = new ImgUiProcess("img-upload-process");
        $process.init();
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
    }
    
   	// 上传进度处理
    function onprogress(evt) {
    	$process.init();
    	$process.updateProcess(evt.loaded,evt.total);
    }

    
    function initWidow()
    {
    	$( "#accordion" ).accordion();
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
						<button id="button-open-images">图片浏览</button>
						<input type="text" id="showImageNames" readonly="true" />
						<button id="button-upload-images">图片上传</button>
						<br>
						<div id="img-upload-process" class="img-ui-process">
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
							<label>起始时间:</label><input id="datepickerStart" name="timeStart" type="text" width="40">
							<label>结束时间:</label><input id="datepickerEnd" name="timeEnd" type="text" width="40">
							<label>图片名称:</label><input name="name" type="text" width="40">
							<span class="button" id="button-search-images">查询</span>
						</form>
					</div>
				</div>
			</div>
			
			<table id="queryGrid" class="full line-item"></table>
			<div id="queryGridPager"></div>
		</div>
		<div class="img-ui-panel-item panel-east">
				<img id="showImageQuery" class="line-item showImage" alt="无图片" title="请选择需要展示的图片"/><%-- src="${imagePath}/default_img_02.png" --%>
		</div>
		<div class="img-ui-panel-item panel-bottom">
		</div>
	</div>
	<span id="remoteUrlSpan"></span>
</body>
</html>