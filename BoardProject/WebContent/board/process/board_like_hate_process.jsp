<%@page import="service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		String lh = request.getParameter("id");
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		int count = BoardService.getInstance().addLikeHateBoardDTO(bno,lh);
		System.out.print(count+"\n");
		out.write(""+count);
		
	%>