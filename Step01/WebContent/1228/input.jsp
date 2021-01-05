<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- text box, submit button -->
	<form action="jsp_search.jsp" method="get">
		<input type="text" name="search">
		<button>제출</button>
	</form>
	
	<hr>
	
	<form action="gugu.jsp" method="get">
		<input type="text" name="dan" placeholder="출력할 구구단 단을 입력">
		<button>제출</button>
	</form>
	
</body>
</html>