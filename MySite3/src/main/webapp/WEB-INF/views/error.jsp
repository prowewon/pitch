<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta HTTP-EQUIV="Refresh" CONTENT="0;URL=/MySite2/login.yej"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<title>PITCH</title>
<style type="text/css">
	html, body { margin: 0 auto; padding: 0; background-color: #ffdddd; }
</style>
</head>
<script type="text/javascript">
$(document).ready(function(){
	alert("접근권한이 없습니다.");
	location.href="${path}/Main/main";
});
</script>
<body>
</body>
</html>