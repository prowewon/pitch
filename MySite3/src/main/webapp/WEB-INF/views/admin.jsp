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
<link rel="stylesheet" href="${ path}/resources/css/admin.css">
<title>PITCH</title>
<script type="text/javascript">   
$(document).ready(function(){
	
	$(".album").on("click",function(){ 
        $(".album").css('background-color','#ffdddd');
        $(".album").css('color','#fff');
        $(".user").css('background-color','#f8f8f8');
        $(".user").css('color','#000');
        user();
        $(".box").css("display", "block");
        $(".box2").css("display", "none");
    });
    $(".user").on("click",function(){
        $(".user").css('background-color','#ffdddd');
        $(".album").css('background-color','#f8f8f8');
        $(".user").css('color','#fff');
        $(".album").css('color','#000');
//         $.ajax({
//         	type : "POST",
//         	url : "${path}/Admin/member",
//         	success : function(data) {
// 				consol.log(data);
// 				user();
// 			}
//         })
    });
	
	//앨범 insert
// 	$("#record").click(function(){
// 		if($("#rec_name").val() != "" && $("#rec_art").val() != "" && $("#rec_date").val() != "" && $("#img_name").val() != ""){
// 			$.ajax({
// 				type : "POST",
// 				url : "${path}/Admin/insert_rec",
// 				data : {"rec_name" : $("#rec_name").val(),
// 						"rec_art" : $("#rec_art").val(),
// 						"rec_date" : $("#rec_date").val().replace(/-/gi, "."),
// 						"img" : $("#record_frm").data()},
// 				dataType : "json",
// 				success : function(data){
// 					console.log(data);
// 					location.reload();
// 				}
// 			})
// 		}else {
// 			alert("모든 값을 넣어주세요.")
// 		}
// 	});
	
	
	//트랙 insert
	$("#track").click(function(){
		if($(".recname").val() != "" && $("#trano").val() != "" && $("#traname").val() != ""){
			$.ajax({
				type : "POST",
				url : "${path}/Admin/insert_tra",
				data : {"REC_NO" : $(".recname option:selected").val(),
						"TRA_NO" : $("#trano").val(),
						"TRA_NAME" : $("#traname").val(),
						"TRA_URL" : $("#traurl").val()},
				dateType : "json",
				success : function(data){
					alert("입력완료");
					location.reload();
				}
			})
		}else {
			alert("모든 값을 입력해주세요");
		}
	});
	
});
        
function user(){
    $(".box").css("display", "none");
    $(".box2").css("display", "block");
}

//회원정보 관리
function up_user(mem_no, i) {
	var mem_id = $(".mem_id").eq(i).val();
	var mem_pw = $(".mem_pw").eq(i).val();
	var mem_name = $(".mem_name").eq(i).val();
	var mem_email = $(".mem_email").eq(i).val();
	var mem_grade = $(".mem_grade").eq(i).val();
	var del_yn = $(".del_yn").eq(i).val();
	
	$.ajax({
		type : "POST",
		url : "${path}/Admin/up_mem",
		data : {"mem_no" : mem_no,
				"mem_id" : mem_id,
				"mem_pw" : mem_pw,
				"mem_name" : mem_name,
				"mem_email" : mem_email,
				"mem_grade" : mem_grade,
				"del_yn" : del_yn},
		dataType : "json",
		success : function(data) {
			console.log(data);
			if(data.up_mem == 1) {
				alert("수정되었습니다.");
			}
		}
	})
}

