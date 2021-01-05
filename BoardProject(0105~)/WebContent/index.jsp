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
	
</style>
</head>
<body>
	<!-- header.jsp를 현재 문서에 포함 -->
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			메인페이지
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>