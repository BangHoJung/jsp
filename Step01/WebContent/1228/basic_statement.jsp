<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기초문법</title>
</head>
<body>

<!-- 선언문 -->
<%!
	//필드와 메서드를 작성
	String message = "선언문 메세지";
	public String getMessage() {
		return message;
	}
	
%>

<!-- 표현식 -->
선언문 필드 테스트 : <%=message%> <br>
선언문 메서드 테스트 : <%=getMessage() %> <br>

<!-- 스크립트릿 : 사용자가 서버에 데이터를 전달하는 수단 -->
<!-- jsp 직접 처리하는 코드 -->
<%
	//request는 사용자의 요구사항 및 사용자 정보를 담고있는 객체
	int num = Integer.parseInt(request.getParameter("num"));
	String str = request.getParameter("msg");
%>
스크립트릿 테스트 : <%=num%>
스크립트릿 테스트 : <%=str%>

</body>
</html>