<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.MemberVO"%>
<%@page import="service.MemberService"%>
<%@ page errorPage="/error/error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).on("click",".update",function() {
		//e.preventDefault();
		//console.log("아아");
		var data="";
		$.each($(this).parent().siblings().children() , function(i,o) {
			console.log(i,$(o).val());
			data += $(o).attr("name") + "=" + $(o).val() + "&";
		});
		console.log(data);
		$.ajax({
			url:"process/ajax_update_member.jsp",
			data : data,
			method : 'get',
			success : function result(data) {
				if(data.indexOf("true")!=-1) {
					$("#search")[0].reset();
					$("#btn_submit").click();
				}
				else {
					alert("업데이트에 실패 했습니다");
				}
			}
		});
	});
	
	$(document).on("click",".delete", function() {
		var data = "id=" + $(this).parent().siblings().children().first().val;
		console.log(data);
		$.ajax({
			url:"process/ajax_delete_member.jsp",
			data : data,
			method : 'get',
			success : function result(data) {
				alert(data);
				if(data.indexOf("true")!=-1) {
					$("#search")[0].reset();
					$("#btn_submit").click();
				}
				else {
					alert("업데이트에 실패 했습니다");
				}
			}
		});
	});
	
	
	
	$(function () {
		$("#btn_submit").click(function(e) {
			var data = $("#search").serialize();
			$.ajax({
				url: "process/ajax_search_member(json).jsp",
				data : data,
				method : 'get',
				success : function result(data) {
					
					var json = JSON.parse(data);
					console.log(json);
					var result = "<table>";
					for(i=0;i<json.result.length;i++) {
						result += "<tr>";
						result += "<td>"+ json.result[i].id+"<input type='hidden' value = '"+json.result[i].id+"' name='id'></td>";
						result += "<td><input type='text' value='"+json.result[i].name+"' name='name'></td>";
						result += "<td><input type='text' value='"+json.result[i].age+"' name='age'></td>";
						result += "<td><input type='text' value='"+json.result[i].grade_name+"' name='grade_name'></td>";
						result += "<td><a href='#' class='update' >수정</a> / <a href='#' class='delete' >삭제</a></td> </tr>";
					}
					result += "</table>";
					$("#content_area").html(result);
					
					// ajax_search_member.jsp 결과 처리
					/* console.log(data);
					var result = "<table>";
					var arr = data.split(",");
					for(i=0;i<arr.length-1;i++) {
						var str = arr[i].split(" ");
						result += "<tr>";
						result += "<td>"+str[0]+"<input type='hidden' value ='" + str[0] + "' name='id'></td> ";
						result += "<td><input type='text' value ='" + str[1] + "' name='name'></td> ";
						result += "<td><input type='text' value ='" + str[2] + "' name='age'></td> ";
						result += "<td><input type='text' value ='" + str[3] + "' name='grade'></td> ";
						result += "<td><a href='#' class='update' >수정</a> / <a href='#' class='delete' >삭제</a></td> </tr>";
					}
					result += "</table>";
					$("#content_area").html(result); */
				}
				
			});
		});
		
		$("input[name=search]").keyup(function() {
			$("#btn_submit").click();
		});
		
		$("select").change(function () {
			$("input[name=search]").val("");
			$("#btn_submit").click();
		});
		
		$("#btn_submit").click();
	});

	
</script>
<style type="text/css">
	* {
		margin:0;
		padding:0;
	}
	
	#container {
		width:100%;
	}
	
	nav {
		padding-top:30px;
	}
	
	button {
		display: inline-block;
	}
	
	#menu_bar {
		width:100%;
		box-sizing: border-box;
		text-align: center;
		font-size:20px;
		margin-bottom:10px;
	}
	
	#menu_bar select {
		width:120px;
		padding: 5px;
		margin-right:5px;		
	}
	#menu_bar input {
		width: 250px;
		padding:5px;
		margin-right:5px;
	}
	#menu_bar button {
		width:100px;
		padding:5px;
	}
	
	#content > ul {
		font-size:0px;
	}
	
	#content > ul > li{
		width:230px;
		display: inline-block;
		font-size:16px;
		text-align: center;
		font-weight: bold;
		padding: 10px;
		box-sizing: border-box;
	}
	
	table {
		border-collapse: collapse;
		margin:0 auto;
		font-size:0px;
	}
	
	td {
		width:230px;
		font-size:16px;
		padding:10px;
		box-sizing: border-box;
		text-align: center;
	}
</style>
</head>
<body>
	
	<%
		if(session.getAttribute("login") == null || !session.getAttribute("grade").equals("master")) {
			%>
			<script type="text/javascript">
				alert("관리자 계정이 아닙니다.");
				location.href="<%=request.getContextPath()%>/index.jsp";
			</script>
			<%
		}
	
		String param = "";
		if(!request.getQueryString().equals(null)) {
			param += "?"+request.getQueryString();
		}
		session.setAttribute("last", request.getRequestURI()+param);
	
	%>
	
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<div id="menu_bar">
				<form action="" id="search">
					<select name="kind">
						<option value="id" selected>아이디</option>
						<option value="name">이름</option>
						<option value="grade_name">등급</option>
					</select>
					<input type="text" name="search">
					<button id="btn_submit" type="button">검색</button>
				</form>
			</div>
			<hr>
			<div id="content">
				<ul>
					<li>아이디</li>
					<li>이름</li>
					<li>나이</li>
					<li>등급</li>
					<li>비고</li>
				</ul>
				<hr>
				<div id="content_area">
					
				</div>
			</div>
			
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>