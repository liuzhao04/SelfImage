<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<c:set var="imageSubmitUrl" value="image/submit.do" scope="page"/>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/main/common.jsp" flush="true"></jsp:include>

<link href="${bootstrapCssPath}/bootstrap.min.css" rel="stylesheet">
<link href="${bootstrapCssPath}/animate.min.css" rel="stylesheet">
<link href="${bootstrapCssPath}/custom.css" rel="stylesheet">
<link href="${bootstrapCssPath}/maps/jquery-jvectormap-2.0.1.css" rel="stylesheet" />
<link href="${bootstrapCssPath}/icheck/flat/green.css" rel="stylesheet" />
<link href="${bootstrapCssPath}/floatexamples.css" rel="stylesheet" />

<link href="${fontPath}/css/font-awesome.min.css" rel="stylesheet">

<script src="${bootstrapScriptPath}/bootstrap.min.js"></script>
<script src="${bootstrapScriptPath}/nprogress.js"></script>
<script src="${bootstrapScriptPath}/progressbar/bootstrap-progressbar.min.js"></script>
<script src="${bootstrapScriptPath}/nicescroll/jquery.nicescroll.min.js"></script>
<script src="${bootstrapScriptPath}/dropzone/dropzone.js"></script>
<script src="${bootstrapScriptPath}/notify/pnotify.core.js"></script>
<script src="${bootstrapScriptPath}/notify/pnotify.buttons.js"></script>
<script src="${bootstrapScriptPath}/notify/pnotify.nonblock.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bootstrap基本学习</title>

<style type="text/css">

</style>

<script type="text/javascript">
	$(document).ready(function() {
	    initUploadPanel();
	    initQueryPanel();
	});
	
	function initUploadPanel() {
	    Dropzone.options.dropzoneForm = {
			uploadMultiple: true,
			maxFiles : 5,
			maxFilesize : 20,
			parallelUploads : 5, // 每次上传5个，不指定，默认一次只能上传2张
			paramName : 'files',
			acceptedFiles : "image/*",
			autoProcessQueue: false, // 禁止自动上传
			init: function() {
				var submitButton = document.querySelector("#submit-all"); // 定义上传按钮
				var resetButton = document.querySelector("#reset-all"); // 定义上传按钮
				myDropzone = this; // closure
				submitButton.addEventListener("click", function() {
				 	myDropzone.processQueue(); 
				});
				// 添加一个文件时触发
			  	this.on("addedfile", function(file) {
			  		var count = 0;
			  		$.each(myDropzone.files,function(i,ifile){
			  			if(file.name == ifile.name) {
			  				count++;
			  			}
			  		});
			  		
			  		if(count > 1) {
			  			// 发送消息提示
		  				new PNotify({
                            title: 'Warning',
                            text: '不能导入同名文件：'+file.name,
                            type: 'info'
                        });
		  				// 删除当前文件
		  				myDropzone.removeFile(file);
		  				return;
			  		}
			  		
			  		// 为张选择的图片添加一个删除按钮
			        var removeButton = Dropzone.createElement('<span class="img-ui-cursor-pointer glyphicon glyphicon-remove" aria-hidden="true" style="float:right;"></span>');
			        var _this = this;
			        removeButton.addEventListener("click", function(e) {
			          e.preventDefault();
			          e.stopPropagation();
			          _this.removeFile(file);
			        });
			        $(file.previewElement).append(removeButton);
			  	});
				// 文件数量超过上限
				this.on("maxfilesexceeded", function(file) {
					new PNotify({
                        title: 'Warning',
                        text: '最多选择5个文件：'+file.name,
                        type: 'info'
                    });
					myDropzone.removeFile(file); // 删除已超过上限的文件
			  	});
				// 
				this.on("complete", function(file) {
					// 完成时，删除'删除按钮'
					$(file.previewElement).find(".glyphicon-remove").remove();
			  	});
				this.on("successmultiple", function(files,res) {
					loadImages(res.data);
			  	});
			  	
			  	// 清空事件定义
			  	$(resetButton).click(function(){
			  		myDropzone.removeAllFiles(true); // 清空图片
			  	});
			}
		};
	}
	
	function initQueryPanel(){
	    var startDateTextBox = $('#datepickerStart');
		var endDateTextBox = $('#datepickerEnd');
		//$.timepicker.setDefaults({controlType: myControl});
		$.timepicker.datetimeRange(
			startDateTextBox,
			endDateTextBox,
			{
				minInterval: (1000*60*60), // 1hr
				dateFormat: 'yy-mm-dd', 
				timeFormat: 'HH:mm:ss',
				start: {showSecond:true}, // start picker options
				end: {
					showSecond:true,
				}
			}
		);
	}
	
	var g_imgs;
	var g_img_src; // 0-从上传结果中加载；1-从查询结构中加载
	function loadImages(imgs) {
		g_imgs = imgs;
		var $showPanel = $("#slidershow");
		$showPanel.find(".carousel-indicators").children().remove(); // 清空之前的内容
		$showPanel.find(".carousel-inner").children().remove(); 
		var indicatorsHtml = "",innerHtml = "";
		$.each(imgs,function(i,img){
			if(i == 0) {
				indicatorsHtml +=  '<li class="active" data-target="#slidershow" data-slide-to="'+i+'"></li>';
				innerHtml +=  '<div class="item active">' +
									 '<a href="##"><img id="img_slider_item_'+i+'" style="height: 400px;" src="'+img.remoteUrl+'"></a>'+
									 '<div class="carousel-caption">'+
									 '	 <h3>'+img.name+'</h3>'+
									 '	 <p></p>'+
								 	 '</div>'+
								 '</div>';
			}else{
				indicatorsHtml +=  '<li data-target="#slidershow" data-slide-to="'+i+'"></li>';
				innerHtml +=  '<div class="item">' +
									 '<a href="##"><img id="img_slider_item_'+i+'" style="height: 400px;" src="'+img.remoteUrl+'"></a>'+
									 '<div class="carousel-caption">'+
									 '	 <h3>'+img.name+'</h3>'+
									 '	 <p></p>'+
								 	 '</div>'+
								 '</div>';
			}			
		});
		$showPanel.find(".carousel-indicators").append(indicatorsHtml);
		$showPanel.find(".carousel-inner").append(innerHtml);
		
		// 修改图片尺寸
		$.each(imgs,function(i,img) {
			fitImgSize('img_slider_item_'+i);
		});
	}
	
	// 修改图片尺寸
	function fitImgSize(imgId){
		var $img = $("#"+imgId);
		debugger
		$img.on("load",function(aa,bb,cc){
			var img = new Image();
			img.src =$(this)[0].src;
			var parentImage = $(this);
			img.onload = function() {
				var width_ = 800;
				var height_ = 400 ;
				var width = img.width;
				var height = img.height;
				var wh = fitSize(width_,height_,width,height);
				$img[0].width = wh[0];
				$img[0].height = wh[1];
	        }
			function fitSize(widthDst,heightDst,widthImg,heightImg) {
				var tw = widthImg / widthDst;
				var th = heightImg / heightDst;
				var maxFactor = tw > th ? tw : th;
				var rs = new Array();
				rs[0] = widthImg / maxFactor;
				rs[1] = heightImg / maxFactor;
				return rs;
			} 
		});
	}
