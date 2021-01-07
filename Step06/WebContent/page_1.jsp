<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		pageContext.setAttribute("num", 20);
		pageContext.setAttribute("test", "testMessage");
	%>
	
	<%=pageContext.getAttribute("num") %><br>
	<%=pageContext.getAttribute("test") %><br>
	<a href="page_2.jsp">다음 페이지</a>
</body>
</html>