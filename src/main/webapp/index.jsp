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

.fieldset {
	margin-bottom: 10px;
}

img {
	border: 3px solid #eeeeff;
}

.showImage {
	float: right;
	width: 470px;
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
    var timer;
    $(document).ready(function()
    {
        var $uploadGrid = $("#uploadGrid");
        initWidow();
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
                    init(rs.data);
                    timer = setInterval('getStatus("'+rs.data[0].batchId+'")', 200); // 启动进度监控
                }
                else
                {
                    SPopupBox.alert("上传失败：" + rs.message);
                }
            },
            error : function(e)
            {
                SPopupBox.alert("上传失败：" + e);
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
    
   
   	// 上传进度处理
    function onprogress(evt) {
   		debugger
    	var loaded = evt.loaded;     //已经上传大小情况 
    	var tot = evt.total;      	 //附件总大小 
    	var per = Math.floor( 100 * loaded / tot);  
    	$("#son").html( per +"%" );
    	$("#son").css("width" , per +"%");
    }

    function getStatus(batchId)
    {
       	var postData = new Object();
       	postData.batchId = batchId;
        $.ajax(
        {
            url : "image/process.do",
            type : "post",
            dataType : "json",
            data : postData ,
            success : function(rs)
            {
                if (rs.success)
                {
                    process(rs.data);
                    window.clearInterval(timer);
                	if(rs.error) {
                		SPopupBox.alert("服务器异常："+rs.error);
                	}
                }
                else
                {
                    process(rs.data); // 更新进度
                }
            },
            error : function(e)
            {
                SPopupBox.alert("上传中出现异常：" + e);
            }
        });
    }

    function initWidow()
    {
        $("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
        $("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
        $("#tabs ul li a").width($("#tabs ul li").width() - 35);
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
        
        initUploadForm();
    }
</script>
</head>
<body>
	<h1>酷比乐·匹克切</h1>
	<div class="ui-widget">
		<p>致力于为全人类提供图片存储服务，但目前先实现为自己服务的小目标！大家好,我是酷比乐，我为匹克切代言！</p>
	</div>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">来吧匹克切</a></li>
			<li><a id="queryImageMenu" href="#tabs-2">我的匹克切</a></li>
		</ul>
		<div id="tabs-1">
			<img id="showImage" class="showImage" alt="无图片" title="请选择需要展示的图片"
				src="${imagePath}/default_img_02.png">
			<!-- <fieldset> -->
			<div class="fieldset">
				<!-- <legend>图片上传</legend> -->
				<button id="button-open-images">图片浏览</button>
				<input type="text" id="showImageNames" readonly="true" />
				<button id="button-upload-images">图片上传</button>
				<!-- </fieldset> -->
			</div>
			<table id="uploadGrid" class="lztable simple">
				<thead>
					<tr>
						<th></th>
						<th>图片文件名</th>
						<!-- <th>本地路径</th> -->
						<th>上传进度</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<form id="uploadImagesForm"
				enctype="multipart/form-data">
				<input type="file" id="imageOpen" name="files" accept="image/*"
					multiple='multiple'  style="display: none;" />
			</form>
		</div>
		<div id="tabs-2">
			<img id="showImageQuery" class="showImage" alt="无图片" title="请选择需要展示的图片"
				src="${imagePath}/default_img_02.png">
			<div id="searchArea" class="searchArea">
				<form id="searchFrom">
					<label>起始时间:</label><input id="datepickerStart" name="timeStart" type="text" width="40">
					<label>结束时间:</label><input id="datepickerEnd" name="timeEnd" type="text" width="40">
					<label>图片名称:</label><input name="name" type="text" width="40">
					<span class="button" id="button-search-images">查询</span>
				</form>
			</div>
			<table id="queryGrid"></table>
			<div id="queryGridPager"></div>
		</div>
	</div>
	<span id="remoteUrlSpan"></span>
</body>
</html>