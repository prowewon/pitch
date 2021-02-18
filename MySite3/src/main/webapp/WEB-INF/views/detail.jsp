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
<link rel="stylesheet" href="${path}/resources/css/detail.css">
<title>PITCH</title>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type : "GET",
		url : "${path}/Detail/comments",
		dataType : "json",
		success : function(data){
			var list = data.comments.list;
			var PAGECNT = data.pagecnt.PAGECNT;
			var html = "";
			var pagetable = "";
			var pagenum = "";
			if(list != null){
				for(var i = 0; i < list.length; i++){
					html += '<li><div class="user_inform">';
					if(list[i].COM_YN == "PITCH PERFECT"){
	                    html += '<p style="float : left" class="COM_Y">'+list[i].COM_YN+'</p>';
					}else if(list[i].COM_YN == "PITCH OFF"){
	                    html += '<p style="float : left" class="COM_N">'+list[i].COM_YN+'</p>';
					}
                    html += '<p style="float : left">'+list[i].MEM_NAME+'</p>';
                    html += '<a onclick="delcom(\''+list[i].COM_NO+'\');">삭제</a>';
                    html += '<a onclick="mocom(\''+list[i].COM_NO+'\');">수정</a>';
                    html += '<p style="float : right">'+list[i].COM_DATE+'</p></div>';
                    html += '<div class="comment_index">'+list[i].COM_INDEX+'</div></li>';
				}
				pagetable += '<table class="page_num">';
				pagetable += '<tr id="tr"></tr>';
				pagetable += '</table>'; 
			}
			$("#comment_list").empty().html(html);
			$("#page_area").append(pagetable);
			for(var i = 0; i < PAGECNT; i++){
				pagenum += '<td><a onclick="page('+(i+1)+');">'+(i+1)+'</a></td>';
			}
			$("#tr").empty().html(pagenum);
		}
	});
	//댓글작성
	$("#comyn").click(function(){
		if($("#comindex").val() != ""){
			$.ajax({type : "POST",
					url : "${path}/Detail/insert",
					data : {"COM_YN" : $("#comyn").val(),
							"COM_INDEX" : $("#comindex").val().replace(/\n/g, "<br>")},
					dataType : "json",
					success : function(data) {
						console.log(data);
						if(data.flag == 2){
							alert("댓글을 이미 작성하셨습니다.");
						}else if (data.flag == 1) {
							alert("추천하셨습니다.");
							location.reload();
						}
					}
				});
			}else{
				alert("댓글을 입력해주세요");
				}
	});
	
	$("#comyn2").click(function(){
		if($("#comindex").val() != ""){			
			$.ajax({type : "POST",
					url : "${path}/Detail/insert",
					data : {"COM_YN" : $("#comyn2").val(),
							"COM_INDEX" : $("#comindex").val().replace(/\n/g, "<br>")},
					dataType : "json",
					success : function(data) {
						if(data.flag == 2){
							alert("댓글을 이미 작성하셨습니다.");
						}else if (data.flag == 1) {
							alert("댓글을 작성하셨습니다.");
							location.reload();
						}
					}
				});
			}else{
				alert("댓글을 입력해주세요");
				}
	});
});
//수정할 댓글 불러오기
function mocom(comNo){
	/*alert(comno);*/
	$.ajax({
		type : "POST",
		url : "${path}/Detail/mocom",
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
function upcom(comYn) {
// 	alert(comYn);
	$.ajax ({
		type : "POST",
		url : "${path}/Detail/upcom",
		data : {"comNo" : $("#comNo").val(),
				"comIndex" : $("#mo_comindex").val().replace(/\n/g, "<br>"),
				"comYn" : comYn},
		dataType : "json",
		success : function(data){
// 			alert("수정했습니다.");
			location.reload();
		}
	})
}

function delcom(comNo){
	$.ajax({
		type : "POST",
		url : "${path}/Detail/delcom",
		data : {"comNo" : comNo},
		dataType : "json",
		success : function(data) {
// 			console.log(data);
			alert(data.flag);
			location.reload();
		}
	});
}

function page(cnt){
	var pagecnt = cnt;
	$.ajax({
		type : "GET",
		url : "${path}/Detail/page",
		data : {"pagecnt" : pagecnt},
		dataType : "json",
		success : function(data){
			console.log(data);
			var list = data.comments.list;
			var PAGECNT = data.pagecnt.PAGECNT;
			var html = "";
			var pagetable = "";
			var pagenum = "";
			if(list != null){
				for(var i = 0; i < list.length; i++){
					html += '<li><div class="user_inform">';
					if(list[i].COM_YN == "PITCH PERFECT"){
	                    html += '<p style="float : left" class="COM_Y">'+list[i].COM_YN+'</p>';
					}else if(list[i].COM_YN == "PITCH OFF"){
	                    html += '<p style="float : left" class="COM_N">'+list[i].COM_YN+'</p>';
					}
                    html += '<p style="float : left">'+list[i].MEM_NAME+'</p>';
                    html += '<a onclick="delcom(\''+list[i].COM_NO+'\');">삭제</a>';
                    html += '<a onclick="mocom(\''+list[i].COM_NO+'\');">수정</a>';
                    html += '<p style="float : right">'+list[i].COM_DATE+'</p></div>';
                    html += '<div class="comment_index">'+list[i].COM_INDEX+'</div></li>';
				}
				pagetable += '<table class="page_num">';
				pagetable += '<tr id="tr"></tr>';
				pagetable += '</table>';
			}
			$("#comment_list").empty().html(html);
			$("#page_area").append(pagetable);
			for(var i = 0; i < PAGECNT; i++){
				pagenum += '<td><a onclick="page('+(i+1)+');">'+(i+1)+'</a></td>';
			}
			$("#tr").empty().html(pagenum);
			
		}
	});
}

function link(TRAURL) {
	if(TRAURL == ''){
		alert("영상이 없습니다.");
	}else if(TRAURL != null){
		window.open(TRAURL, '_blank'); 
	}
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
                <li><a href="${path}/My">MY</a></li>
                <li><a href="${path}/Admin">ADMIN</a></li>
                <li><a href="${path}/security_logout">LOGOUT</a></li>
            </ul>
        </div>
	</header>
        <div class="inform">
            <!-- 앨범정보 -->
            <ul class="record">
                <li class="img">
                    <img src="${path}/resources/img/${list[0].IMG_RENAME}">
                </li>
                <li class="index">
                    <ul>
                        <li>${list[0].REC_NAME}</li>
                        <li>${list[0].REC_ART}</li>
                        <li>${list[0].REC_DATE}</li>
                    </ul>
                </li>
                <li class="cnt"><img src="https://www.iconfinder.com/data/icons/very-basic-2-android-l-lollipop-icon-pack/24/music-128.png"></li>
                <li class="cnt_num"><p>${CNT}</p></li>
            </ul>
            <!-- 앨범 트랙 리스트-->
            <ul class="track">
                <c:forEach var="detail" items="${list}" varStatus="status">
                <li><a onclick="link('<c:out value="${detail.TRA_URL}"/>');"><c:out value="${detail.TRA_NO}"/> . <c:out value="${detail.TRA_NAME}"/></a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="comment_wrap">
            <div class="comment">
            	<!-- 수정하는 댓글 박스 -->
            	<div class="comment_input" id="mocom_box">
                    <textarea maxlength="280" id="mo_comindex"></textarea>
                    <input type="hidden" id="comNo" value="">
                    <button class="COM_N" style="color : crimson" value="PITCH OFF" onclick="upcom('PITCH OFF');">PITCH OFF</button>
                    <button class="COM_Y" style="color : dodgerblue" value="PITCH PERFECT" onclick="upcom('PITCH PERFECT');">PITCH PERFECT</button>
                </div>
                <div class="comment_input" id="comment_input">
                    <textarea maxlength="280" id="comindex"></textarea>
                    <button class="COM_N" id="comyn2" style="color : crimson" value="PITCH OFF">PITCH OFF</button>
                    <button class="COM_Y" id="comyn" style="color : dodgerblue" value="PITCH PERFECT">PITCH PERFECT</button>
                </div>
                <ul class="comment_list" id="comment_list"></ul>
                <div class="page_area" id="page_area">
                    <table class="page_num">
                        <tr id="tr"></tr>
                    </table>
                </div>
            </div>
        </div>
    <footer></footer>
</body>
</html>