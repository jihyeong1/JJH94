<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>  
<%
	//인코딩 하기
	request.setCharacterEncoding("utf-8");

	//유효성 겁사
	String msg = null;
	if(request.getParameter("scheduleDate")==null
		|| request.getParameter("scheduleDate").equals("")){
		msg="scheduleDate is required";
	}else if(request.getParameter("scheduleTime")==null
			|| request.getParameter("scheduleTime").equals("")){
			msg="scheduleTime is required";
	}else if(request.getParameter("scheduleMemo")==null
			|| request.getParameter("scheduleMemo").equals("")){
			msg="scheduleMemo is required";
	}else if(request.getParameter("scheduleColor")==null
			|| request.getParameter("scheduleColor").equals("")){
			msg="scheduleColor is required";
	}else if(request.getParameter("schedulePw")==null
			|| request.getParameter("schedulePw").equals("")){
			msg="schedulePw is required";
	}
	if(msg != null){
		int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
		response.sendRedirect("./updateScheduleForm.jsp?scheduleNo="+scheduleNo+"&msg="+msg);
		return;
	}
	
	//변수 저장
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleMemo = request.getParameter("scheduleMemo");
	String scheduleColor = request.getParameter("scheduleColor");
	String schedulePw = request.getParameter("schedulePw");
	
	//디버깅
	System.out.println(scheduleNo + "<==scheduleNo");
	System.out.println(scheduleDate + "<==scheduleDate");
	System.out.println(scheduleTime + "<==scheduleTime");
	System.out.println(scheduleMemo + "<==scheduleMemo");
	System.out.println(scheduleColor + "<==scheduleColor");
	System.out.println(schedulePw + "<==schedulePw");
	
	//디비연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	//sql문 만들기
	String sql = "update schedule set schedule_time=?, schedule_memo=?, schedule_color=?, updatedate=now() where schedule_no=? and schedule_date=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, scheduleTime);
	stmt.setString(2, scheduleMemo);
	stmt.setString(3, scheduleColor);
	stmt.setInt(4, scheduleNo);
	stmt.setString(5, scheduleDate);
	stmt.setString(6, schedulePw);
	
	//디버깅
	System.out.println(stmt + "<== stmt 확인");
	
	int row = stmt.executeUpdate();
	//확인
	System.out.println(row + "<== row 확인");
	
	int y = Integer.parseInt(request.getParameter("y"));
	// 자바 API 에서는 12월 11 이고, 마리아DB에서는 12월이 12여서 여기에서 +1을 해줘야한다.
	int m = Integer.parseInt(request.getParameter("m")) + 1;
	int d = Integer.parseInt(request.getParameter("d"));
	if(row==0){
		response.sendRedirect("./updateScheduleForm.jsp?noticeNo="+scheduleNo);
	}else{
		response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
		//성공하면 어느페이지로 갈지 설정
	}
%>