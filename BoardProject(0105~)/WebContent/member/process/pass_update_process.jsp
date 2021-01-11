<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page errorPage="/error/error.jsp" %>

	<%	
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pass = request.getParameter("pass_update");

		MemberService.getInstance().updatePass(id, pass);
		
		response.sendRedirect(session.getAttribute("last").toString());

	%>