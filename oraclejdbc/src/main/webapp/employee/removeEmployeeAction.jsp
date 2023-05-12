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
	
	//디비연결
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbUser = "HR";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//탈퇴 쿼리 작성
	PreparedStatement removeStmt = null;
	String removeSql = "DELETE from employees where employee_id=? and FIRST_NAME=? and LAST_NAME=?";
	removeStmt = conn.prepareStatement(removeSql);
	removeStmt.setInt(1,sessionEmployees.getEmployeeId());
	removeStmt.setString(2,sessionEmployees.getFirstName());
	removeStmt.setString(3,sessionEmployees.getLastName());
	
	
	System.out.println(removeStmt + "<--removeStmt");
	
	int row = removeStmt.executeUpdate();
	
	if(row==1){
		System.out.println("탈퇴성공");
	}else{
		System.out.println("탈퇴실패");
		return;
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/home.jsp");
%>
