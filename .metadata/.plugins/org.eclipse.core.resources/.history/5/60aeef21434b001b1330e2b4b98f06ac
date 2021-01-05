<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String search = "%"+request.getParameter("name")+"%";
	String sql = "select id, pass, name, age, grade_name "
			+ "from member,grade_list where member.grade = grade_list.grade and name like ?";
	
	String sql2 = "SELECT id,pass,name,age,grade_name FROM MEMBER,GRADE_LIST WHERE member.grade = grade_list.grade AND name Like ?";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String result = "";
	pstmt = DBManager.getInstance().getConnection().prepareStatement(sql2);
	pstmt.setString(1, search);
	rs = pstmt.executeQuery();
	while(rs.next()){	//아이디 이름 나이 등급,아이디 이름 나이 등급,아이디 이름 나이 등급,...
		result += String.format("%s %s %d %s,", 
				rs.getString(1), rs.getString(3),rs.getInt(4), rs.getString(5));
	}
	out.write(result);//client에게 데이터 넘겨주는 부분
	System.out.println(result);
	DBManager.getInstance().close(pstmt, rs);	
%>












