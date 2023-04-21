<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		h1{
			text-align: center;
			margin-bottom: 30px;
		}
		a {
			margin: 40%;
			text-decoration: none;
			background-color: #FFD9EC;
			padding: 15px;
			color: #000000;
		}
	</style>
</head>
<body>
	<h1>비밀번호를 다시 입력해주세요.</h1>
	<a href="./deleteStoreForm.jsp?storeNo=<%=storeNo%>">이전으로</a>
</body>
</html>