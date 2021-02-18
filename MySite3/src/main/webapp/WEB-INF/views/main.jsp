<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.cycle2.js"></script>
<link rel="stylesheet" href="${path}/resources/css/main.css">
<title>PITCH | MAIN</title>
<script type="text/javascript">
$(document).ready(function(){
	// 앨범 1위부터 6위까지 뿌려주기
	$.ajax({
		type: "GET",
		url : "${path}/Main/select",
		dataType : "json",
		success : function(data){
			var list = data.list;
			var imgList = data.imgList;
			var html = "";
			var imghtml = "";
			if(list != null){
				for(var i = 0; i < list.length; i++){
					html += '<li class="record little">';
					html += '<input type="hidden" class="recno" value="'+list[i].REC_NO+'">';
					html += '<img src="${path}/resources/img/'+ list[i].IMG_RENAME+'" >';
					html += '<div id="little2" title="'+(i+1)+'위">'+ (i+1) +'</div>';
					html += '</li>';
				}
				$("#big").empty().html(html);
				click(); 
			}
		},error : function(data){
			   console.log(data.list);
		   }
	});
	// 검색 기능
	$("#find").click(function(){
		$.ajax({
			type : "POST",
			url : "${path}/Main/search",
			data : {"search" : $("#search").val()},
			dataType : "json",
			success : function(data) {
				var list = data.list;
				var html = "";
				var footer = "<footer></footer>";
				if(list != null){
					for(var i = 0; i < list.length; i++){
						html += '<li class="record little">';
						html += '<input type="hidden" class="recno" value="'+list[i].REC_NO+'">';
						html += '<img src="${path}/resources/img/'+ list[i].IMG_RENAME+'">';
						html += '</li>';
					}
					$("#big").empty().html(html);
					click();
				}
			},error : function(data){
				   console.log(data);
			   }
			});
	});
});
// 메인 화면에서 앨범 사진 선택하면 이동하기
function click(recno) {
	$(".record").click(function(){
		var index = $(".record").index($(this));
		location.href = "${path}/Detail/select?recno="+$(".recno").eq(index).val();
	});
}
// 관리자 화면 이동하기
function admin(memNM) {
	if(memNM == "관리자"){
		location.href = "${path}/Admin/";
	}else {
		alert("관리자가 아닙니다.");
	}
}

</script>
</head>
<body>
	<header>
		<h1><a href="${path}/Main/main">PITCH</a></h1>
		<div class="menu">
            <ul>
                <li><a href="" >MAIN</a></li>
                <li><a href="${path}/Board">BOARD</a></li>
                <li><a href="${path}/My">MY</a></li>
                <li><a href="${path}/Admin">ADMIN</a></li>
                <li><a href="${path}/security_logout">LOGOUT</a></li>
            </ul>
        </div>
	</header>
	<div id="slide" class="slide cycle-slideshow">
		<c:forEach var="list" items="${imgList}">
			<img src="${path}/resources/img/${list.IMG_RENAME}">
		</c:forEach>
    </div>
    <div class="big_wrap">
        <ul id="big" class="big"></ul>
    </div>
    <div class="find_wrap">
	    <form id="form">
	       <input type="text" id="search" class="search">
	       <button type="button" id="find" class="find"><img src="https://cdn1.iconfinder.com/data/icons/hawcons/32/698627-icon-111-search-128.png"></button>
		</form>
	</div>
    <footer></footer>
</body>
</html>