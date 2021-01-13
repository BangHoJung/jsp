<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		text-align: center;
	}
	
	nav {
		width:100%;
	}
	#qna_form {
		margin:0 auto;
		width:700px;
	}
	
	#qna_form table {
		border-collapse: collapse;
		box-sizing: border-box;
		width:100%;
	}
	
	#qna_form td {
		padding:5px;
	}
	
	#qna_form input {
		width:550px;
		font-size:18px;
		border-radius: 5px;
		padding:5px;
	}
	
	#qna_form textarea {
		width:550px;
		height:100px;
		font-size:16px;
		padding:5px;
	}
	
	#qna_form button {
		width:100px;
		height:150px;
	}
	
</style>
</head>
<body>
	<%
		if(session.getAttribute("login")==null || !(boolean)session.getAttribute("login")) {
			%>
			<script>
				alert("로그인이 필요합니다");
				location.href="<%=request.getContextPath()%>/index.jsp";
			</script>
			<%
		}
		
		String param = "";
		if(request.getQueryString()!=null) {
			param += "?"+request.getQueryString();
		}
		session.setAttribute("last", request.getRequestURI()+param);
	%>

	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<c:if test="${sessionScope.grade != 'master' }">
				<div id="qna_form">
					<form action="<%=request.getContextPath() %>/register_qna.do" method="post">
						<table>
							<tr>
								<td><input type="text" name="title" placeholder="문의 제목"></td>
								<td rowspan="2"><button type="submit">문의 등록</button></td>
							</tr>
							<tr>
								<td><textarea name="content" placeholder="문의 내용을 입력해주세요"></textarea></td>
							</tr>
						</table>
						
					</form>
					<hr>
				</div>
			</c:if>
			<div id="qna_list">
				<c:forEach var="dto" items="${requestScope.list }">
					${dto.qdate} | 
					<c:choose>
						<c:when test="${dto.status == 0}"> 
							읽지않음
						</c:when>
						<c:when test="${dto.status == 1}">
							읽었음
						</c:when>
						<c:otherwise>
							답변완료
						</c:otherwise>
					</c:choose>
					 | ${dto.response} | <br>
					${dto.title } | ${dto.writer }<br>
					${dto.content } <br>
				</c:forEach>
				
			</div>
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>