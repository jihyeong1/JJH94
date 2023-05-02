<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%@ page import = "vo.*" %>   
<%
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList.jsp"); // 다시 가야할 주소를 보내주는것
		return; // 1)지금진행하는 실행코드를 종료할 때  2) 반환값을 남길때
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setInt(1, noticeNo); // stmt 첫번째 물음표의 값을 noticeNo 로 바꿀꺼다.
						    // 물음표가 많아지면 순서대로 숫자를 쓰면된다. String 일경우 문자값이기때문에 뒤에 ''가 붙어야한다.
	System.out.println(stmt + " <--stmt");
	
	ResultSet rs = stmt.executeQuery();
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
			height: 650px;
			background-color: #F6F6F6;
			margin: 0 auto;
			text-align: center;
			margin-top: 50px;
		}
		table{
			height: 400px; 
		}
		table, td{
			width: 70%;
			margin: 0 auto;
			line-height: 2;
			margin-left: 15%;
			margin-top: 10px;
			border: 1px solid #BDBDBD;
			border-collapse: collapse;
		}
		table td.title{
			background-color: #A6A6A6;
			width: 300px;
			font-weight: bold;
			color: #FFFFFF;
			font-size: 18px;
		}
	</style>
</head>
<body>
	<header>
		<div class="nav"> <!-- 메인메뉴 -->
			<div>		
				<h2><img alt="-" src="./img/notice.png" style="width: 35px;"> Notice detail page</h2>
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
		<h1 style="padding-top: 30px; margin-left: 65px;">공지 상세설명</h1>
		<%
			//모델데이터
			// 한가지의 값(한가지의 행)만 출력해야할 때에는 arraylist를 쓰는것보다 rs로 아래처럼 사용해주는게 좋다.
			// 다만 arraylist로 사용해도 무방하긴하나 아래방법을 써라.
			Notice notice = null;
			if(rs.next()){
				notice = new Notice();
				notice.noticeNo = rs.getInt("notice_no");
				notice.noticeTitle = rs.getString("notice_title");
				notice.noticeContent = rs.getString("notice_content");
				notice.noticeWriter = rs.getString("notice_writer");
				notice.createdate = rs.getString("createdate");
				notice.updatedate = rs.getString("updatedate");		
			}
		%>
				<table>
				<tr>
					<td class="title">notice_no</td>
					<td><%=notice.noticeNo %></td>
				</tr>
				
				<tr>
					<td class="title">notice_title</td>
					<td><%=notice.noticeTitle%></td>
				</tr>
				
				<tr>
					<td class="title">notice_content</td>
					<td><%=notice.noticeContent %></td>
				</tr>
				
				<tr>
					<td class="title">notice_writer</td>
					<td><%=notice.noticeWriter %></td>
				</tr>
				
				<tr>
					<td class="title">createdate</td>
					<td><%=notice.createdate %></td>
				</tr>
				
				<tr>
					<td class="title">updatedate</td>
					<td><%=notice.updatedate %></td>
				</tr>
			</table>
			<div style="float: right; margin-top: 40px;">
				<a style="background-color: #A6A6A6; padding: 15px; border-radius: 10px; color: #FFFFFF; font-size: 20px; margin-right: 20px;"  href="./updateNoticeForm.jsp?noticeNo=<%=noticeNo %>">수 정</a>
				<a style="background-color: #A6A6A6; padding: 15px; border-radius: 10px; color: #FFFFFF; font-size: 20px; margin-right: 20px;" href="./deleteNoticeForm.jsp?noticeNo=<%=noticeNo %>">삭 제</a>
			</div>
		</div>	
</body>
</html>