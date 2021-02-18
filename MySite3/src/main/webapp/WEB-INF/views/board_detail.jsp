<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board_detail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>PITCH</title>
<script type="text/javascript">
function editBoard(boardNo) {
	$.ajax({
		type : "POST",
		url : "${path}/Board/editBoard",
		data : {"boardNo" : boardNo},
		dataType : "json",
		success : function(data) {
// 			console.log(data);
			if (data.flag == "1") {
				location.href="${path}/Board/editpage?boardNo="+boardNo;
			}else if (data.flag == "2") {
				alert("수정권한이 없습니다.");
			}
		}
	})
}

function delBoard(boardNo) {
	$.ajax({
		type : "POST",
		url : "${path}/Board/delBoard",
		data : {"boardNo" : boardNo},
		dataType : "json",
		success : function(data) {
// 			console.log(data.flag);
			if (data.flag == "1") {
				alert("삭제되었습니다.");
				location.href="${path}/Board"
			}else if (data.flag == "2") {
				alert("권한이 없습니다.");
			}
		}
	})
}

function comment(boardNo) {
	var comIndex = $("#comindex").val();
	$.ajax({
		type : "POST",
		url : "${path}/Board/comment",
		dataType : "json",
		data : {"comIndex" : comIndex,
				"boardNo" : boardNo},
		success : function(data) {
			location.reload();
		}
	})
}

//수정할 댓글 불러오기
function mocom(comNo){
	/*alert(comno);*/
	$.ajax({
		type : "POST",
		url : "${path}/Board/mocom",
		data : {"comNo" : comNo},
		dataType : "json",
		success : function(data){
// 			console.log(data.flag);
			if (data.flag == "true") {
			    $("#mocom_box").css("display", "block");
			    $("#comment_input").css("display", "none");
			    $("#mo_comindex").val(data.COM_INDEX);
			    $("#comNo").val(data.COM_NO);
			}else{
				alert("수정권한이 없습니다.");
			}
		}
	})
}

//댓글 수정
function upcom() {
// 	alert(comYn);
	$.ajax ({
		type : "POST",
		url : "${path}/Board/upcom",
		data : {"comNo" : $("#comNo").val(),
				"comIndex" : $("#mo_comindex").val().replace(/\n/g, "<br>")},
		dataType : "json",
		success : function(data){
// 			console.log(data);
			location.reload();
		}
	})
}

function delcom(comNo){
	$.ajax({
		type : "POST",
		url : "${path}/Board/delcom",
		data : {"comNo" : comNo},
		dataType : "json",
		success : function(data) {
// 			console.log(data);
			if (data.flag == 1) {
	 			location.reload();
			}else if (data.flag == 0) {
				alert("삭제권한이 없습니다.");
			}
		}
	});
}
</script>
</head>
<body>
<header>
	<h1><a href="${path}/Main/main">PITCH</a></h1>
	<div class="menu">
		<ul>
			<li><a href="${path}/Main/main">MAIN</a></li>
            <li><a href="${path}/Board">BOARD</a></li>
            <li><a href="${path}/My">MY</a><input type="hidden" id="idtag" value="<sec:authentication property="principal.username"/>"></li>
            <li><a href="${path}/Admin">ADMIN</a></li>
            <li><a href="${path}/security_logout">LOGOUT</a></li>
        </ul>
    </div>
</header>
<div class="wrapper">
	<div class="title">${BOARD_TITLE}</div>
    <div class="btn_area">
    	<ul>
    		<li class="li1">작성자 : ${MEM_NAME}</li>
            <li class="li1">작성일 : ${BOARD_DATE}</li>
            <li><button onclick="delBoard(${BOARD_NO});">삭제</button></li>
            <li><button onclick="editBoard(${BOARD_NO});">수정</button></li>
        </ul>
    </div>
    <div class="index">${BOARD_INDEX}</div>
</div>
<div class="comment_wrap">
	<div class="comment">
		<!-- 수정하는 댓글 박스 -->
        <div class="comment_input" id="mocom_box">
        	<textarea maxlength="280" id="mo_comindex"></textarea>
            <input type="hidden" id="comNo" value="">
            <button class="COM_N" onclick="upcom();">EDIT</button>
        </div>
		<div class="comment_input" id="comment_input">
			<textarea maxlength="280" id="comindex"></textarea>
            <button class="COM_N" onclick="comment(${BOARD_NO});">COMMENTS</button>
		</div>
		<ul class="comment_list" id="comment_list">
			<c:forEach var="list" items="${list}">
				<li><div class="user_inform">
    			<p style="float : left">${list.MEM_NAME}</p>
				<a onclick="delcom(${list.COM_NO});">삭제</a>
				<a onclick="mocom(${list.COM_NO});">수정</a>
				<p style="float : right">${list.COM_DATE}</p></div>
				<div class="comment_index">${list.COM_INDEX}</div></li>
			</c:forEach>
        </ul>
<!--         <div class="page_area" id="page_area"> -->
<!--         	<table class="page_num"> -->
<!--         		<tr id="tr"></tr> -->
<!--             </table> -->
<!--         </div> -->
    </div>
</div>
<footer></footer>
</body>
</html>