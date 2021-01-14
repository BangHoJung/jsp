<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	var nextPage = ${requestScope.nextPage};
	$(document).on("click","#qna_list tbody tr", function() {
		console.log($(this).children("td > input").eq().val());
	});
	
	$(function() {
		if(nextPage == "0") {
			$("#btn_more").css("display","none");
		}
		
		$("#btn_more").click(function() {
			var data = "nextPage="+nextPage;
			var obj = $(this);
			console.log("data :" + data);
			$.ajax({
				url : "next_qnaList.do",
				data : data,
				method : 'get',
				success : function(d) {
					var json = JSON.parse(d);
					console.log(json);
					nextPage = json.nextPage;
					if(nextPage=="0") {
						$("#btn_more").css("display","none");
					}
					var result="";
					for(i=0;i<json.array.length;i++) {
						result+="<tr>";
						result+="<td><input type='hidden' value='"+json.array[i].qid+"'>"+json.array[i].title	+"</td>";
						result+="<td>"+json.array[i].writer+"</td>";
						result+="<td>"+json.array[i].qdate+"</td>";
						if(json.array[i].status == 0) {
							result+="<td>읽지않음</td>";
						}
						else if(json.array[i].status == 1) {
							result+="<td>읽었음</td>";
						}
						else {
							result+="<td>답변완료</td>";
						}
						result+="</tr>";
					}
					console.log(result);
					$("#qna_list tbody").append(result);
				}
			}); 
		});
	});
</script>
<style type="text/css">
	* {
		margin:0;
		padding:0;
	}
	#container {
		width:100%;
		text-align: center;
	}
	
	nav {
		margin:0 auto;
	}
	
	#qna_list {
		width:800px;
		margin:0 auto;
		margin-top:30px;
		margin-bottom:30px;
	}
	
	#qna_list table {
		border-collapse: collapse;
		font-size:0px;
		width:100%;
		border-top:2px solid black;
		border-bottom:2px solid black;
	}
	
	#qna_list tr {
		font-size:16px;
	}
	
	#qna_list tbody tr:hover {
		border:1px solid black;
		background-color: silver;
	}
	
	#qna_list th {
		border-bottom:2px solid black;
	}
	
	#qna_list td,th {
		padding:10px;
		width:20%;
		text-align: center;
	}
	
	#qna_list td:nth-child(2n+1) {
		width:30%;
	}
	
	#btn_more {
		width:100%;
		padding:10px;
		font-size:20px;
	}
	
</style>
</head>
<body>
	<%
		if(session.getAttribute("login")==null || !(boolean)session.getAttribute("login")) {
			%>
			<script>
				alert("로그인이 필요합니다");
				location.href="<%=request.getContextPath()%>/index.jsp";
			</script>
			<%
		}
		
		String param = "";
		if(request.getQueryString()!=null) {
			param += "?"+request.getQueryString();
		}
		session.setAttribute("last", request.getRequestURI()+param);
	%>

	<div id="container">
		<jsp:include page="/template/header.jsp" flush="false"></jsp:include>
		
		<nav>
			<div id="qna_list">
				<table>
					<thead>
						<tr>
							<th>제목</th> <th>작성자</th> <th>작성일</th> <th>문의상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${requestScope.list }">
							<tr>
								<td><input type="hidden" value="${dto.qid }">${dto.title }</td>  
								<td>${dto.writer }</td> <td>${dto.qdate }</td>
								<td>	
									<c:choose>
										<c:when test="${dto.status == 0}"> 
											읽지않음
										</c:when>
										<c:when test="${dto.status == 1}">
											읽었음
										</c:when>
										<c:otherwise>
											답변완료
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<button id="btn_more">더보기</button>
			</div> 
		</nav>
		
		<jsp:include page="/template/footer.jsp" flush="false"></jsp:include>
		
	</div>
</body>
</html>