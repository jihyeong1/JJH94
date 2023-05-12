<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>    
<%
	//세션에서 가져올 때
	Object o = session.getAttribute("loginEmployee");
	Employees sessionEmployees = null;
	
	if(o instanceof Employees){ //instanceof 연산자는
		sessionEmployees = (Employees)o;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	/*
		-- rowPerPage 가 10일 때
		currentPage  beginRow	endRow
 			1		  	1		  10
 			2           11        20
 			3           21        30
	*/
	int beginRow = (currentPage-1)*rowPerPage+1;
	int endRow = beginRow + (rowPerPage - 1);
	
	//모델 계층
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "HR";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	int totalCnt = 0;
	PreparedStatement totalCntStmt = null;
	ResultSet totalCntRs = null;
	String totalCntSql="SELECT COUNT(*) FROM employees";
	totalCntStmt = conn.prepareStatement(totalCntSql);
	totalCntRs = totalCntStmt.executeQuery();
	if(totalCntRs.next()){
		totalCnt = totalCntRs.getInt("COUNT(*)");
		//셀렉트 반환 컬럼이 하나일때는 COUNT자리에 1로 적어서 사용해주기도한다.
		//다만 컬럼이 2개이상일때는 직계함수 COUNT 를 써주는게 좋다.
	}	
	
	if(endRow > totalCnt){
		endRow = totalCnt;
	}
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	// 2) 페이지 리스트
	/* select e3.*
	from 
	(select rownum rnum, e2.*
	from 
	(select el.*
	from employees el
	order by el.hire_date desc) e2) e3
	where e3.rnum between 11 and 20; */
	String employeeListSql="select e3.* from (select rownum rnum, e2.* from (select el.EMPLOYEE_ID employeeId, FIRST_NAME firstName, LAST_NAME lastName, EMAIL email, PHONE_NUMBER phoneNumber, HIRE_DATE hireDate, JOB_ID jobId, SALARY salary, COMMISSION_PCT commissionPct, MANAGER_ID managerId, DEPARTMENT_ID departmentId from employees el order by el.hire_date desc) e2) e3 where e3.rnum between ? and ?";
	PreparedStatement employeeListStmt = conn.prepareStatement(employeeListSql);
	employeeListStmt.setInt(1, beginRow);
	employeeListStmt.setInt(2, endRow);
	ResultSet employeeListRs = employeeListStmt.executeQuery();
	
	//employees 리스트 만들기
	ArrayList<Employees> employees = new ArrayList<Employees>();
	while(employeeListRs.next()){
		Employees e = new Employees();
		e.setEmployeeId(employeeListRs.getInt("employeeId"));
		e.setFirstName(employeeListRs.getString("firstName"));
		e.setLastName(employeeListRs.getString("lastName"));
		e.setEmail(employeeListRs.getString("email"));
		e.setPhoneNumber(employeeListRs.getString("phoneNumber"));
		e.setHireDate(employeeListRs.getString("hireDate"));
		e.setJobId(employeeListRs.getString("jobId"));
		e.setSalary(employeeListRs.getDouble("salary"));
		e.setCommissionPct(employeeListRs.getDouble("commissionPct"));
		e.setManagerId(employeeListRs.getInt("managerId"));
		e.setDepartmentId(employeeListRs.getInt("departmentId"));
		employees.add(e);
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
<!-- employe_id, first_name, last_name 컬럼을 이용하여 로그인 -->
<div class="container">
<div>
	<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
</div>
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg") %>
	<%		
		}
	%>
	<div>
		<table class="table table-hover" style="margin-top: 20px; text-align: center;">
			<tr>
				<th>employeeId</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>email</th>
				<th>phoneNumber</th>
				<th>hireDate</th>
				<th>jobId</th>
				<th>salary</th>
				<th>commissionPct</th>
				<th>managerId</th>
				<th>departmentId</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Employees e : employees){
			%>
					<tr>
						<td><%=e.getEmployeeId() %></td>
						<td><%=e.getFirstName() %></td>
						<td><%=e.getLastName()%></td>
						<td><%=e.getEmail() %></td>
						<td><%=e.getPhoneNumber() %></td>
						<td><%=e.getHireDate()%></td>
						<td><%=e.getJobId()%></td>
						<td><%=e.getSalary() %></td>
						<td><%=e.getCommissionPct() %></td>
						<td><%=e.getManagerId() %></td>
						<td><%=e.getDepartmentId() %></td>
						<%
							//자기자신만 수정,삭제 보일 수 있게 설정
							if(sessionEmployees.getEmployeeId() == e.getEmployeeId()
								&& sessionEmployees.getFirstName().equals(e.getFirstName())
								&& sessionEmployees.getLastName().equals(e.getLastName())){
						%>
								<td>
									<a href="<%=request.getContextPath()%>/employee/modifyEmployee.jsp">수정</a>
								</td>
								<td>
									<a href="<%=request.getContextPath()%>/employee/removeEmployeeAction.jsp">삭제</a>
								</td>
						<%		
							}
						%>

					</tr>
			<%		
				}
			%>
		</table>	
	</div>
	<div>
		<%
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-dark" style="margin-bottom: 10px; float: left;" href="<%=request.getContextPath()%>/employee/employeeList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
		<%		
			}
		%>
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-dark" style="margin-bottom: 10px; float: right;" href="<%=request.getContextPath()%>/employee/employeeList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
		<%		
			}
		%>
	</div>
</body>
</html>