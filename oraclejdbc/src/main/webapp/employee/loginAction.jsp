<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %> 
<%@ page import="java.net.*" %>     
<%@ page import="vo.*" %> 
<%
	//세션 유효성 검사
	String msg = "";
	if(request.getParameter("employeeId") == null
		||request.getParameter("employeeId").equals("")){
		msg = URLEncoder.encode("employeeId 를 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
		return;
	}
	if(request.getParameter("firstName") == null
		||request.getParameter("firstName").equals("")){
		msg = URLEncoder.encode("firstName 를 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
		return;
	}
	if(request.getParameter("lastName") == null
		||request.getParameter("lastName").equals("")){
		msg = URLEncoder.encode("lastName 를 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
		return;
		}
	
	//요청값 변수 저장
	int employeeId = Integer.parseInt(request.getParameter("employeeId"));
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	//디버깅
	System.out.println(employeeId + "<--employeeId");
	System.out.println(firstName + "<--firstName");
	System.out.println(lastName + "<--lastName");
	
	//디비연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "HR";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//employeeId, firstName, lastName 을 찾는 쿼리문 작성
	PreparedStatement loginActionStmt = null;
	ResultSet loginActionRs = null;
	String loginActionSql = "SELECT  EMPLOYEE_ID employeeId, FIRST_NAME firstName, LAST_NAME lastName, EMAIL email, PHONE_NUMBER phoneNumber, HIRE_DATE hireDate, JOB_ID jobId, SALARY salary, COMMISSION_PCT commissionPct, MANAGER_ID managerId, DEPARTMENT_ID departmentId from EMPLOYEES WHERE EMPLOYEE_ID=? and FIRST_NAME=? and LAST_NAME=?";
	loginActionStmt = conn.prepareStatement(loginActionSql);
	loginActionStmt.setInt(1, employeeId);
	loginActionStmt.setString(2, firstName);
	loginActionStmt.setString(3, lastName);
	loginActionRs = loginActionStmt.executeQuery();
	
	//세션에 저장할 객체 생성
	Employees loginEmployee = null;
	if(loginActionRs.next()){
		loginEmployee = new Employees();
		loginEmployee.setEmployeeId(loginActionRs.getInt("employeeId"));
		loginEmployee.setFirstName(loginActionRs.getString("firstName"));
		loginEmployee.setLastName(loginActionRs.getString("lastName"));
		loginEmployee.setEmail(loginActionRs.getString("email"));
		loginEmployee.setPhoneNumber(loginActionRs.getString("phoneNumber"));
		loginEmployee.setHireDate(loginActionRs.getString("hireDate"));
		loginEmployee.setJobId(loginActionRs.getString("jobId"));
		loginEmployee.setSalary(loginActionRs.getDouble("salary"));
		loginEmployee.setCommissionPct(loginActionRs.getDouble("commissionPct"));
		loginEmployee.setManagerId(loginActionRs.getInt("managerId"));
		loginEmployee.setDepartmentId(loginActionRs.getInt("departmentId"));
	}else{
		msg = URLEncoder.encode("직원정보가 존재하지않습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
		return;
	}
		
		
	//세션에 추가할 때
	
	session.setAttribute("loginEmployee", loginEmployee);
	
	response.sendRedirect(request.getContextPath()+"/employee/employeeList.jsp");
	
%>    