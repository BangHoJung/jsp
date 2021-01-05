<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");//post 방식 반드시 인코딩
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("id"));

	MemberVO vo = new MemberVO(id,pass,name,age);
	//서비스 클래스로 vo를 전달
	

%>