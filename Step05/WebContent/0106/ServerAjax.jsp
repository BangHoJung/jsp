<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	String search = "%" + request.getParameter("name") + "%";
    	String sql = "SELECT id,pass,name,age,grade_name FROM MEMBER m, grade_list g WHERE m.grade=g.grade AND name LIKE ?";
    	PreparedStatement pstmt =  DBManager.getInstance().getConnection().prepareStatement(sql);
    	
    	pstmt.setString(1, search);
    	ResultSet rs = pstmt.executeQuery();
    	
    	//JSON 객체 생성
    	JSONObject jsonObject = new JSONObject();
    	jsonObject.put("search",request.getParameter("name"));
    	JSONArray jsonArray = new JSONArray();
    	
    	while(rs.next()) {
    		JSONObject temp = new JSONObject();
    		temp.put("id",rs.getString(1));
    		temp.put("name",rs.getString(3));
    		temp.put("age",rs.getInt(4));
    		temp.put("grade_name",rs.getString(5));
    		jsonArray.put(temp);
    	}
    	jsonObject.put("result",jsonArray);
    	out.write(jsonObject.toString());
    	System.out.print(jsonObject.toString());
    	DBManager.getInstance().close(pstmt, rs);
    %>