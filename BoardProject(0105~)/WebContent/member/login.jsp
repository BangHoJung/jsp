<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
	});
</script>

<style type="text/css">
	* {
		margin:0;
		padding:0;
	}
	
	#container {
		width:100%;
		text-align: center;
	}
	
	nav {
		padding-top:200px;
		height: 400px;
	}
	
	button {
		display: inline-block;
	}
</style>
</head>
<body>
	<!-- header.jsp를 현재 문서에 포함 -->
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<%
				boolean flag = false;
				if(session.getAttribute("login") != null)
					flag = (boolean)session.getAttribute("login");
				if(flag) { 
					%>
					<%-- <%=session.getAttribute("name") %> 님이 로그인 하셨습니다.<br>
					<a href="<%=request.getContextPath() %>/member/process/logout_process.jsp">로그아웃</a> | <a href="<%=request.getContextPath() %>/member/member_update_view.jsp">정보수정</a> --%>
					<%
				}
				else { %>
					<form action="<%=request.getContextPath() %>/member/process/login_process.jsp" method="post">
						아이디 : <input type="text" name="id" id="id">  <br>
						암호 : <input type="password" name="pass"> <br>
						<button id="login" type="submit">로그인</button>
						<a href="register.jsp" type="button">회원가입</a>
						<a href="find_pass.jsp" type="button" >비밀번호 찾기</a>
					</form>
				<% 
				}
			%>
			
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>