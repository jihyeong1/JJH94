<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
		//select notice_title,createdate from notice 
		// order by createdate desc
		// limit 0, 5
		
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
		java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		//주소, 호스트명&ip,포트번호,데이터베이스
		// 사용자, 사용자 비밀번호
		
		// 쿼리문 옆에 별명을 붙여주면 밑에서도 계속 그 별명으로↓ 사용가능 하다
		String sql1 = "select notice_no noticeNo, notice_title noticeTitle, createdate from notice order by createdate desc limit 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql1);
		// 준비 단계
		// 문자열 모양의 쿼리를 실제 마리아디비 쿼리타입으로 변경해준다.
		System.out.println(stmt + " <--stmt");
		ResultSet rs = stmt.executeQuery();
		
		//공지사항 ArrayList 만들기
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		 while(rs.next()){
			 Notice n = new Notice();
			 n.noticeNo = rs.getInt("noticeNo"); //별명으로 가져온다.
			 n.noticeTitle = rs.getString("noticeTitle");
			 n.createdate = rs.getString("createdate");
			 noticeList.add(n); //리스트를 add를 해야 출력문에서 사용이 가능하다.
		 }
		
		// 오늘 일정
		/*select schedule_no, schedule_date, schedule_time, substr(schedule_memo,1,10)memo //디비에서 글자 수 잘라서 가져올때 쓴다 (substr)
			FROM schedule 
			WHERE schedule_date = CURDATE() //현재 날짜를 정할때 쓰는것
			ORDER BY schedule_time ASC;*/
		String sql2 = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, substr(schedule_memo,1,10)scheduleMemo FROM schedule WHERE schedule_date = CURDATE() ORDER BY schedule_time ASC";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		
		//일정리스트 ArrayList
		ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	    	while(rs.next()){
	    		Schedule s = new Schedule();
			 	s.scheduleNo = rs.getInt("scheduleNo");
				s.scheduleDate = rs.getString("scheduleDate");
				s.scheduleTime = rs.getString("scheduleTime");
				s.scheduleMemo = rs.getString("scheduleMemo");
				scheduleList.add(s);	 
				 }
	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
	
		header{
			width: 1280px;
			height: 60px;
			margin: 0 auto;
			padding: 10px;
		}
		a{
			text-decoration: none;
			color: #000000;
		}
		.nav{
			width: 100%;
			display: flex;
			justify-content: space-between;
			align-items: center;
			border-bottom: 2px solid #BDBDBD;
		}
		.nav div h2{
			margin-left: 30px;
			font-size: 40px;
			line-height: 3px;
		}
		li{
			list-style: none;
			float: left;
			padding: 0px 40px 20px 20px;
			font-size: 20px;
		}
		.content{
			width: 1280px;
			height: 600px;
			background-color: #F6F6F6;
			margin: 0 auto;
			display: flex;
			text-align: center;
			margin-top: 50px;
		}
		.left{
			border-right: 1px dashed #D5D5D5;
			padding-right: 20px;
		}
		.left , .right{
			width: 50%;
			margin-top: 30px;
		}
		.left table, h1{
			width: 90%;
			margin: 0 auto;
			padding-bottom: 40px;
		}
		.left th, td{
			line-height: 3;
		}
		.right th, td{
			line-height: 3;
		}
		
		.right table, h1{
			width: 90%;
			margin: 0 auto;
		}
	</style>
</head>
<body>
	<header>
		<div class="nav"> <!-- 메인메뉴 -->
			<div>		
				<h2><img alt="-" src="./img/calendar.png" style="width: 35px;"> Calendar</h2>
			</div>
			<div>
				<ul>
					<li>
						<a href="./form.jsp">Home</a>
					</li>
					<li>
						<a href="./noticeList.jsp">공지 리스트</a>
					</li>
					<li>
						<a href="./scheduleList.jsp">일정 리스트</a>
					</li>
				</ul>
			</div>
		</div>
	</header>	
	
	<div class="content">	
		<!-- 날짜순 최근 공지 5개 & 오늘 일정(모두) -->
		<div class="left">
		<table>
			<h1>공지사항</h1>
				<tr>
					<th>notice_title</th>
					<th>createdate</th>
				</tr>
			<%
				for(Notice n : noticeList){
			%>
				<tr>
					<td>
						<a href="./noticeOne.jsp?noticeNo=<%=n.noticeNo%>">
							<%=n.noticeTitle%>
						</a>
					</td>
					<td><%=n.createdate.substring(0, 10)%></td>
					<!-- substring은 몇줄을 가져올건지 정하는 것 -->
				</tr>		
			<%		
				}
			%>
		</table>
		</div>
		
		<div class="right">
		<h1>오늘일정</h1>
		<table>
				<tr>
					<th>schedule_date</th>
					<th>schedule_time</th>
					<th>schedule_memo</th>
				</tr>
			<%
				for(Schedule s : scheduleList){
			%>
				<tr>
					<td>
						<a href="./scheduleOne.jsp?scheduleNo=<%=s.scheduleNo%>">
							<%=s.scheduleDate%>
						</a>
					</td>
					<td><%=s.scheduleTime%></td>
					<td><%=s.scheduleMemo%></td>
				</tr>		
			<%		
				}
			%>
		</table>
	</div>
	</div>
</body>
</html>