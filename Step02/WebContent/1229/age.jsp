<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 입력받은 나이가 20세 이상 : age_result_1.jsp , 20세 미만: age_result_2.jsp -->
	<form action="age_process.jsp" method="get">
		<input type="text" name="age" placeholder="나이 입력">
		<button>제출</button>
	</form>
</body>
</html>