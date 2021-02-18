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
</head>
<style>
    html, body { margin: 0 auto; padding: 0; background-color: #ffffff; min-width: 1200px;}
    header { width: 100%; height: 60px; background-color: #ffdddd; text-align: center; }
    header h1 { width: 200px; margin-top: 0; margin-bottom: 0; margin-left: auto; margin-right: auto; padding-top: 8px; } 
    .text { margin-top: 10px; width: 300px; float: right; }
    .text a { margin-left: 10px; color: black; font-size: 17px; font-weight: bold; }
    .text a:hover {border-bottom: 1px solid black;}
    a { text-decoration: none; color: black; cursor: pointer; margin-left: 5px;}
    table {
        width: 900px;
        margin-top: 80px;
        margin-left: auto;
        margin-right: auto;
        text-align: center;
    }
    tr { height: 30px;}
    th { border-bottom: 1px solid #bebebe; }
    td { 
        border-bottom: 1px solid #bebebe;
        height: 10px;
    }
    .table2 {
        margin-top: 20px;
    }
    .border { border-style: none;}
    .title {
    height: 20px;
	display: inline-block;
	overflow: hidden;
	}
    .title:hover {
        border-bottom: 1px solid black;
    }
    .search {
        margin-top: 10px;
        text-align: center;
    }
    .search_select {
        vertical-align: middle;
        height: 25px;
        border-radius: 3px;
        border: 1px solid #bebebe;
    }
    .search_input {
        height: 22px;
        border-radius: 3px;
        border: 1px solid #bebebe;
    }
    .search_btn {
        vertical-align: middle;
        border-radius: 3px;
        border: 1px solid #bebebe;
        height: 29px;
        cursor: pointer;
    }
    
    .write {
	    display: inline-block;
	    border-radius: 3px;
	    border: 1px solid #bebebe;
	    height: 20px;
	    width: 50px;
	    padding: 3px;
	    font-size: 14px;
	    background-color: #dedede;
	    margin-top: 1px;
	}
</style>
<script>
$(document).ready(function(){
	var pagenum = "";
	$.ajax({
		type : "GET",
		url : "${path}/Board/select",
		dataType : "json",
		success : function(data){
			var html = "";
			var list = data.list.list;
			var pagecnt = data.pagecnt.PAGECNT;
			if(list != null){
				for (var i = 0; i < list.length; i++) {
					html += '<tr><td>'+list[i].BOARD_NO+'</td>';
		            html += '<td>'+list[i].MENU_NAME+'</td>';
		            html += '<td style="text-align: left;"><a class="title" onclick="board_detail('+list[i].BOARD_NO+');">'+list[i].BOARD_TITLE+'</a></td>';
		            html += '<td>'+list[i].MEM_NAME+'</td>';
		            html += '<td>'+list[i].BOARD_DATE+'</td></tr>';
				}
			}
			$("#board_list").empty().html(html);
			for (var i = 0; i < pagecnt; i++) {
				pagenum += '<a onclick="page('+(i+1)+');">'+(i+1)+'</a>';
			}
			$("#page_area").empty().html(pagenum);
		}
	})
	
	$(".search_btn").on("click", function(){
		var srchSelect = $(".search_select").val();
		var srchInput = $(".search_input").val();
		if (srchInput == "") {
			alert("검색어를 넣어주세요");
		}else {
			$.ajax({
			type : "POST",
			url : "${path}/Board/search",
			dataType : "json",
			data : {"srchSelect" : srchSelect,
					"srchInput" : srchInput},
			success : function(data) {
// 				console.log(data);
				var html = "";
				var list = data.list;
				if(list != null){
					for (var i = 0; i < list.length; i++) {
						html += '<tr><td>'+list[i].BOARD_NO+'</td>';
			            html += '<td>'+list[i].MENU_NAME+'</td>';
			            html += '<td style="text-align: left;"><a class="title" onclick="board_detail('+list[i].BOARD_NO+');">'+list[i].BOARD_TITLE+'</a></td>';
			            html += '<td>'+list[i].MEM_NAME+'</td>';
			            html += '<td>'+list[i].BOARD_DATE+'</td></tr>';
					}
				}
				$("#board_list").empty().html(html);
				$("#page_area").empty();
			}
		})
		}
		
	})
});

function page(pagenum){
	$.ajax({
		type : "POST",
		url : "${path}/Board/page",
		dataType : "json",
		data : {pagenum : pagenum},
		success : function(data){
			console.log(data);
			var list = data.list;
			var html = "";
			if(list != null){
				for (var i = 0; i < list.length; i++) {
					html += '<tr><td>'+list[i].BOARD_NO+'</td>';
		            html += '<td>'+list[i].MENU_NAME+'</td>';
		            html += '<td style="text-align: left;"><a class="title" onclick="board_detail('+list[i].BOARD_NO+');">'+list[i].BOARD_TITLE+'</a></td>';
		            html += '<td>'+list[i].MEM_NAME+'</td>';
		            html += '<td>'+list[i].BOARD_DATE+'</td></tr>';
				}
			}
			$("#board_list").empty().html(html);
		}
	})
}

function board_detail(board_no) {
	location.href="${path}/Board/board_detail?board_no="+board_no;
}

</script>
<body>
	<header>
		<h1><a href="${path}/Main/main">PITCH</a></h1>
        <div class="text">
            <a id="idtag" href="${path}/My"><sec:authentication property="principal.username"/>님</a>
            <a id="logout" class="logout" href="${path}/security_logout">LOGOUT</a>
        </div>
	</header>
    <table>
        <tr>
            <th width="100px">NO.</th>
            <th width="100px">CATEGORY</th>
            <th width="500px">TITLE</th>
            <th width="100px">WRITE</th>
            <th width="100px">DATE</th>
        </tr>
        <tbody id="board_list"></tbody>
    </table>
    <table class="table2">
        <tr class="border">
            <td class="border" id="page_area"></td>
        </tr>
    </table>
    <div class="search">
        <select class="search_select">
            <option value="1">제목</option>
            <option value="2">내용</option>
            <option value="3">제목/내용</option>
        </select>
        <input type="text" class="search_input">
        <input type="submit" class="search_btn" value="검색">
        <a class="write" href="${path}/Board/write">글쓰기</a>
    </div>
</body>
</html>