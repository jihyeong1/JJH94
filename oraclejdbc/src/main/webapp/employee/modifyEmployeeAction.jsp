<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %> 
<%
	//유효성 검사
	if(request.getParameter("employeeId")==null
      ||request.getParameter("lastName")==null
      ||request.getParameter("email")==null
      ||request.getParameter("hireDate")==null
      ||request.getParameter("jobId")==null
      ||request.getParameter("employeeId").equals("")
      ||request.getParameter("lastName").equals("")
      ||request.getParameter("email").equals("")
      ||request.getParameter("hireDate").equals("")
      ||request.getParameter("jobId").equals("")){    
      response.sendRedirect(request.getContextPath()+"/employee/modifyEmployee.jsp");
      System.out.println("addnull이나 공백있음");
      return;    
   }
	//변수 저장
	int employeeId = Integer.parseInt(request.getParameter("employeeId"));
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String hireDate = request.getParameter("hireDate");
    String jobId = request.getParameter("jobId");
    double salary = Double.parseDouble(request.getParameter("salary"));
    double commissionPct = Double.parseDouble(request.getParameter("commissionPct"));
    int managerId = Integer.parseInt(request.getParameter("managerId"));
    int departmentId = Integer.parseInt(request.getParameter("departmentId"));
    
    //디버깅
    System.out.println(employeeId +"<--employeeId");
    System.out.println(firstName +"<--firstName");
    System.out.println(lastName +"<--lastName");
    System.out.println(email +"<--email");
    System.out.println(phoneNumber +"<--phoneNumber");
    System.out.println(hireDate +"<--hireDate");
    System.out.println(jobId +"<--jobId");
    System.out.println(salary +"<--salary");
    System.out.println(hireDate +"<--commissionPct");
    System.out.println(jobId +"<--managerId");
    System.out.println(salary +"<--departmentId");

	//모델 계층
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "HR";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//insert 쿼리문 작성
	PreparedStatement modifyStmt = null;
	String modifySql = "UPDATE employees SET FIRST_NAME=?, LAST_NAME=?, EMAIL=?, PHONE_NUMBER=?, SALARY=?, COMMISSION_PCT=?, MANAGER_ID=? WHERE EMPLOYEE_ID=?";
	modifyStmt = conn.prepareStatement(modifySql);
	modifyStmt.setString(1,firstName);
	modifyStmt.setString(2,lastName);
	modifyStmt.setString(3,email);
	modifyStmt.setString(4,phoneNumber);
	modifyStmt.setDouble(5,salary);
	modifyStmt.setDouble(6,commissionPct);
	modifyStmt.setInt(7,managerId);
	modifyStmt.setInt(8,employeeId);
	
	int row = modifyStmt.executeUpdate();
	
	String msg = "";
	if(row==1){
		System.out.println("수정 성공");
	}else{
		System.out.println("수정 실패");
		return;
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/home.jsp");
%>    