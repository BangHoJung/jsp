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
	
	int[][] result = new int[num][6];
	for(int i=0;i<num;i++) {
		for(int j=0;j<6;j++) {
			int ran = (int)(Math.random()*45)+1;
			if(checkNumber(result[i],ran)) {
				result[i][j] = ran;
			}
			else {
				j--;
			}
		}
	}
	
	request.setAttribute("result", result);
	RequestDispatcher dispatcher = request.getRequestDispatcher("lotto_result.jsp");
	
	dispatcher.forward(request, response);
	//response.sendRedirect("lotto_result.jsp");
%>