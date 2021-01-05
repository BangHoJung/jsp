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
		int dan = Integer.parseInt(request.getParameter("dan"));
		response.getWriter().println("<h2>"+dan+"단</h2>");
		for(int i=1;i<10;i++) {
			//response.getWriter().println(dan+" * "+i+" = "+dan*i+"<br>");
	%>
		<p> <%=dan %> * <%=i %> = <%=dan * i %></p>
	<%
		}
		response.getWriter().println("첫번째 테스트 영역"+"<br>");
	%>
	
</body>
</html>