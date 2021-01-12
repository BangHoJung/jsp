<%-- <%@page import="dto.BoardDTO"%>
<%@page import="service.BoardService"%>
<%@page import="java.util.ArrayList"%>
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
		$("tbody tr").click(function() {
			var bno = $(this).children().eq(0).html();
			console.log(bno+"\n<%=request.getContextPath()%>");
			
			location.href = "<%=request.getContextPath()%>/board/board_view.jsp?bno="+bno;
			
		});
	});
</script>
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
	
	nav table {
		margin:0 auto;
		margin-top:20px;
		margin-bottom:20px;
		text-align: center;
		font-size:0px;
		border-collapse: collapse;
	}
	nav th, nav td {
		padding:5px;
		font-size:16px;
	}
	
	nav th {
		border-top:2px solid black;
		border-bottom:2px solid black;
	}
	
	nav tbody tr:hover {
		border:1px solid black;
		background: silver;
		box-sizing: border;
	}
	
	nav td:nth-of-type(2) {
		width:300px;
	}
	
	nav td:nth-of-type(3) {
		width:150px;
	}
	
	nav td:nth-of-type(4) {
		width:200px;
	}
	
	nav tr:last-child {
		border-bottom:2px solid black;
	}
}
	
</style>
</head>
<body>
	<%
		ArrayList<BoardDTO> list = BoardService.getInstance().searchAllBoardDTO();
	%>
	
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>좋아요</th>
						<th>싫어요</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i=0;i<list.size();i++) {
						%>
							<tr>
								<td><%=list.get(i).getBno() %></td>
								<td><%=list.get(i).getTitle()%></td>
								<td><%=list.get(i).getWriter()%></td>
								<td><%=list.get(i).getDate() %></td>
								<td><%=list.get(i).getCount() %></td>
								<td><%=list.get(i).getLike() %></td>
								<td><%=list.get(i).getHate() %></td>
							</tr>
						<%
					}
				%>
				</tbody>
			</table>
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
	
</body>
</html> --%>