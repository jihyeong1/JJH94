<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>    
<%@ page import = "java.sql.PreparedStatement" %> 
<%@ page import = "java.sql.ResultSet" %> 
<%
	//값이 잘 넘어왔는지 디버깅
	System.out.println(request.getParameter("scheduleNo")+ "<==넘어온 scheduleNo"); //출력값은 넘긴값

	//유효성 검사
	if(request.getParameter("scheduleNo")==null){
		response.sendRedirect("./scheduleListByDate.jsp");
		return;
	}
	
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select * from schedule where schedule_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	//schedule_no 값 주기
	stmt.setInt(1,scheduleNo);
	//디버깅
	System.out.println(stmt + "<==stmt 출력");
	ResultSet rs = stmt.executeQuery();
	
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
	h1{
		text-align: center;
		margin-top: 20px;
	}
	button{
		margin-left: 45%;
		margin-top: 20px;
	}
</style>	
</head>
<body>
	<h1>스케줄 수정</h1>
	<div>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
	</div>
	<%
		if(rs.next()){
	%>
	<form action="./updateScheduleAction.jsp" method="post">
		<table class="table-bordered container">
			<tr>
				<td>schedule_No</td>
				<td>
					<input type="hidden" name="scheduleNo" value="<%=rs.getString("schedule_no")%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>schedule_date</td>
				<td>
					<input type="date" name="scheduleDate" value="<%=rs.getString("schedule_date")%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>schedule_time</td>
				<td>
					<input type="time" name="scheduleTime" value="<%=rs.getString("schedule_time")%>">
				</td>
			</tr>
			<tr>
				<td>schedule_memo</td>
				<td>
					<textarea rows="10" cols="50" name="scheduleMemo"><%=rs.getString("schedule_memo")%>
					</textarea>
				</td>
			</tr>
			<tr>
				<td>schedule_color</td>
				<td>
					<input type="color" name="scheduleColor" value="<%=rs.getString("schedule_color")%>">
				</td>
			</tr>
			<tr>
				<td>createdate</td>
				<td><%=rs.getString("createdate") %></td>
			</tr>
			<tr>
				<td>updatedate</td>
				<td><%=rs.getString("updatedate") %></td>
			</tr>
			<tr>
				<td>schedule_pw</td>
				<td><input type="password" name="schedulePw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-dark">수정</button>	
	</form>
	<%		
		}
	%>	
</body>
</html>