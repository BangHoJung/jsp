<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.MemberVO" %>
<%@ page import="service.MemberService" %>

    <%
    	request.setCharacterEncoding("utf-8");
    	String id=request.getParameter("id");
    	String pass=request.getParameter("pass");
    	
    	MemberVO vo = MemberService.getInstance().checkLoginMember(id,pass);
    	
    	if(vo != null) {
    		session.setMaxInactiveInterval(60*30);
    		session.setAttribute("login", true);
    		session.setAttribute("id", vo.getId());
    		session.setAttribute("name", vo.getName());
    		session.setAttribute("grade", vo.getGrade());
    		//response.sendRedirect(request.getContextPath() + "/index.jsp");
    		response.sendRedirect(session.getAttribute("last").toString());
    	}
    	else {
    		session.setAttribute("login", false);
    		%>
    		<script>
    			alert("아이디와 비밀번호를 확인하세요");
    			history.back();
    		</script>
    		<%
    	}
    %>