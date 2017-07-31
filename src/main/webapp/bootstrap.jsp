<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="${bootstrapScriptPath}/custom.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bootstrap基本学习</title>

<style type="text/css">
</style>

<script type="text/javascript">
	$(document).ready(function() {

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
       	</div>
	</div>
	
	<div id="custom_notifications" class="custom-notifications dsp_none">
		<ul class="list-unstyled notifications clearfix"
			data-tabbed_notifications="notif-group">
		</ul>
		<div class="clearfix"></div>
		<div id="notif-group" class="tabbed_notifications"></div>
	</div>
	
	<script>
		NProgress.done();
	</script>
</body>

</html>