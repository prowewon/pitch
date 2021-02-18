<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PITCH</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
	html, body { margin: 0 auto; padding: 0; background-color: #ffdddd; }
   .wrap { position: absolute; width: 400px; top: 100px; left: 50%; margin-left: -250px; text-align: center; list-style: none; }
   .name { width: 400px; height: 30px; } 
   strong { float: left; }
   .alert { font-weight: 500; color: crimson;}
   .value { width: 400px; height: 50px; }
   input { width: 400px; height: 40px; border-radius: 4px; border: 1px solid #bebebe; }
   .check { width: 180px; height: 40px; }
   .signup { margin-top: 30px; }
   a { color: black; text-decoration:none; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	var cnt = 0;
	var flag = 0;
	$("#idcheck").click(function(){
		if($("#id").val() == ""){
			alert("아이디를 적어주세요.");
		}else {
			$.ajax({
				type : "POST",
				url : "${path}/Login/selectId",
				data : {"id" : $("#id").val()},
				dataType: "json",
				success : function(data){
					console.log(data.selectID);
					 if(data.selectID == null){
						cnt = 1;
						alert("사용가능한 아이디입니다.");
					}else{
						$("#id").val(""); 
						alert("중복된 아이디입니다.");
					}
				}
			});
		}
	});
	$("#repwd").keyup(function(){
        if($("#pwd").val() == $("#repwd").val()){
        	$("#pwd").css("border","1px solid dodgerblue");
        	$("#repwd").css("border","1px solid dodgerblue");
        }else{
        	$("#pwd").css("border","1px solid crimson");
        	$("#repwd").css("border","1px solid crimson");
        }
	});
	
	$("#email").blur(function(){
		 var email = $("#email");
		 var alert = $(".alert");
		 //이메일 유효성검사
		if(email.val() == ''){
        	alert.text("이메일을 입력해주세요");
            email.css("border","1px solid #ff3131");
        }else{
            var email_val = email.val();
            var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
            
            if(regEmail.test(email_val) == false){
            	alert.text("유효하지 않은 이메일입니다.");
                email.css("border","1px solid crimson");
                flag = 0;
            }else {
            	alert.text("");
                email.css("border","1px solid dodgerblue");
                flag = 1;
            }
        }
	 });
	
	$("#sign").click(function(){
		if($("#id").val() == "" || $("#pwd").val() == "" || $("#email").val() == ""){
			alert("정보가 부족합니다.");
        }else{
        	if(cnt == 1 && flag == 1){
        		if($("#pwd").val() == $("#repwd").val()){
            		$.ajax({
            			type : "POST",
            			url : "${path}/Login/insert",
            			data : {"id" : $("#id").val(),
            					"pwd" : $("#pwd").val(),
            					"email" : $("#email").val()},
            			dataType : "json",
            			success : function(data){
            				if(data.insert == 0){
            					alert("회원가입 실패");
            				}else{
            					alert("회원가입 성공");
            					location.href = "${path}/Login/";
            				}
            			}
            		});
            	}else{
            		alert("비밀번호가 일치하지 않습니다.");
            	}
        	}else if(cnt == 0){
        		alert("아이디 중복여부를 확인해주세요.");
        	}else if(flag == 0){
        		alert("이메일을 확인해주세요.");
        	}
        }
	});
});
</script>
</head>
<body>
	<ul class="wrap">
        <a href="${path}/Login/"><h1>PITCH</h1></a>
        <li class="name"><strong>아이디</strong></li>
        <li class="value"><input id="id" type="text"></li>
        <input type="submit" id="idcheck" class="check" value="아이디 중복확인">
        <li class="name"><strong>비밀번호</strong></li>
        <li class="value"><input type="password" id="pwd"></li>
        <li class="name"><strong>비밀번호 확인</strong></li>
        <li class="value"><input type="password" id="repwd"></li>
        <li class="name"><strong>이메일</strong></li>
        <li class="value"><input type="text" id="email"></li>
        <li class="name"><strong class="alert"></strong></li>
        <li><input type="submit" class="signup" value="SIGN UP" id="sign"></li>
    </ul>
</body>
</html>