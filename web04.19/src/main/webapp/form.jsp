<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>    
<%@ page import = "java.sql.PreparedStatement" %> 
<%@ page import = "java.sql.ResultSet" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		a{
			text-decoration: none;
			color: #000000;
		}
	</style>
</head>
<body>
	<div> <!-- 메인메뉴 -->
		<a href="./form.jsp">홈으로</a>
		<a href="./noticeList.jsp">공지 리스트</a>
		<a href="./scheduleList.jsp">일정 리스트</a>
	</div>
	
	<!-- 날짜순 최근 공지 5개 & 오늘 일정(모두) -->
	<%
		//select notice_title,createdate from notice 
		// order by createdate desc
		// limit 0, 5
		
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
		java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		//주소, 호스트명&ip,포트번호,데이터베이스
		// 사용자, 사용자 비밀번호
		String sql1 = "select notice_no, notice_title,createdate from notice order by createdate desc limit 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql1);
		// 준비 단계
		// 문자열 모양의 쿼리를 실제 마리아디비 쿼리타입으로 변경해준다.
		System.out.println(stmt + " <--stmt");
		ResultSet rs = stmt.executeQuery();
		
		// 오늘 일정
		/*select schedule_no, schedule_date, schedule_time, substr(schedule_memo,1,10)memo //디비에서 글자 수 잘라서 가져올때 쓴다 (substr)
			FROM schedule 
			WHERE schedule_date = CURDATE() //현재 날짜를 정할때 쓰는것
			ORDER BY schedule_time ASC;*/
		String sql2 = "select schedule_no, schedule_date, schedule_time, substr(schedule_memo,1,10)memo FROM schedule WHERE schedule_date = CURDATE() ORDER BY schedule_time ASC";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
	%>
	<table class="table table-striped">
		<h1>공지사항</h1>
			<tr>
				<th>notice_title</th>
				<th>createdate</th>
			</tr>
		<%
			while(rs.next()){
		%>
			<tr>
				<td>
					<a href="./noticeOne.jsp?noticeNo=<%=rs.getInt("notice_no")%>">
						<%=rs.getString("notice_title")%>
					</a>
				</td>
				<td><%=rs.getString("createdate").substring(0, 10)%></td>
				<!-- substring은 몇줄을 가져올건지 정하는 것 -->
			</tr>		
		<%		
			}
		%>
	</table>
	
	<h1>오늘일정</h1>
	<table class="table table-striped">
			<tr>
				<th>schedule_date</th>
				<th>schedule_time</th>
				<th>schedule_memo</th>
			</tr>
		<%
			while(rs2.next()){
		%>
			<tr>
				<td>
					<a href="./scheduleOne.jsp?scheduleNo=<%=rs2.getInt("schedule_no")%>">
						<%=rs2.getString("schedule_date")%>
					</a>
				</td>
				<td><%=rs2.getString("schedule_time")%></td>
				<td><%=rs2.getString("memo")%></td>
			</tr>		
		<%		
			}
		%>
	</table>
</body>
</html>