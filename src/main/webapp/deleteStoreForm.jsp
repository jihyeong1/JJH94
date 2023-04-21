<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청값이 널인지 공백인지 확인하는 검사
	if(request.getParameter("storeNo")==null){
		response.sendRedirect("./storeList.jsp"); //다시 storeList 로 보낸다는 것
		return;
	}

	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	System.out.println(storeNo	+ "<-- deletStoreForm param storeNo가 잘 넘어왔나?");
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		h1, table{
			text-align: center;
		}
	</style>
</head>
<body class="container-fluid">
	<h1>공지 삭제</h1>
	<form action="./deleteStoreAction.jsp" method="post">
		<table class="table table-striped">
			<tr>
				<td>가게 번호</td>
				<td>
					<input type="text" name="storeNo" value="<%=storeNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>가게 비밀번호</td>
				<td>
					<input type="password" name="storePw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">삭제</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>