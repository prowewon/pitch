<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/css/edit_Board.css">
<title>PITCH | 게시글 수정</title>
<script type="text/javascript">
function upBoard(boardNo) {
	$.ajax({
		type : "POST",
		url : "${path}/Board/upBoard",
		data : {"boardNo" : boardNo,
				"boardTitle" : $(".title").val(),
				"boardIndex" : $(".index").val(),
				"menuNo" : $("#menu_no").val()},
		dataType : "json",
		success : function(data) {
			location.href="${path}/Board/board_detail?board_no="+boardNo;
		}
	})
}
</script>
</head>
<body>
	<header>
        <h1><a href="${path}/Main/main">PITCH</a></h1>
    </header>
    <div class="form">
	    <textarea class="title" name="board_title" placeholder="제목" maxlength="45">${BOARD_TITLE}</textarea>
	    <textarea class="index" name="board_index" placeholder="내용을 입력하세요" maxlength="990">${boardIndex}</textarea>
	    <select id="menu_no">
	        <option value="1">음악</option>
	        <option value="2">자유</option>
	        <option value="3">공지사항</option>
	    </select>
	    <input type="submit" value="수정" id="submit" onclick="upBoard(${BOARD_NO});">
    </div>
</body>
</html>