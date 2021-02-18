<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${ path}/resources/css/board_insert.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>PITCH</title>
<script type="text/javascript">
// $(document).ready(function(){
// 	$("#submit").on(click, function(){
// 		alert();
// 	});
// });
</script>
</head>
<body>
	<header>
        <h1><a href="${path}/Main/main">PITCH</a></h1>
    </header>
    <form action="${path}/Board/board_insert" method="post">
        <textarea class="title" name="board_title" placeholder="제목" maxlength="45"></textarea>
        <textarea class="index" name="board_index" placeholder="내용을 입력하세요" maxlength="990"></textarea>
        <select name="menu_no">
            <option value="1">음악</option>
            <option value="2">자유</option>
            <option value="3">공지사항</option>
        </select>
        <input type="submit" value="등록" id="submit">
    </form>
</body>
</html>