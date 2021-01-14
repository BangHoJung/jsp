<%@page import="service.BoardService"%>
<%@page import="dto.BoardDTO"%>
<%@page import="service.MemberService"%>
<%@ page errorPage="/error/error.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		BoardDTO board = new BoardDTO(title,writer,content);
		int bno = BoardService.getInstance().insertBoardDTO(board);
		
		System.out.print(bno+"\n");
		
		//게시글 조회 페이지 board_view.jsp 게시글 번호
		response.sendRedirect(request.getContextPath()+"/board/board_view.jsp?bno="+bno);
	%>