<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>    
<%
	//인코딩 처리
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(
		request.getParameter("scheduleTime")== null
		||request.getParameter("scheduleColor")== null
		||request.getParameter("scheduleMemo")== null
		||request.getParameter("schedulePw")== null
		||request.getParameter("scheduleTime").equals("")
		||request.getParameter("scheduleColor").equals("")
		||request.getParameter("scheduleMemo").equals("")
		||request.getParameter("schedulePw").equals("")
			){
			response.sendRedirect("./scheduleList.jsp");
			return;
	}

	//변수에 값을 저장해준다
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleColor = request.getParameter("scheduleColor");
	String scheduleMemo = request.getParameter("scheduleMemo");
	String schedulePw = request.getParameter("schedulePw");
	
	//디버깅
	System.out.println(scheduleDate + "<== insertScheduleAction parm scheduleDate");
	System.out.println(scheduleTime + "<== insertScheduleAction parm scheduleTime");
	System.out.println(scheduleColor + "<== insertScheduleAction parm scheduleColor");
	System.out.println(scheduleMemo + "<== insertScheduleAction parm scheduleMemo");
	System.out.println(schedulePw + "<== insertScheduleAction parm schedulePw");

	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "insert into schedule(schedule_date, schedule_time, schedule_color, schedule_memo, schedule_pw, createdate, updatedate) values(?,?,?,?,?,now(),now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, scheduleDate);
	stmt.setString(2, scheduleTime);
	stmt.setString(3, scheduleColor);
	stmt.setString(4, scheduleMemo);
	stmt.setString(5, schedulePw);
	
	int row = stmt.executeUpdate();
	if(row==1){
		System.out.println("정상 입력");
	} else{
		System.out.println("잘못 입력");
	}
	//디버깅
	System.out.println(row +"<==row 값");
	
	//값 다시 돌려보내기!
	
	//scheduleListByDate로 돌아갈때 y,m,d의 값이 필요하다.
	//따라서 해당 페이지에서 y,m,d 의 값을 만들어준 뒤 해당 페이지로 보내야하며,y,m,d의 값에 알맞게 데이터를 짤라주어야한다.
	String y = scheduleDate.substring(0,4);	
	// 자바 qpi로 넘어가기 위해서는 앞전에 +1을 해주었기 때문에 돌아갈때는 -1을 해줘야한다.
	// m의 경우 -1을 해줘야하는데 문자로 되면 안되기에 integer을 사용해 숫자로 변환해주어야한다.
	int m = Integer.parseInt(scheduleDate.substring(5,7))-1;
	String d = scheduleDate.substring(8);
	
	//값이 잘 바뀌었는지 확인
	System.out.println(y + "<== insertScheduleAction parm y");
	System.out.println(m + "<== insertScheduleAction parm m");
	System.out.println(d + "<== insertScheduleAction parm d");
	
	response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
	
%>