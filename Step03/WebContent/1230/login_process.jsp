<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		
		String id= request.getParameter("id");
		String pass= request.getParameter("pass");
		
		session.setMaxInactiveInterval(60*30);
		if(id.equals("admin") && pass.equals("1234")) {
			//로그인성공
			session.setAttribute("login", true);
			session.setAttribute("name", "관리자");
			session.removeAttribute("msg");
		}
		else {
			//로그인실패
			session.setAttribute("login", false);
			session.setAttribute("msg", "로그인 실패 - 아이디 비밀번호 확인");
		}
		
		response.sendRedirect("login.jsp");
		
	%>