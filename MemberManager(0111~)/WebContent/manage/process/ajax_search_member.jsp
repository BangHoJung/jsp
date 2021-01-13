<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberVO"%>
<%@page import="service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		String kind = request.getParameter("kind");
		String search = request.getParameter("search");
		if(search.equals(null)) search="";
		System.out.print(kind + " , " + search + "\n");
		
		
		
		ArrayList<MemberVO> list = MemberService.getInstance().searchAllMemberVO();
		String result="";
		
		if(kind.equals("id")) {
			System.out.print("id");
			for(int i=0;i<list.size();i++) {
				if(list.get(i).getId().indexOf(search)!=-1) {
					result += list.get(i).getId() + " ";
					result += list.get(i).getName() + " ";
					result += list.get(i).getAge() + " ";
					result += list.get(i).getGrade()+",";
				}
			}
		}
		else if(kind.equals("name")) {
			System.out.print("name");
			for(int i=0;i<list.size();i++) {
				if(list.get(i).getName().indexOf(search)!=-1) {
					result += list.get(i).getId() + " ";
					result += list.get(i).getName() + " ";
					result += list.get(i).getAge() + " ";
					result += list.get(i).getGrade()+",";
				}
			}
		}
		else {
			System.out.print("grade");
			for(int i=0;i<list.size();i++) {
				if(list.get(i).getGrade().indexOf(search)!=-1) {
					result += list.get(i).getId() + " ";
					result += list.get(i).getName() + " ";
					result += list.get(i).getAge() + " ";
					result += list.get(i).getGrade()+",";
				}
			}
		}
		
		System.out.print(result);
		
		out.write(result);
	%>