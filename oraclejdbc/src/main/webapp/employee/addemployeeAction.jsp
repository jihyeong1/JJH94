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
	  
	  String addSql = "INSERT INTO employees values(?,?,?,?,?,?,?,?,?,?,?)";
	   PreparedStatement addStmt = conn.prepareStatement(addSql);
	   addStmt.setInt(1,employeeId);
	   addStmt.setString(2,firstName);
	   addStmt.setString(3,lastName);
	   addStmt.setString(4,email);
	   addStmt.setString(5,phoneNumber);
	   addStmt.setString(6,hireDate);
	   addStmt.setString(7,jobId);
	   addStmt.setDouble(8,salary);
	   addStmt.setDouble(9,commissionPct);
	   addStmt.setInt(10,managerId);
	   addStmt.setInt(11,departmentId);
	   
	   int row = addStmt.executeUpdate();
	   
	   if(row==1){
	      String msg = URLEncoder.encode("데이터가 성공적으로 추가 되었습니다","utf-8");
	      response.sendRedirect(request.getContextPath()+"/home.jsp?msg="+msg);
	      System.out.println("변경성공 row값-->"+row);
	   }else{
	      //row값이 1이 아닐경우 메시지와 함게 이전페이지로 반환
	      String msg = URLEncoder.encode("데이터 추가에 실패하였습니다","utf-8");
	      response.sendRedirect(request.getContextPath()+"/employee/employeeList.jsp?msg="+msg);
	      System.out.println("변경실패 row값-->"+row);
	      return;
	   }

%>    
