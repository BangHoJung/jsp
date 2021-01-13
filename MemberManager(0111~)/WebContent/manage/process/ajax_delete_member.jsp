<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		String id= request.getParameter("id");
	
		boolean result = MemberService.getInstance().deleteManageMemberVO(id);
		
		out.write(""+result);
	%>