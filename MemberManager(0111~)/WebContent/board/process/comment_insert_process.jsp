<%@page import="dto.CommentDTO"%>
<%@page import="service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		int bno = Integer.parseInt(request.getParameter("bno"));
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		System.out.print(bno + " , " + writer + " , " + content);
		
		int count = BoardService.getInstance().insertBoardComment(new CommentDTO(bno,content,writer));
		
		out.write(""+count);
	%>
