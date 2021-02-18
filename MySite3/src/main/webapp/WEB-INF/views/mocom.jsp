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
<title>PITCH</title>
<style type="text/css">
html, body { margin: 0 auto; padding: 0; background-color: #ffffff; }
.wrap { position: absolute; width: 400px; top: 100px; left: 50%; margin-left: -200px; text-align: center; list-style: none; }
.name { width: 400px; height: 30px; } 
strong { float: left; }
.value { width: 400px; height: 50px; }
input { width: 400px; height: 40px; border-radius: 4px; border: 1px solid #ffdddd; }
#comindex { width: 400px; height: 100px; border-radius: 4px; border: 1px solid #bebebe; resize: none;}
.check { width: 180px; height: 40px; }
.signup { margin-top: 30px; }
a { color: black; text-decoration:none; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#update").click(function(){
		$.ajax ({
			type : "POST",
			url : "${path}/Detail/upcom",
			data : {"COM_NO" : $("#comno").val(),
					"COM_INDEX" : $("#comindex").val().replace(/\n/g, "<br>")},
			dataType : "json",
			success : function(data){
				alert("수정했습니다.");
				location.href="${path}/Detail/select?recno="+$("#recno").val();
			}
		})
	});
});
</script>
</head>
<body>
	<ul class="wrap">
        <a href="${path}/Main/main"><h1>PITCH</h1></a>
        <li class="name"><strong>아이디</strong></li>
        <li class="value">
        <input id="id" type="text" readonly value="${MEM_ID}">
        <input id="comno" type="hidden" value="${COM_NO}">
        <input id="recno" type="hidden" value="${REC_NO}">
        </li>
        
        <li class="name"><strong>내용</strong></li>
        <li class="value2">
        <textarea id="comindex" maxlength="280" wrap="virtual">${COM_INDEX}</textarea>
        <li><input type="submit" class="signup" value="수정" id="update"></li>
    </ul>
</body>
</html>