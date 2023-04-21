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
</head>
<body>
	<div> <!-- 메인메뉴 -->
		<a href="./form.jsp">홈으로</a>
		<a href="./noticeList.jsp">공지 리스트</a>
		<a href="./diaryList.jsp">일정 리스트</a>
	</div>
	
	<!-- 날짜순 최근 공지 5개 -->
	<%
		//select notice_title,createdate from notice 
		// order by createdate desc
		// limit 0, 5
		
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
		java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		//주소, 호스트명&ip,포트번호,데이터베이스
		// 사용자, 사용자 비밀번호
		PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title,createdate from notice order by createdate desc limit 0, 5");
		// 준비 단계
		// 문자열 모양의 쿼리를 실제 마리아디비 쿼리타입으로 변경해준다.
		System.out.println(stmt + " <--stmt");
		ResultSet rs = stmt.executeQuery();
	%>
	<table>
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
</body>
</html>