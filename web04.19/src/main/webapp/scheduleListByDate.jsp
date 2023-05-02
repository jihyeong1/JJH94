<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
  
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("y")== null
	||request.getParameter("m")== null
	||request.getParameter("d")== null
	||request.getParameter("y").equals("")
	||request.getParameter("m").equals("")
	||request.getParameter("d").equals("")
		){
		response.sendRedirect("./scheduleList.jsp");
	}
	
	//y,m.d 값이 null 이나 공백 이면 > redirection scheduleList.jsp
	
	int y = Integer.parseInt(request.getParameter("y"));
	// 자바 API 에서는 12월 11 이고, 마리아DB에서는 12월이 12여서 여기에서 +1을 해줘야한다.
	int m = Integer.parseInt(request.getParameter("m")) + 1;
	int d = Integer.parseInt(request.getParameter("d"));
	
	System.out.println(y + "<==scheduleListByDate param y");
	System.out.println(m + "<==scheduleListByDate param m");
	System.out.println(d + "<==scheduleListByDate param d");
	
	String strM = m+"";
	if(m<10){
		strM = "0"+strM;
	}
	String strD = d+"";
	if(d<10){
		strD = "0"+strD;
	}
	String scheduleDate = y+"-"+strM+"-"+strD;
	
	//당일 리스트 만들어보기
	// 디비 연결하기
	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
	java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select * FROM  schedule WHERE schedule_date = ? ORDER BY schedule_time asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, scheduleDate);
	ResultSet rs = stmt.executeQuery();
	System.out.println(stmt + "<==scheduleListByDate param stmt");
	
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs.next()){
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("schedule_no");
		s.scheduleTime = rs.getString("schedule_time");
		s.scheduleMemo = rs.getString("schedule_memo");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		scheduleList.add(s);
	}
	System.out.println(scheduleList.size() + "<==scheduleListByDate size");
	
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		table, th, td{
			border: 1px solid #BDBDBD; 
			background-color: #F6F6F6;
		}
		table{
			border-collapse: collapse;
			width: 1280px;
			height: 400px;
			margin: 0 auto;
		}
		table th{
			background-color: #A6A6A6;
			width: 300px;
			font-weight: bold;
			color: #FFFFFF;
			font-size: 18px;
		}
		a{
			text-decoration: none;
			color: #000000;
		}
		h1{
			text-align: center;
			margin-top: 20px;
		}
		button{
			margin-left: 45%;
			margin-top: 20px;
		}
		.content1{
			width: 700px;
			margin: 0 auto;
		}
		.content1 th{
			width: 30%;
		}
		.content1 input, textarea{
			margin-left: 10px;
		}
		.content2{
			text-align: center;
		}
		.content2 th{
			height: 45px;
		}
	</style>
</head>
<body>
	<h1><img alt="-" src="./img/calendar.png" style="width: 35px;"> 스케줄 입력</h1>
	<form action="./insertScheduleAction.jsp" method="post">
		<div class="content1">
			<table class="content1">
				<tr>
					<th class="title">schedule_Date</th>
					<td><input type="date" value="<%=scheduleDate%>" name="scheduleDate" readonly="readonly"></td>
				</tr>
				<tr>
					<th class="title">schedule_Time</th>
					<td><input type="time" name="scheduleTime"></td>
				</tr>
				<tr>
					<th class="title">schedule_Color</th>
					<td><input type="color" name="scheduleColor" value="#000000"></td>
				</tr>
				<tr>
					<th class="title">schedule_Memo</th>
					<td>
						<textarea rows="10" cols="50" name="scheduleMemo"></textarea>
					</td>
				</tr>
				<tr>
					<th class="title">schedule_pw</th>
					<td>
						<input type="password" name="schedulePw">
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-dark">입력</button>
		</div>
	</form>
	<h1><img alt="-" src="./img/calendar.png" style="width: 35px;"> <%=y%>년 <%=m%>월 <%=d%>일 스케줄 목록</h1>
	<div class="content2">
		<table class="content2">
			<tr>
				<th class="title">schedule_time</th>
				<th class="title">schedule_memo</th>
				<th class="title">createdate</th>
				<th class="title">updatedate</th>
				<th class="title">수정</th>
				<th class="title">삭제</th>
			</tr>
		<%
			for(Schedule s:scheduleList){
		%>
				<tr>
					<td><%=s.scheduleTime%></td>
					<td><%=s.scheduleMemo%></td>
					<td><%=s.createdate%></td>
					<td><%=s.updatedate%></td>
					<td>
						<a class="btn btn-dark" href="./updateScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>">수정</a>
					</td>
					<td>
						<a class="btn btn-dark" href="./deleteScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>&y=<%=y%>&m=<%=m%>&d=<%=d%>">삭제</a>
					</td>
				</tr>	
			<%		
			}
			%>	
		</table>
	</div>
</body>
</html>