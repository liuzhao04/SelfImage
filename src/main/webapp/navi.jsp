<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导航测试</title>
<style type="text/css">
#wrapper {
	width: 100%;
	height: 100%;
}

#header {
	height: 100px;
	width: 100%;
	background: #aaa;
}

#navi {
	width: 10%;
	height: 400px;
	background: #F00;
}
#navi a{
	display:inline-block;
	width: 100%;
}

#content {
	height: 400px;
	width: 90%;
	background: #0f0;
}

.fleft {
	background: #0f0;
	display: inline-block;
}

#footer {
	width: 100%;
	height: 60px;
	background: #aaa;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div id="wrapper">
		<div id="header">
		</div>
		<div>
		<div id="navi" class="fleft">
			<a>童话</a>
			<a>草原</a>
			<a>童话</a>
			<a>草原</a>
		</div><!-- 借助注释去掉，inline-block之间的缝隙
		 --><div id="content" class="fleft"><a>草原</a><a>草原</a><a>草原</a></div>
		 </div>
		<div id="footer"></div>
	</div>
</body>
</html>