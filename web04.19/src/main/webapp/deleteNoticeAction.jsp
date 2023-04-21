<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	//요청값 유효성 검사
	if(request.getParameter("noticeNo") == null
		|| request.getParameter("noticePw") == null
		|| request.getParameter("noticeNo").equals("")
		|| request.getParameter("noticePw").equals("")) {
		response.sendRedirect("./noticeList.jsp"); // 다시 가야할 주소를 보내주는것
		return;} // 1)지금진행하는 실행코드를 종료할 때  2) 반환값을 남길때


	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
		
	// 디버깅 생략함 해야됨.
	System.out.println(noticeNo + "<-- deleteNoticeAction param noticeNo");
	System.out.println(noticePw + "<-- deleteNoticeAction param noticePw");
	
	
	// delete from notcie where notice_no=? and notice_pw=?				
	// 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	// noitce 테이블에 데이터를 삭제하는 sql 전송
	 String sql = "delete from notice where notice_no=? and notice_pw=?";
	 PreparedStatement stmt = conn.prepareStatement(sql);
	 stmt.setInt(1, noticeNo);
	 stmt.setString(2, noticePw);
	 System.out.println(stmt + "<-- deleteNoticeAction sql");
	   
	   

	int row = stmt.executeUpdate();
	
	// 디버깅
	System.out.println(row + "<-- deleteNoticeAction row");
	
	if(row == 0) { // 비밀번호 틀려서 삭제가 안되었을 경우
		response.sendRedirect("./deleteNoticeForm.jsp?noticeNo="+noticeNo);
	} else {
		response.sendRedirect("./noticeList.jsp");
	}
%>