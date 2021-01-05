<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>

<%!
	boolean checkNumber(int arr[],int n){
		for(int i=0;i<arr.length;i++){
			if(arr[i]==n) 
				return false;
		}
		return true;
	}
%>

<%
	int num = Integer.parseInt(request.getParameter("lotto"));
	String tag = new String();
	HashSet<Integer> set = new HashSet<Integer>();
	
	int[][] result = new int[num][6];
	
	tag +="<table>";
	for(int i=0;i<num;i++) {
		while(set.size()<6) {
			set.add((int)(Math.random()*45)+1);
		}
		
		String[] str = set.toString().replace("[","").replace("]","").
				replaceAll(" ","").split(",");
		tag += "<tr>";
		for(String n : str) {
			tag += "<td>"+n+"</td>";
		}
		tag += "</tr>";
		set.clear();
	}
	tag +="</table>";
	
	
	request.setAttribute("tag", tag);
	RequestDispatcher dispatcher = request.getRequestDispatcher("lotto_result2.jsp");
	
	dispatcher.forward(request, response);
%>