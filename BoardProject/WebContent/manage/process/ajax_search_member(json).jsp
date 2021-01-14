<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="config.DBManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	
	    String kind = request.getParameter("kind");
		String search = request.getParameter("search");
		if(search.equals(null)) search="";
		search = "%"+search+"%";
		
		String sql = "SELECT id,name,age,grade_name FROM MEMBER m , grade_list g WHERE m.grade=g.grade AND "+kind+" LIKE ? ORDER BY "+kind+" ASC";
		PreparedStatement pstmt = DBManager.getInstance().getConn().prepareStatement(sql);
		pstmt.setString(1, search);
		ResultSet rs = pstmt.executeQuery();
		
		JSONObject jsonObject = new JSONObject();
    	jsonObject.put("kind",kind);
    	jsonObject.put("search",search);
    	JSONArray jsonArray = new JSONArray();
    	
    	while(rs.next()) {
    		JSONObject temp = new JSONObject();
    		temp.put("id",rs.getString(1));
    		temp.put("name",rs.getString(2));
    		temp.put("age",rs.getInt(3));
    		temp.put("grade_name",rs.getString(4));
    		jsonArray.put(temp);
    	}
    	
    	jsonObject.put("result",jsonArray);
    	out.write(jsonObject.toString());
    	System.out.print(jsonObject.toString());
    	DBManager.getInstance().close(pstmt, rs);
    
    %>
    