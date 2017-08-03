<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="imageSubmitUrl" value="image/submit.do" scope="page" />
<c:set var="initTableUrl" value="image/initTable.do" scope="page" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/main/common.jsp" flush="true"></jsp:include>

<link href="${bootstrapCssPath}/datatables/css/jquery.dataTables.css"
	rel="stylesheet">

<!-- <script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script> -->
<script src="${bootstrapScriptPath}/datatables/js/jquery.dataTables.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DataTable学习</title>

<style type="text/css">
</style>

<script type="text/javascript">
	$(document).ready(function() {
		initPictureTab();
	});

	function initPictureTab() {
		/* $("#pictureTab").DataTable({
			"ajax":{
		        url:"${initTableUrl}",
		        dataSrc:"data"
		    },
		}); */

		$('#pictureTab').DataTable({
			"ajax" : {
				"url" : "data/t.json",
				"dataSrc" : "demo"
			}
		});
	}
</script>
</head>
<body class="nav-md">
	<table id="pictureTab"
		class="table table-striped responsive-utilities jambo_table">
		<thead>
			<tr>
				<th>Name</th>
				<th>Position</th>
				<th>Office</th>
				<th>Extn.</th>
				<th>Start date</th>
				<th>Salary</th>
			</tr>
		</thead>
	</table>
</body>

</html>