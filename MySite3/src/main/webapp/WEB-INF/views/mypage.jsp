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
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<title>PITCH | MY</title>
<script>
    $(document).ready(function(){
    $(".mod").on("click",function(){
        $(".mod").css('background-color','#ffdddd');
        $(".mod").css('color','#fff');
        $(".write").css('background-color','#f8f8f8');
        $(".write").css('color','#000');
        $(".mypage").css("display", "block");
        $(".list").css("display", "none");
    });
    $(".write").on("click",function(){
        $(".write").css('background-color','#ffdddd');
        $(".mod").css('background-color','#f8f8f8');
        $(".write").css('color','#fff');
        $(".mod").css('color','#000');
        write();
    });
});
        
function write(){
    $(".mypage").css("display", "none");
    $(".list").css("display", "block");
}

function delcom(comno){
	$.ajax({
		type : "POST",
		url : "${path}/Detail/delcom",
		data : {"COM_NO" : comno},
		success : function(data) {
			alert("삭제되었습니다.");
			location.reload();
		}
	});
}

function up_name() {
	$.ajax({
		type : "POST",
		url : "${path}/My/up_name",
		data : {"mem_name" : $("#mem_name").val()},
		dataType : "json",
		success : function(data){
// 			console.log(data);
			alert(data.flag);
		}
	})
}

function up_email() {
	$.ajax({
		type : "POST",
		url : "${path}/My/up_email",
		data : {"mem_email" : $("#mem_email").val()},
		dataType : "json",
		success : function(data){
// 			console.log(data);
			alert(data.flag);
		}
	})
}

function up_pw() {
	var pw = $("#pw").val();
	var pre_pw = $("#pre_pw").val();
	var cng_pw = $("#cng_pw").val();
	var re_pw = $("#re_pw").val();
	
	if (pw != pre_pw) {
		alert("현재 비밀번호를 확인해주세요.");
	}else if (cng_pw != re_pw) {
		alert("변경할 비밀번호를 확인해주세요.");
	}else if(pw == pre_pw && cng_pw == re_pw){
		$.ajax({
			type : "POST",
			url : "${path}/My/up_pw",
			data : {mem_pw : cng_pw},
			dataType : "json",
			success : function(data){
				alert(data.flag);
				location.reload();
			}
		})
	}
}
</script>
</head>
<body>
	<header>
		<h1><a href="${path}/Main/main">PITCH</a></h1>
        <div class="text">
            <a id="logout" class="logout" href="${path}/security_logout">LOGOUT</a>
        </div>
	</header>
    <div class="btn">
        <button class="mod">개인정보수정</button>
        <button class="write">내가 쓴 글</button>
    </div>
    <div class="mypage">
        <div class="pwd">
            <ul>
                <li><strong>비밀번호</strong></li>
                <li><input type="password" readonly="readonly" id="pw" value="${member.mypage.MEM_PW}">
                <li><input type="password" maxlength="19" id="pre_pw" placeholder="현재 비밀번호"></li>
                <li><input type="password" maxlength="19" id="cng_pw" placeholder="변경할 비밀번호"></li>
                <li><input type="password" maxlength="19" id="re_pw" placeholder="변경할 비밀번호 확인"></li>
                <li><button class="up_btn" onclick="up_pw();">변경하기</button></li>
            </ul>
        </div>
        <div class="email">
            <ul>
                <li><strong>이메일</strong></li>
                <li><textarea maxlength="18" id="mem_email">${member.mypage.MEM_EMAIL}</textarea></li>
                <li><button class="up_btn" onclick="up_email();">변경하기</button></li>
            </ul>
        </div>
        <div class="name">
            <ul>
                <li><strong>닉네임</strong></li>
                <li><textarea maxlength="18" id="mem_name">${member.mypage.MEM_NAME}</textarea></li>
                <li><button class="up_btn" onclick="up_name();">변경하기</button></li>
            </ul>
        </div>
        <div class="del"><button>탈퇴하기</button></div>
    </div>
    <div class="list">
        <div class="board">
            <h2>게시글</h2>
            <table class="table">
            	<c:forEach var="board" items="${member.board}" varStatus="status">
	                <tr class="trtd">
	                    <td class="trtd"><a href="${path}/Board/board_detail?board_no=${board.BOARD_NO}">${board.BOARD_TITLE}</a></td>
	                </tr>
            	</c:forEach>
            </table>
        </div>
        <div class="comment">
            <h2>댓글</h2>
            <table class="table">
                <c:forEach var="comment" items="${member.comment}" varStatus="status">
                	<tr>
	                    <td colspan="3"><a href="${path}/Detail/select?recno=${comment.REC_NO}">${comment.COM_INDEX}</a></td>
	                    <td><button onclick="delcom(${comment.COM_NO});">삭제</button></td>
                    </tr>
            	</c:forEach>
            </table>
        </div>
    </div>
</body>
</html>