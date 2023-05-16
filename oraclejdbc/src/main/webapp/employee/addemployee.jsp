<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %> 
<%@ page import="vo.*" %> 
<%
	//모델 계층
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "HR";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//employeeId Max 값 구하기
	PreparedStatement maxStmt = null;
	ResultSet maxRs = null;
	String maxSql = "select max(employee_id) max from employees";
	maxStmt = conn.prepareStatement(maxSql);
	maxRs = maxStmt.executeQuery();
	int maxCnt = 0;
	if(maxRs.next()){
		maxCnt = maxRs.getInt("max");
	}
	
	//Job 가져오는 쿼리문 작성
	PreparedStatement jobStmt = null;
	ResultSet jobRs = null;
	String jobSql = "select job_id jobId from jobs";
	jobStmt = conn.prepareStatement(jobSql);
	jobRs = jobStmt.executeQuery();
	ArrayList<Employees> jobList = new ArrayList<Employees>();
	while(jobRs.next()){
		Employees j = new Employees();
		j.setJobId(jobRs.getString("jobId"));
		jobList.add(j);
	}
		
	//managerId 가져오는 쿼리문 작성
	PreparedStatement managerStmt = null;
	ResultSet managerRs = null;
	String managerSql = "select distinct manager_id managerId from employees";
	managerStmt = conn.prepareStatement(managerSql);
	managerRs = managerStmt.executeQuery();
	ArrayList<Employees> managerList = new ArrayList<Employees>();
	while(managerRs.next()){
		Employees m = new Employees();
		m.setManagerId(managerRs.getInt("managerId"));
		managerList.add(m);
	}	
		
	//DEPARTMENTS 가져오는 쿼리문 작성
	PreparedStatement departmentStmt = null;
	ResultSet departmentRs = null;
	String departmentSql = "select distinct department_id departmentId from departments";
	departmentStmt = conn.prepareStatement(departmentSql);
	departmentRs = departmentStmt.executeQuery();
	ArrayList<Employees> departmentList = new ArrayList<Employees>();
	while(departmentRs.next()){
		Employees d = new Employees();
		d.setDepartmentId(departmentRs.getInt("departmentId"));
		departmentList.add(d);
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
</head>
<body>
<div class="container">
<div>
	<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
</div>
<div>
	<h1>사원 추가</h1>
	<form action="<%=request.getContextPath()%>/employee/addemployeeAction.jsp" method="post">
		<table>
			<tr>
				<td>employeeId</td>
				<td>
					<input type="text" name="employeeId" value="<%=maxCnt+1 %>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>firstName</td>
				<td>
					<input type="text" name="firstName">
				</td>
			</tr>
			<tr>
				<td>lastName</td>
				<td>
					<input type="text" name="lastName">
				</td>
			</tr>
			<tr>
				<td>email</td>
				<td>
					<input type="text" name="email">
				</td>
			</tr>
			<tr>
				<td>phoneNumber</td>
				<td>
					<input type="text" name="phoneNumber">
				</td>
			</tr>
			<tr>
				<td>hireDate</td>
				<td>
					<input type="date" name="hireDate">
				</td>
			</tr>
			<tr>
				<td>jobId</td>
				<td>
					<select name="jobId">
							<%
								for(Employees j : jobList){
							%>
									<option><%=j.getJobId()%></option>
							<%		
								}
							%>
					</select>
				</td>
			</tr>
			<tr>
				<td>salary</td>
				<td>
					<input type="text" name="salary">
				</td>
			</tr>
			<tr>
				<td>commission_Pct</td>
				<td>
					<input type="text" name="commissionPct">
				</td>
			</tr>
			<tr>
				<td>manager_Id</td>
				<td>
					<select name="managerId">
							<%
								for(Employees m : managerList){
							%>
									<option><%=m.getManagerId()%></option>
							<%		
								}
							%>
					</select>
				</td>
			</tr>
			<tr>
				<td>department_Id</td>
				<td>
					<select name="departmentId">
							<%
								for(Employees d : departmentList){
							%>
									<option><%=d.getDepartmentId() %></option>
							<%		
								}
							%>
					</select>
				</td>
			</tr>
		</table>
		<button type="submit">사원추가</button>
	</form>
</div>
</div>
</body>
</html>