<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int age = Integer.parseInt(request.getParameter("age"));
	RequestDispatcher dispatcher = null;

	if(age >= 20) {
		dispatcher = request.getRequestDispatcher("age_result_1.jsp");
	}
	else {
		dispatcher = request.getRequestDispatcher("age_result_2.jsp");
	}
	
	dispatcher.forward(request, response);
%>