<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>    
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
</style>
</head>
<body>
	<div id="container">
		<jsp:include page="template/header.jsp" flush="false"></jsp:include>
		<nav>
		작업 에러 : <%=exception.getMessage() %><br>
		<a href="javascript:history.back();">뒤로가기</a>
		</nav>
		<jsp:include page="template/footer.jsp" flush="false"></jsp:include>
	</div>
	
</body>
</html>