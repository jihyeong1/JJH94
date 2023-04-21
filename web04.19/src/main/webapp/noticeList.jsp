<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>    
<%@ page import = "java.sql.PreparedStatement" %> 
<%@ page import = "java.sql.ResultSet" %> 

<%
	// 요청 분석(currentPage,.....)
	// 현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<--currentPage");	
	
	// 페이지당 출력할 행의 수
	int rowPerPage = 10;
	
	// 시작 행번호
	int startRow = (currentPage - 1) * rowPerPage; // 페이지 넘기기 , 1페이지 일때만 startRow 가 0
		/*
			currentPage   startRow(rowPerPage 10일 때)
			1    			0    <--= (currentPage - 1) * rowPerPage
			2				10
			3				20
			4				30
		*/
		
	// DB연결 설정
		//select notice_title,createdate from notice 
		// order by createdate desc
		// limit ?, ?
		
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
		java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		//주소, 호스트명&ip,포트번호,데이터베이스
		// 사용자, 사용자 비밀번호
		PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title,createdate from notice order by createdate desc limit ?, ?");
		
		
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerPage);
		// 준비 단계
		// 문자열 모양의 쿼리를 실제 마리아디비 쿼리타입으로 변경해준다.
		System.out.println(stmt + " <--stmt");
		
		//출력할 공지 데이터
		ResultSet rs = stmt.executeQuery();
		
		// 마지막 페이지
		// select count(*) from notice
		PreparedStatement stmt2 = conn.prepareStatement("select count(*) from notice");
		ResultSet rs2 = stmt2.executeQuery();
		int totalRow = 0; // select count(*) from notice;
		if(rs2.next()){
			totalRow = rs2.getInt("count(*)");
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0){
			lastPage = lastPage + 1;
%>
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
	<table>
		<h1>공지사항 리스트</h1>
		<a href="./insertNoticeForm.jsp">공지입력</a>
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
	<%
		if(currentPage > 1){
	%>
			<a href="./noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	<%		
		}
		if(currentPage < lastPage){
	%>
			<div><%=currentPage %> 페이지</div>
			<a href="./noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
	<%		
		}}
	%>
</body>
</html>