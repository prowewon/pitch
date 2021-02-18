<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<title>PITCH</title>
<style type="text/css">
html, body { height: 100%; margin: 0 auto; padding: 0; background-color: #ffdddd; }
	header { position: absolute; width: 100%; height: 60px; background-color: #bebebe; text-align: center; }
	header h1 { width: 200px; margin-top: 0; margin-bottom: 0; margin-left: auto; margin-right: auto; padding-top: 8px; }
	.text { margin-top: 10px; width: 300px; float: right; }
    .text a { margin-left: 10px; color: black; font-size: 17px; font-weight: bold; }
    a { text-decoration: none; color: black; cursor: pointer;}
	header h1 a { text-decoration: none; color: black; }
        
        .int {
            position: relative;
            width: 600px;
            height: 50px;
            border: 1px solid #bebebe;
            top: 100px;
            left: 50%;
            margin-left: -300px
        }
        
        .int p {
            margin-top: 11px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }
        
        .list {
            position: relative;
            width: 602px;
            border: 1px solid #bebebe;
            left: 50%;
            margin-left: -301px;
            margin-top: 150px;
        }
        
        .listdiv{
            height: 132px;
            width: 600px;
            border-bottom: 1px solid #bebebe;
        }
        .list1 {
            width: 100%;
            height: 30px;
            border-bottom: 1px solid #bebebe;
        }
        
        .list1 p {
            margin-top: 3px;
            margin-bottom: 0;
            margin-left: 10px;
            float: left;
            font-weight: bold;
        }
        
        .list1 button {
            margin-top: 3px;
            margin-bottom: 0;
            margin-right: 10px;
            float: right;
            font-weight: bold;
        }
        
        .list2{
            width: 100%;
            height: 100px;
        }
        
        .list2 p{
            text-align: center;
            margin-top: 15px;
            font-size: 25px;
        }
        
        footer {
            padding-top: 100px;
            width: 100%;
            height: 10px;
        }
</style>
<script type="text/javascript">
$(document).ready(function(){
	//태그 밑줄 이벤트
	$( "#logout" ).mouseover(function() {
		  $( "#logout" ).css( "border-bottom","1px solid" );
		});
	$( "#logout" ).mouseout(function() {
		  $( "#logout" ).css( "border","none" );
		});
});
function delcom(memid, id, comno){
	var memid = memid; 
	var id = id;
	var comno = comno;
	if( memid == id){
		$.ajax({
			type : "POST",
			url : "DetailAction!delete.yej",
			data : {"comno" : comno},
			success : function(data) {
				location.reload();
			}
		});
	}else{
		alert("삭제권한이 없습니다.");
	}
}
function mocom(memid, id, comno){
	var memid = memid; 
	var id = id;
	var comno = comno;
	if( memid == id){
		location.href="mocom.yej?comno="+comno;
	}else{
		alert("수정권한이 없습니다.");
	}
}
</script>
</head>
<body>
<header>
	<h1><a href="main.yej">PITCH</a></h1>
		<div class="text">
			<a id="logout" class="logout" href="logout.yej">LOGOUT</a>
		</div>
</header>
<div class="int">
    <p>${id}님의 댓글목록</p>
</div>
<div class="list">
	<c:forEach var="list" items="${list}" varStatus="status">
		<div class="listdiv">
	        <div class="list1">
	        	<p><c:out value="${list.RECNAME}"/></p><p><c:out value="${list.COMYN}"/></p><p><c:out value="${list.COMDATE}"/></p>
	        	<button onclick="delcom('${list.MEMID}','${id}','${list.COMNO}');">삭제</button>
	        	<button onclick="mocom('${list.MEMID}','${id}', '${list.COMNO}');">수정</button>
	        </div>
	        <div class="list2"><c:out value="${list.COMINDEX}"/></div>
    	</div>
	</c:forEach>
</div>
<footer></footer>
</body>
</html>