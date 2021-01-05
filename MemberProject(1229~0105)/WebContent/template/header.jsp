<%@ page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
		header {
			border:2px solid black;
			margin:0 auto;
			width:60%;
			height: 50px;
		}
		ul {
			list-style: none;
			text-align: center;
		}
		li {
			display: inline-block;
			padding: 15px 15px 0px 15px;
		}
		li a:link, li a:visited {
			text-decoration: none;
			color:black;
		}
		li a:hover {
			color:red;
		}
		
		#name {
			font-size:15px;
			color:blue;
			float:right;
			display: inline-block;
		}
		
		#name > img {
			width:30px;
			height: 30px;
		}
		
		#name span {
			padding-bottom:15px;
		}
	</style>

	<header>
		<ul>
			<li><a href="main.jsp">HOME</a></li>
			<%
				boolean flag = false;
				if(session.getAttribute("login") != null)  {
					flag = (boolean)session.getAttribute("login");
				}
				if(flag) {
					String name = (String)session.getAttribute("name");
					String grade = (String)session.getAttribute("grade");
					%>
					<li><a href="logout.jsp">로그아웃</a></li>
					<li><a href="member_update_view.jsp">회원정보변경</a></li>
					<%
					if(grade.equals("master") ) {
						%>
						<li><a href="member_manage.jsp">회원관리</a></li>
						<%
					}
					%>
					<li><a href="#">문의하기</a></li>
					<!-- div로 구성해서 따로 배치 -->
					<li id="name"><img src="img/<%=grade%>.png"><span><%=name %>님 로그인 하셨습니다.</span></li>
					<%
				}
				else {
					%>
					<li><a href="register.jsp">회원가입</a></li>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="#">회원관리</a></li>
					<li><a href="#">문의하기</a></li>
					<%
				}
				%>
		</ul>
	</header>