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

<script src="${bootstrapScriptPath}/jquery.min.js"></script>
<script src="${bootstrapScriptPath}//bootstrap.min.js"></script>
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
		Dropzone.options.dropzoneForm = {
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
				  	
				  	// 清空事件定义
				  	$(resetButton).click(function(){
				  		myDropzone.removeAllFiles(true); // 清空图片
				  	});
				}
		};

		/* $("#dropzoneForm").dropzone({
			maxFiles : 5,
			maxFilesize : 20,
			paramName : 'files',
			acceptedFiles : "image/*",
		}); */
	});
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
	                          <h2>图片上传<small>来吧,我的匹克切！</small></h2>
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
	                          <span id="reset-all" class="btn btn-primary right" style="margin-top: 20px;">清 空</span>
	                          <span id="submit-all" class="btn btn-primary right" style="margin-top: 20px;">提 交</span>
	                      </div>
	                  	</div>
	                 </div>
	             </div>
	             <div class="row">
              		<div class="col-md-12 col-sm-12 col-xs-12">
	                	<div class="x_panel">
	                      <div class="x_title">
	                          <h2>图片查询<small>我的匹克切，你们在哪？</small></h2>
	                          <ul class="nav navbar-right panel_toolbox">
	                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
	                              </li>
	                          </ul>
	                          <div class="clearfix"></div>
	                      </div>
	                      <div class="x_content">
	                          <p></p>
	                          <!-- start pop-over -->
	                          <div class="bs-example-popovers">
	                              <button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="left" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus." data-original-title="" title="">
	                                  Left
	                              </button>
	                              <button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="top" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus." data-original-title="" title="">
	                                  Top
	                              </button>
	                              <button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="bottom" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
	                                  Bottom
	                              </button>
	                              <button type="button" class="btn btn-default" data-container="body" data-toggle="popover" data-placement="right" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus.">
	                                  Right
	                              </button>
	                          </div>
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