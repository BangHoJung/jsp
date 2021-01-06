<%@page import="dto.BoardDTO"%>
<%@page import="service.BoardService"%>
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
		
		$(".btn_like_hate").click(function() {
			var data = "bno=<%=request.getParameter("bno")%>&id=" + $(this).attr("id");
			var obj = $(this);
			$.ajax({
				url : "process/board_like_hate_process.jsp",
				data : data,
				method : 'get',
				success : function(d) {
					d = d.trim();
					console.log(d);
					$(obj).children("span").html(d);
				}
			})
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
		margin:0 auto;
		margin-top:20px;
		margin-bottom:20px;
	}
	
	nav table{
		width:800px;
		border-collapse: collapse;
		margin:0 auto;
	}
	nav th{
		width:100px !important;
		text-align: right;
		padding:5px;
	}
	nav td{
		width: 500px;
		padding:5px;
		height: 40px;
	}
	nav td > input{
		width: 100%;
		height:40px;
		box-sizing:border-box;
		border-width : 1px;
		border-radius: 5px;
	}
	h2{
		text-align: center;
	}
	.btn{
		text-decoration: none;
		background-color: #e8e8e8;
		display: inline-block;
		margin:5px 10px;
		padding:5px 20px;
		font-weight:normal;
		border : 1px solid #585858;
		text-align:center;
		color : black;
		font-size:14px;
		box-sizing: border-box;
	}
	.btn:hover{
		background-color: #282828;
		color:#FFFFFF
	}
	td > div {
		width:100%;
		height: 300px;
		resize: none;
		box-sizing: border-box;
	}
	
	td img {
		width:30px;
		height: 30px;
		flaot:left;
		padding-right:10px;
	}
	
	td span {
		float:right;
		font-size:20px;
		padding:0px 15px;
	}
	
	#delete {
		float:right;
	}
	
	#update {
		float:right;
	}
	
		
	.btn_like_hate {
		text-decoration: none;
		display: inline-block;
		margin:5px 10px;
		padding:5px 10px;
		font-weight:normal;
		text-align:center;
		color : black;
		font-size:14px;
		box-sizing: border-box;
		border-radius: 10px;
		background-color: white;
		margin-left:15%;
	}
	
	#like {
		color: blue;
		border:2px solid blue;
	}
	
	#hate {
		color: red;
		border:2px solid red;
	}

	
	#prev {
		float: left;
	}
	
	#next {
		float: right;
	}
	
	#list {
		float:left;
		margin-left:30%;
	}
	
</style>
</head>
<body>
	<%
		BoardDTO dto = null;
		int bno = 0;
		if(session.getAttribute("login") == null || (boolean) session.getAttribute("login")==false){
			%>
				<script>
					location.href="<%=request.getContextPath()%>/index.jsp";
				</script>
			<%
		}
		
		bno = Integer.parseInt(request.getParameter("bno"));
		dto =  BoardService.getInstance().searchBoardDTO(bno);
		
	%>
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<h2>작성글 조회</h2>
			<form action="/process/board_wirte_process" method="post">
				<table>
					<%
						if(dto.getWriter().equals(session.getAttribute("id"))) {
					%>
					<tr>
						<th></th>
						<td>
							<a href="#" id="update" class="btn">수정</a>
							<a href="#" id="delete" class="btn">삭제</a>
						</td>
						
					</tr>
					<%
						}
					%>
					<tr>
						<th>작성일</th>
						<td><%=dto.getDate() %></td>
					</tr>
					<tr>
						<th>조회수</th>
						<td><%=dto.getCount() %></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="hidden" name="title" value="<%=dto.getTitle()%>">
							<%=dto.getTitle()%>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>
							<input type="hidden" name="writer" value="<%=dto.getWriter()%>">
							<%=dto.getWriter()%>					
						</td>
					</tr>
					<tr>
						<th style="vertical-align: top;">내용</th>
						<td>
							<div style="white-space:pre;"><%=dto.getContent()%></div>
						</td>
					</tr>
					<tr>
						<th>
						</th>
						<td>
							<a href="#" id="like" class="btn_like_hate">
								<img src="../img/like.png"> 
								 <span><%=dto.getLike() %></span>
							</a> 
							<a href="#" id="hate" class="btn_like_hate">
								<img src="../img/hate.png"> 
								<span><%=dto.getHate() %></span>
							</a> 
						</td>
					</tr>
					<tr>
						<th><hr></th>
						<td><hr></td>
					</tr>
					<tr>
						<th>
							<a href="#" class="btn" id="prev">이전글</a>
						</th>
						<td>
							<a href="board_list.jsp" class="btn" id="list">목록으로</a>
							<a href="#" class="btn" id="next">다음글</a>
						</td>
					</tr>
				</table>
			</form>
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>