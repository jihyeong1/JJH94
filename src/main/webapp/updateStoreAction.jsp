<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
	//유효성 검사
	if(
		request.getParameter("storeName")==null	
		||request.getParameter("storePw")==null
		||request.getParameter("storeAddress")==null
		||request.getParameter("storeEmpCnt")==null
		||request.getParameter("storeName").equals("")
		||request.getParameter("storePw").equals("")
		||request.getParameter("storeAddress").equals("")
		||request.getParameter("storeEmpCnt").equals("")
		){
			// storeNo의 값을 불러와서 변수에 저장		
			int storeNo = Integer.parseInt(request.getParameter("storeNo"));
			// 널값이거나 공백일때 해당 페이지로 이동
			response.sendRedirect("./updateStoreForm.jsp?storeNo="+storeNo);
			return; //종료
	}

	// 값을 변수에 저장
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	String storeName = request.getParameter("storeName");
	String storePw = request.getParameter("storePw");
	String storeAddress = request.getParameter("storeAddress");
	int storeEmpCnt = Integer.parseInt(request.getParameter("storeEmpCnt"));
	
	//디버깅
	System.out.println(storeNo + "<<--storeNo");
	System.out.println(storeName + "<<--storeName");
	System.out.println(storeAddress + "<<--storeAddress");
	System.out.println(storeEmpCnt + "<<--storeEmpCnt");
	
	//디비 연결하기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	String sql = "update store set store_name=?, store_address=?, store_emp_cnt=?, updatedate=now() where store_no=? and store_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1,storeName);
	stmt.setString(2,storeAddress);
	stmt.setInt(3,storeEmpCnt);
	stmt.setInt(4,storeNo);
	stmt.setString(5,storePw);
	
	//디버깅
	System.out.println(stmt + "<== stmt 가 잘되었는가?");
	
	//성공했는지 알아보기
	int row = stmt.executeUpdate();
	
	//디버깅
	System.out.println(row + "<== row 확인");
	
	//실패했거나 성공했을때 이동하는 페이지 만들기
	if(row==0){
		response.sendRedirect("./updateStoreForm.jsp?storeNo="+storeNo);
	}else{
		response.sendRedirect("./storeList.jsp?storeNo="+storeNo);
		//성공했을 때
	}
	
	
%>