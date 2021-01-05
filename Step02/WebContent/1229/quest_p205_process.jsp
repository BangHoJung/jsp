<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		border-collapse: collapse;
	}

	th,td {
		border:1px solid black;
		padding:10px;
		font-size:15px;
	}
</style>
</head>
<body>
	<h1>입력한 숫자만큼 반복수행</h1>
	<table>
		<tr>
			<th>글번호</th>
			<th>글제목</th>
			<th>글내용</th>
		</tr>
		
		<% int num = Integer.parseInt(request.getParameter("num")); 
			for(int i=num;i>0;i--) {
		%>
		<tr>
			<td><%=i %></td>
			<td>제목<%=i %></td>
			<td>내용 <%=i %></td>
		</tr>
		<%} %>
	</table>
	
</body>
</html>