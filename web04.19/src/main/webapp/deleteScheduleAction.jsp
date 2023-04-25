<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	//만약 scheduleNo가 null이거나 공백일때 나오는 에러 메세지
	String msg1 = null;
	if(request.getParameter("scheduleNo")==null
		||request.getParameter("scheduleNo").equals("")){
		msg1 = "The No is wrong.";
	//만약 schedulePw가 null이거나 공백일때 나오는 에러 메세지
	}else if(request.getParameter("schedulePw")==null
			||request.getParameter("schedulePw").equals("")){
		msg1 = "The password is wrong.";
	}
	if(msg1 != null){
		int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
		response.sendRedirect("./deleteScheduleForm.jsp.jsp?scheduleNo="+scheduleNo+"&msg1="+msg1);
		return;
	}
	
	//값 불러오기
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	
	//디버깅
	System.out.println(scheduleNo + "<-- deletescheduleAction param noticeNo");
	System.out.println(schedulePw + "<-- deletescheduleAction param noticePw");
	
	//디비연결
	Class.forName("org.mariadb.jdbc.Driver");	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	// schedule 테이블에 데이터를 삭제하는 sql 전송
	/*
		delete from schedule where schedule_no=? and schedule_pw=?
	*/
	String sql = "delete from schedule where schedule_no=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, scheduleNo);
	stmt.setString(2, schedulePw);
	System.out.println(stmt + "<-- stmt");
		
	
	int row = stmt.executeUpdate();
	
	System.out.println(row + "<== row 값");
	
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"))-1;
	int d = Integer.parseInt(request.getParameter("d"));
	
	if(row==0){
		response.sendRedirect("./deleteScheduleForm.jsp?scheduleNo="+scheduleNo);
	}else{
		response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
	}
	
%>