//form 유효성 검사
function check() {
	var recName = $("#rec_name").val();
	var recArt = $("#rec_art").val();
	var file = $("#file").val();
	if (recName == "" || recArt == "" || file == "") {
		alert("모든 값을 입력해주세요.");
		return false;
	}
}
</script>
</head>
<body>
	<header>
		<h1><a href="${path}/Main/main">PITCH</a></h1>
        <div class="text">
            <a href="member.yej"><sec:authentication property="principal.username"/></a>님
            <a id="logout" class="logout" href="${path}/security_logout">LOGOUT</a>
        </div>
	</header>
	<div class="btn">
        <button class="album">앨범등록</button>
        <button class="user" onclick="user();">회원관리</button>
    </div>
    
    <!-- 앨범넣기 -->
    <div class="box">
    	<form action="${path}/Admin/insert_rec" id="record_frm" name="record_frm" method="post" enctype="multipart/form-data" onsubmit="return check();">
	        <ul class="record">
				<h1>RECORD</h1>
				<li class="name"><strong>앨범이름</strong></li>
	       		<li class="value"><input type="text" id="rec_name" name="rec_name" ></li>
	       		<li class="name"><strong>가수</strong></li>
	       		<li class="value"><input type="text" id="rec_art" name="rec_art"></li>
	       		<li class="name"><strong>발매일</strong></li>
	       		<li class="value"><input type="date" id="rec_date" name="rec_date"></li>
	       		<li class="name"><strong>사진</strong></li>
	       		<li class="value"><input type="file" id="file" name="file"></li>
	       		<li><input type="submit" class="signup" value="INSERT" id="record"></li>
	   		</ul>	
    	</form>
    	
        <!-- 트랙넣기 -->
        <ul class="track">
            <h1>TRACK</h1>
			<li class="name"><strong>앨범이름</strong></li>
       		<li class="value">
	       		<select class="recname">
	       		<c:forEach var="rec" items="${list}" varStatus="status">
	       			<option value="<c:out value="${rec.REC_NO}"/>"><c:out value="${rec.REC_NAME}"/></option>
	       		</c:forEach>
	       		</select>
       		</li>
			<li class="name"><strong>트랙번호</strong></li>
       		<li class="value"><input type="text" id="trano" ></li>
       		<li class="name"><strong>트랙이름</strong></li>
       		<li class="value"><input type="text" id="traname"></li>
       		<li class="name"><strong>영상주소</strong></li>
       		<li class="value"><input type="text" id="traurl"></li>
       		<li><input type="submit" class="signup" value="INSERT" id="track"></li>
   		</ul>
    </div>
    
	<!-- 회원관리 -->
    <div class="box2">
        <table>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>이메일</th>
                <th>권한</th>
                <th>삭제여부</th>
                <th></th>
            </tr>
            <c:forEach var="mem" items="${member}" varStatus="status">
            	<tr>
	                <td><c:out value="${mem.MEM_NO}"/></td>
	                <td><input type="text" class="mem_id" value="<c:out value="${mem.MEM_ID}"/>"></td>
	                <td><input type="text" class="mem_pw" value="<c:out value="${mem.MEM_PW}"/>"></td>
	                <td><input type="text" class="mem_name" value="<c:out value="${mem.MEM_NAME}"/>"></td>
	                <td><input type="text" class="mem_email" value="<c:out value="${mem.MEM_EMAIL}"/>"></td>
	                <td>
                		<c:set var="role" value="${mem.MEM_GRADE}" />
						<c:choose>
						    <c:when test="${role eq 'ROLE_ADMIN'}">
			                    <select class="mem_grade">
				                    <option value="ROLE_ADMIN">ROLE_ADMIN</option>
				                    <option value="ROLE_USER">ROLE_USER</option>
			                    </select>
						    </c:when>
						    <c:when test="${role eq 'ROLE_USER'}">
			                    <select class="mem_grade">
				                    <option value="ROLE_USER">ROLE_USER</option>
				                    <option value="ROLE_ADMIN">ROLE_ADMIN</option>
			                    </select>
						    </c:when>
						</c:choose>
	                </td>
	                <td>
	                	<c:set var="del" value="${mem.DEL_YN}" />
						<c:choose>
						    <c:when test="${del eq 'N'}">
			                    <select class="del_yn">
				                    <option value="N">N</option>
				                    <option value="Y">Y</option>
			                    </select>
						    </c:when>
						    <c:when test="${del eq 'Y'}">
			                    <select class="del_yn">
				                    <option value="Y">Y</option>
				                    <option value="N">N</option>
			                    </select>
						    </c:when>
						</c:choose>
	                </td>
	                <td><button class="submit" onclick="up_user(<c:out value="${mem.MEM_NO}"/>, <c:out value="${status.index}"/>);">적용</button></td>
            	</tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>