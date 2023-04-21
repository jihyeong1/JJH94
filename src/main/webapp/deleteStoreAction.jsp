<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>    
<%
	//가져온 값이 널값인지 공백인지 검사, 유효성 검사
	if(request.getParameter("storeNo")==null
		|| request.getParameter("storePw")== null
		|| request.getParameter("storeNo").equals("")
		|| request.getParameter("storePw").equals("")){
		response.sendRedirect("./storeList.jsp"); // null 값이거나 공백일 때 해당 주소로 이동
		return;
	}
	
	// no,pw 값 가져오기
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	String storePw = request.getParameter("storePw");
	
	//디버깅 해보기
	System.out.println(storeNo + "<-- 삭제 된 storeNo");
	System.out.println(storePw + "<-- 삭제 된 storePw");
	
	//DB를 연결해보자!
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	
	//테이블에 내가 보낸 데이터가 삭제되는 sql을 전송해보자
	// store_no 와 store_pw 는 ?로 처리
	String sql = "delete from store where store_no=? and store_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, storeNo);
	stmt.setString(2, storePw);
	System.out.println(stmt + "<-- deletestoreAction sql");
	
	//비밀번호가 틀려서 삭제가 안되었을 경우를 만들어보자
	int fail = stmt.executeUpdate();
	
	//디버깅!! 중요해!
	System.out.println(fail + "<-- fail");
	
	if(fail == 0){
		response.sendRedirect("./notDelete.jsp?storeNo="+storeNo);
	} else {
		response.sendRedirect("./delete.jsp");
	}
	
	
%>