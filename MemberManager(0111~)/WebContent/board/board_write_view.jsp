<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	* {
		margin:0;
		padding:0;
	}
	
	#container {
		width:100%;
	}
	
	nav {
		height: 600px;
	}
	
	nav table{
		width:600px;
		border-collapse: collapse;
		margin:0 auto;
	}
	nav th{
		width:150px !important;
		text-align: right;
		padding:5px;
	}
	nav td{
		width: 500px;
		padding:5px;
		height: 40px;
	}
	nav input{
		width: 100%;
		height:40px;
		box-sizing:border-box;
		border-width : 1px;
		border-radius: 5px;
	}
	h2{
		text-align: center;
	}
	.btn{
		text-decoration: none;
		background-color: #e8e8e8;
		width: 80px;
		display: inline-block;
		padding:5px 0px;
		font-weight:normal;
		border : 1px solid #585858;
		text-align:center;
		color : black;
		font-size:14px;
		box-sizing: border-box;
	}
	.btn:hover{
		background-color: #282828;
		color:#FFFFFF
	}
	textarea {
		width:100%;
		height: 300px;
		resize: none;
		box-sizing: border-box;
	}
	
</style>
</head>
<body>
	<%
		if(session.getAttribute("login") == null || (boolean) session.getAttribute("login")==false){
			%>
				<script>
					alert("로그인을 해주세요");
					<%-- location.href="<%=request.getContextPath()%>/index.jsp"; --%>
					history.back();
				</script>
			<%
		}
		else {
			String param = "";
			if(request.getQueryString()!=null) {
				param += "?"+request.getQueryString();
			}
			session.setAttribute("last", request.getRequestURI()+param);
		}
	%>
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<h2>글쓰기 페이지</h2>
		<form action="process/board_write_process.jsp" method="post">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input type="hidden" name="writer" value="<%=session.getAttribute("id")%>">
						<%=session.getAttribute("id")%>					
					</td>
				</tr>
				<tr>
					<th style="vertical-align: top;">내용</th><td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th><a href="<%=session.getAttribute("lastBoard") %>" class="btn">목록보기</a></th>
					<td style="text-align: right;">
						<a href="javascript:history.back();" class="btn">뒤로가기</a>
						<button class="btn" type="submit">글쓰기</button>
					</td>
				</tr>
			</table>
		</form>
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>