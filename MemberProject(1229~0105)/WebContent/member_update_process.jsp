<%@page import="vo.MemberVO"%>
<%@ page import="service.MemberService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>

    <%
    	request.setCharacterEncoding("utf-8");
    	String id = request.getParameter("id");
    	String pass = request.getParameter("pass");
    	String name = request.getParameter("name");
    	int age = Integer.parseInt(request.getParameter("age"));
    	
    	MemberVO vo = new MemberVO(id,pass,name,age,null);
    	
    	MemberService.getInstance().updateMemberVO(vo);
    	
    	session.setAttribute("name", vo.getName());
    	
    	%>
    	
    	<script>
    			alert("정보 수정 성공");
    			location.href="main.jsp";
   		</script>
   		
   		<%
   		System.out.print("정보 변경 성공");
    %>