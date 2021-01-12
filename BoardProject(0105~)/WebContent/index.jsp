<%@page import="dao.BoardDAO"%>
<%@page import="vo.PagingVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="service.BoardService"%>
<%@page import="dto.BoardDTO"%>
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
			
			location.href = "<%=request.getContextPath()%>/board/board_view.jsp" +
					"?currPage=<%=request.getParameter("currPage")%>&bno="+bno+"";
			
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
	
	#search {
		text-align: center;
		font-size:18px;
		height: 30px;
		margin:20px 0px;
	}
	
	#search > input{
		width:300px;
		margin: 0px 20px;
		height: 100%;
	}
	
	#select {
		display: inline-block;
		width:100px;
		height: 100%;
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
	
	.btn{
		text-decoration: none;
		background-color: #e8e8e8;
		width: 80px;
		display: inline-block;
		padding:5px 0px;
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
	
	tfoot td > a:link,tfoot td > a:visited {
		color : black;
		text-decoration: none;
		font-size:18px;
		margin:0px 10px;
	}
	
	tfoot td > a:hover {
		font-weight: bold;
		color:red;
	}
	
	tfoot td > span {
		float:right;
	}
	
	#page_select {
		color:blue;
	}
	
</style>
</head>
<body>
	<%
		String param = "";
		if(request.getQueryString()!=null) {
			param += "?"+request.getQueryString();
		}
		session.setAttribute("last", request.getRequestURI()+param);
		session.setAttribute("lastBoard", request.getRequestURI()+param);
		System.out.println("lb = "+session.getAttribute("lastBoard"));
		
		System.out.println("param : "+param);
		int currPage = 1;
		if(request.getParameter("currPage") != null) {
			currPage = Integer.parseInt(request.getParameter("currPage"));
			System.out.println("currPage : " + currPage);
		}
		else {
			response.sendRedirect("index.jsp?currPage=1&sort=bno");
		}
		int count = BoardDAO.getInstance().countAllBoard();
		PagingVO pageVO = new PagingVO(count,currPage);
		
		/* String sort="bno";
		if(request.getParameter("sort") != null) {
		} */
		String sort = request.getParameter("sort");
		ArrayList<BoardDTO> board_list = BoardService.getInstance().searchAllBoardDTO(currPage,sort);
		HashMap<Integer, Integer> map = BoardService.getInstance().countAllComment(); 
		
	%>
	
	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		<div id="search">
			<div id="select">
				제목
			</div>
			<input type="text">
			<a href="#" class="btn">검색</a>
		</div>
		<nav>
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th><a href="index.jsp?currPage=1&sort=bcount">조회수</a></th>
						<th><a href="index.jsp?currPage=1&sort=blike">좋아요</a></th>
						<th><a href="index.jsp?currPage=1&sort=bhate">싫어요</a></th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i=0;i<board_list.size();i++) {
						%>
							<tr>
								<td><%=board_list.get(i).getBno() %></td>
								<td><%=board_list.get(i).getTitle()%> 
								<%
								if(map.containsKey(board_list.get(i).getBno())) {
									%>
									[<%=map.get(board_list.get(i).getBno())%>]
									<%
								}
								%>
								</td>
								<td><%=board_list.get(i).getWriter()%></td>
								<td><%=board_list.get(i).getDate() %></td>
								<td><%=board_list.get(i).getCount() %></td>
								<td><%=board_list.get(i).getLike() %></td>
								<td><%=board_list.get(i).getHate() %></td>
							</tr>
						<%
					}
				%>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7">
							<%
							if(pageVO.isPrevPageGroup()) { 
							%>	
								<a href="index.jsp?currPage=<%=pageVO.getStartPageOfPageGroup()-1%>&sort=<%=sort%>">◀</a>
							<%}
							for(int i=pageVO.getStartPageOfPageGroup();i<=pageVO.getEndPageOfPageGroup();i++) {
								if(currPage == i) {%>
									<a href="" id="page_select"><%=i%></a>
								<%}
								else {%>
									<a href="index.jsp?currPage=<%=i%>&sort=<%=sort%>"><%=i%></a>
								<%}
							}
							if(pageVO.isNextPageGroup()) {%>
								<a href="index.jsp?currPage=<%=pageVO.getEndPageOfPageGroup()+1%>&sort=<%=sort%>">▶</a>
							<%}%>
							<span><a href="<%=request.getContextPath() %>/board/board_write_view.jsp" class="btn">글쓰기</a></span>
						</td>
					</tr>
				</tfoot>
			</table>
		</nav>
		<div id="">
			<span>
				
			</span>
			
		</div>
	
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>