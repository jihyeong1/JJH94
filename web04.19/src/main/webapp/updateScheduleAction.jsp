<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	//인코딩 하기
	request.setCharacterEncoding("utf-8");

	//유효성 겁사
	//만약 값이 공백이거나 널값이면 updateScheduleForm에 메세지가 나오게끔 설정
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
	
	String y = scheduleDate.substring(0,4);	
	// 자바 qpi로 넘어가기 위해서는 앞전에 +1을 해주었기 때문에 돌아갈때는 -1을 해줘야한다.
	// m의 경우 -1을 해줘야하는데 문자로 되면 안되기에 integer을 사용해 숫자로 변환해주어야한다.
	int m = Integer.parseInt(scheduleDate.substring(5,7))-1;
	String d = scheduleDate.substring(8);
	 //디버깅
	 System.out.println(y + "<== y 값");
	 System.out.println(m + "<== m 값");
	 System.out.println(d + "<== d 값");
	
	if(row==0){
		response.sendRedirect("./updateScheduleForm.jsp?noticeNo="+scheduleNo);
	}else{
		response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
		//성공하면 어느페이지로 갈지 설정
	}
%>