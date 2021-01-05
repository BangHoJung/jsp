<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table {
		border-collapse: collapse;
	}

	td {
		border:1px solid black;
		padding:10px;
		font-size:15px;
	}
</style>
</head>
<body>

	<%
		int[][] result = (int[][]) request.getAttribute("result");
		//String[] result = request.getParameter("result");
		System.out.print(result.toString());
	%>
	
	<table>
		<!-- 선생님 방법 -->
		<%-- <%
		int[][] lotto = (int[][])request.getAttribute("lotto");
		for(int i=0;i<lotto.length;i++){
			out.write("<tr>");
				for(int j=0;j<lotto[i].length;j++)
					out.write("<td>"+lotto[i][j]+"</td>");
			out.write("</tr>");
		}
		%> --%>
		
		<% for(int i=0;i<result.length;i++) {%>
		<tr>
			<td><%=(i+1)%>set</td>
			<%for(int j=0;j<result[i].length;j++) { %>
			<td><%=result[i][j] %></td>
			<% } %>
		</tr>
		<% } %>
		
	</table>
	
</body>
</html>