</script>
<!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>
<body class="nav-md">
	<script type="text/javascript">
		NProgress.start();
	</script>
	
	<div class="container body">
		<div class="main_container">

			<!-- 菜单栏 -->
            <div class="col-md-3 left_col">
                <div class="left_col scroll-view">

                    <div class="navbar nav_title" style="border: 0;">
                        <a href="bootstrap.jsp" class="site_title"><i class="fa fa-photo"></i> <span>酷比乐·匹克切</span></a>
                    </div>
                    <div class="clearfix"></div>

                    <!-- menu prile quick info -->
                    <div class="profile">
                        <div class="profile_pic">
                            <img src="resources/images/img.jpg" alt="..." class="img-circle profile_img">
                        </div>
                        <div class="profile_info">
                            <span>Welcome,</span>
                            <h2>System User</h2>
                        </div>
                    </div>
                    <!-- /menu prile quick info -->

                    <br />

                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

                        <div class="menu_section">
                             <h3>导航栏</h3> 
                            <ul class="nav side-menu">
                                <li><a><i class="fa fa-home"></i> 图片管理 <span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                        <li><a href="picture_manage.jsp">图片管理</a>
                                        </li>
                                    </ul>
                                </li>
                                <li><a><i class="fa fa-home"></i> Markdown管理<span class="fa fa-chevron-down"></span></a>
                                    <ul class="nav child_menu" style="display: none">
                                       
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- /sidebar menu -->

                    <!-- /menu footer buttons -->
                    <div class="sidebar-footer hidden-small">
                        <a data-toggle="tooltip" data-placement="top" title="Settings">
                            <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                            <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="Lock">
                            <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
                        </a>
                        <a data-toggle="tooltip" data-placement="top" title="Logout">
                            <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                        </a>
                    </div>
                    <!-- /menu footer buttons -->
                </div>
            </div>
            
            <!-- 顶部菜单栏 -->
             <div class="top_nav">
                <div class="nav_menu">
                    <nav class="" role="navigation">
                        <div class="nav toggle">
                            <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                        </div>

                        <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                    <img src="resources/images/img.jpg" alt="">John Doe
                                    <span class=" fa fa-angle-down"></span>
                                </a>
                                <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                                    <li><a href="login.html"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            
            <div class="right_col" role="main">
				<div class="">
					<div class="page-title">
                        <div class="title_left">
                            <h3>图片管理</h3>
                        </div>
                    </div>
              	</div>
              
              	<div class="row">
              		<div class="col-md-12 col-sm-12 col-xs-12">
	                	<div class="x_panel">
	                      <div class="x_title">
	                          <h2>上传<small>来吧,我的匹克切！</small></h2>
	                          <ul class="nav navbar-right panel_toolbox">
	                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                              </li>
	                          </ul>
	                          <div class="clearfix"></div>
	                      </div>
	                      <div class="x_content">
	                          <p>支持多文件上传，可拖拽要上传的文件，或单击选择文件</p>
	                          <form id="dropzoneForm" action="${imageSubmitUrl}" class="dropzone" style="border: 1px solid #e5e5e5; height: 200px; padding: 24px 24px;">
	                          </form>
	                          <span id="submit-all" class="btn btn-primary left" style="margin-top: 20px;">上 传</span>
	                          <span id="reset-all" class="btn btn-primary left" style="margin-top: 20px;">清 空</span>
	                      </div>
	                  	</div>
	                 </div>
	             </div>
	             <div class="row">
	             	<div class="col-md-12 col-sm-12 col-xs-12">
	                	<div class="x_panel">
	                      <div class="x_title">
	                          <h2>预览<small></small></h2>
	                          <ul class="nav navbar-right panel_toolbox">
	                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                              </li>
	                          </ul>
	                          <div class="clearfix"></div>
	                      </div>
	                      <div class="x_content">
	                      		<span class="img-alpha-background"></span>
	                      		<div id="slidershow" class="carousel slide col-md-6 col-sm-12 col-xs-6" data-ride="carousel">
									 <!-- 设置图片轮播的顺序 -->
									 <ol class="carousel-indicators">
										 <li class="active" data-target="#slidershow" data-slide-to="0"></li>
									 </ol>
									 <!-- 设置轮播图片 -->
									 <div class="carousel-inner">
										 <div class="item active">
											 <a href="##"><img style="height: 300px;display: inline-block;"></a>
											 <div class="carousel-caption">
												 <h3></h3>
												 <p></p>
										 	 </div>
										 </div>
									 </div>
									 <!-- 设置轮播图片控制器 -->
									 <a class="left carousel-control" href="#slidershow" role="button" data-slide="prev">
									 	<span class="glyphicon glyphicon-chevron-left"></span>
									 </a>
									 <a class="right carousel-control" href="#slidershow" role="button" data-slide="next">
									 	<span class="glyphicon glyphicon-chevron-right"></span>
									 </a>
								</div>
	                      </div>
	                	</div>
	                </div>
	             </div>
	             <div class="row">
              		<div class="col-md-6 col-sm-12 col-xs-6">
	                	<div class="x_panel">
	                      <div class="x_title">
	                          <h2>查询<small>我的匹克切，你们在哪？</small></h2>
	                          <ul class="nav navbar-right panel_toolbox">
	                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                              </li>
	                          </ul>
	                          <div class="clearfix"></div>
	                      </div>
	                      <div class="x_content">
	                      	<br>
									<form id="searchFrom" class="form-horizontal form-label-left input_mask">
                                        <div class="col-md-6 col-sm-12 col-xs-6 form-group has-feedback">
                                            <input type="text" class="form-control has-feedback-left" id="datepickerStart" placeholder="起始时间">
                                            <span class="fa fa-calendar form-control-feedback left" aria-hidden="true"></span>
                                        </div>
                                        <div class="col-md-6 col-sm-12 col-xs-6 form-group has-feedback">
                                            <input type="text" class="form-control" id="datepickerEnd" placeholder="结束时间">
                                            <span class="fa fa-calendar form-control-feedback right" aria-hidden="true"></span>
                                        </div>
										<div class="col-md-6 col-sm-12 col-xs-6 form-group has-feedback">
                                            <input type="text" class="form-control has-feedback-left" id="datepickerEnd" placeholder="图片名称">
                                            <span class="fa fa-wordpress form-control-feedback left" aria-hidden="true"></span>
                                        </div>
                                        <div class="col-md-2 col-sm-4 col-xs-2 form-group has-feedback">
                                            <Button class="fa fa-search form-control right btn btn-primary" id="queryBtn">&nbsp;&nbsp;查  询</Button>
                                        </div>
									</form>
	                      </div>
	                  	</div>
	                 </div>
	                 
	             </div>
              		
              	<div class="clearfix"></div>
              	<!-- footer content -->
	         	<footer>
		             <div class="">
		                 <p class="pull-right">Gentelella Alela! a Bootstrap 3 template by <a>Kimlabs</a>. |
		                     <span class="lead"> <i class="fa fa-paw"></i> Gentelella Alela!</span>
		                 </p>
		             </div>
		             <div class="clearfix"></div>
	         	</footer>
       	</div>
	</div>
	
	<!-- 顶部进度条 -->
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>
	
		
	</div>
	<script src="${bootstrapScriptPath}/custom.js"></script>
	<script>
		NProgress.done();
	</script>
</body>

</html>