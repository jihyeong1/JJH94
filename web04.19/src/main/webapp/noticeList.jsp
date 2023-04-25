<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
<%@ page import = "vo.*" %> 

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
		PreparedStatement stmt = conn.prepareStatement("select notice_no noticeNo, notice_title noticeTitle ,createdate from notice order by createdate desc limit ?, ?");
		
		
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerPage);
		// 준비 단계
		// 문자열 모양의 쿼리를 실제 마리아디비 쿼리타입으로 변경해준다.
		System.out.println(stmt + " <--stmt");
		
		//출력할 공지 데이터
		ResultSet rs = stmt.executeQuery();
		// 자료구조(하나가아닌 집함인형태를 자료구조라고한다)ResultSet타입을 일반적인 자료구조타입(자바 배열 or 기본API 타입으로 변경)
		// 기본 API 자료구조타입에는 List,Set, Map 이 있다.
		// ResultSet -> ArrayList<Notice <-클래스 >로 바꿀것이다.
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		while(rs.next()){
			Notice n = new Notice();
			n.noticeNo = rs.getInt("noticeNo");
			n.noticeTitle = rs.getString("noticeTitle"); 
			n.createdate = rs.getString("createdate");
			noticeList.add(n);
		}
		
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
		.center{
			margin-left: 50%;
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
			text-align: center;
			margin-top: 50px;
		}
		.nav2{
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		.notice{
			width: 90%;
			margin: 0 auto;
		}
		.nav2{
			padding-top: 20px;
		}
		table{
			width: 80%;
			margin: 0 auto;
			line-height: 2;
			margin-left: 100px;
			margin-top: 10px;
		}
	</style>
</head>
<body>
	<header>
		<div class="nav"> <!-- 메인메뉴 -->
			<div>		
				<h2><img alt="-" src="./img/notice.png" style="width: 35px;"> Notice list</h2>
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
	
	<!-- 날짜순 최근 공지 5개 -->
	<div class="content">
		<table>
			<div class="nav2">
				<div style="padding-left: 40%;">
					<h1>공지사항 리스트</h1>
				</div>
				<div style="padding-right: 30px;">
					<a href="./insertNoticeForm.jsp"><img alt="+" src="./img/duplicate.png" style="width: 50px;"> </a>
				</div>
			</div>
				<tr>
					<th>notice_title</th>
					<th>createdate</th>
				</tr>
			<%
				for(Notice n : noticeList) {
			%>
				<tr>
					<td style="border-right: 1px dashed #000000;">
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
		<footer>
			<%
				if(currentPage > 1){
			%>
					<a href="./noticeList.jsp?currentPage=<%=currentPage-1%>" style="float: left; padding-left: 10px;"><img alt="+" src="./img/next1.png"></a>
			<%		
				}
				if(currentPage < lastPage){
			%>
					<div style="margin-top: 110px; font-size: 20px;" ><%=currentPage %> 페이지	
					<a href="./noticeList.jsp?currentPage=<%=currentPage+1%>" style="float: right; padding-right: 10px;"><img alt="+" src="./img/next.png"></a></div>
			<%		
				}}
			%>
		</footer>
	</div>
</body>
</html>