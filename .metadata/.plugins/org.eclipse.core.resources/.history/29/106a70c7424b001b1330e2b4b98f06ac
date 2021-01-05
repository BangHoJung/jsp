<%@page import="service.MemberService"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		String name = request.getParameter("name");
		ArrayList<MemberVO> list = MemberService.getInstance().searchNameMemberVO(name);
		
		String result="";
		for(int i=0;i<list.size();i++) {
			result += list.get(i).getId() + " ";
			result += list.get(i).getName() + " ";
			result += list.get(i).getAge() + " ";
			result += list.get(i).getGrade() + ",";
		}
		
		out.write(result);
		
	%>