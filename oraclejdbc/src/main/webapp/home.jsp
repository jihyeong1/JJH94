<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.ldap.PagedResultsControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="vo.*" %> 
<%
	//세션에서 가져올 때
	Object o = session.getAttribute("loginEmployee");
	Employees sessionEmployees = null;
	
	if(o instanceof Employees){ //instanceof 연산자는
		sessionEmployees = (Employees)o;
	}
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
	h2{
		text-align: center;
		margin: 50px;
	}
</style>
</head>
<body>
<!-- employe_id, first_name, last_name 컬럼을 이용하여 로그인 -->
<h2>직원 리스트 데이터베이스</h2>
<%
	if(request.getParameter("msg") != null){
%>
		<%=request.getParameter("msg") %>
<%		
	}
%>
<%
	if(sessionEmployees == null){
%>
<div class="container">
	<form action="<%=request.getContextPath()%>/employee/loginAction.jsp" method="post">
		<table class="input-group" style="margin-left: 50px;">
			<tr>
				<td>employeeId</td>
				<td>
					<input type="text" name="employeeId" class="form-control">
				</td>
			</tr>
			<tr>
				<td>firstName</td>
				<td>
					<input type="password" name="firstName" class="form-control" style="margin-top: 10px;">	
				</td>
			</tr>
			<tr>
				<td>lastName</td>
				<td>
					<input type="password" name="lastName" class="form-control" style="margin-top: 10px;">	
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-dark btn-sm">로그인</button>
	</form>
<%		
	}else{
%>
		<table class="table table-dark" style="text-align: center;">
			<tr>
				<td>
					<%=sessionEmployees.getEmployeeId()%>
					<%=sessionEmployees.getFirstName()%>
					<%=sessionEmployees.getLastName()%>님이 접속중입니다.
				</td>
			</tr>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/employee/logoutAction.jsp">로그아웃</a>
					<a href="<%=request.getContextPath()%>/employee/employeeList.jsp">직원 리스트</a>
				</td>
			</tr>
		</table>
<%		
	}
%>	
</div>
</body>
</html>