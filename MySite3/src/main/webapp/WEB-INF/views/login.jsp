<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<title>PITCH</title>
<style>
	html, body { margin: 0 auto; padding: 0; background-color: #ffdddd; }
    .wrap { position: absolute; width: 600px; top: 100px; left: 50%; margin-left: -300px; text-align: center; }
    h2 { margin-top: 5px; }
    .btn { width: 200px; height: 40px; background-color: #bebebe; border: none; border-radius: 4px; margin-top: 10px; cursor: pointer;}
    .login { margin-top: 30px; }
    .login input { width: 200px; height: 40px; border-radius: 4px; border: 1px solid #bebebe; }
        
</style>
</head>
<body>
	<div class="wrap">
		<h1>PITCH</h1>
		<form action="${path}/Login/login" method="post">
		<c:if test="${param.error != null}">
			<p>
				Login Error <br>
				<c:if test="${SPRING_SECURITY_LAST_EXCEPTION != NULL}">
					message : <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"></c:out>
				</c:if>
			</p>
		</c:if>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	        <div class="login">
	            <input type="text" name="id" id="id" placeholder="  아이디를 입력하세요">
	            <input type="password" name="pwd" id="pwd" placeholder="  비밀번호를 입력하세요">
	        </div>
	        <input type="submit" id="login" class="btn" value="LOGIN">
	      </form>
	        <a href="${path}/Login/sign"><input type="submit" class="btn" value="SIGNUP"></a>
     </div>
</body>
</html>