<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(function () {
		$("#btn").click(function () {
			var data = $("#frm").serialize();
			$.ajax({
				url: "ServerAjax.jsp",
				data : data,
				type:'get',
				success : function result(data) {
					var result = "";
					var arr = data.split(",");
					for(i=0;i<arr.length;i++) {
						var str = arr[i].split(" ");
						result += "<p>";
						for(j=0;j<str.length;j++) {
							result += "<span>" + str[j] + "<span> ";
						}
						result += "</p>";
					}
					$("#result").html(result);
				}
			});
		});
		$("input").keyup(function() {
			$("#btn").click();
		});
	});
		
</script>
</head>
<body>
	<form id="frm">
		<input type="text" name="name">
		<button type="button" id="btn">제출</button>
	</form>
	
	<div id="result">
		
	</div>
</body>
</html>