<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>    
<%@ page import = "java.sql.PreparedStatement" %> 
<%@ page import = "java.sql.ResultSet" %>     
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
</head>
<body>
	<div> <!-- 메인메뉴 -->
		<a href="./form.jsp">홈으로</a>
		<a href="./noticeList.jsp">공지 리스트</a>
		<a href="./diaryList.jsp">일정 리스트</a>
	</div>
	
	<h1>공지 상세</h1>
	<%
		if(rs.next()){
	%>
			<table>
			<tr>
				<td>notice_no</td>
				<td><%=rs.getInt("notice_no") %></td>
			</tr>
			
			<tr>
				<td>notice_title</td>
				<td><%=rs.getString("notice_title") %></td>
			</tr>
			
			<tr>
				<td>notice_content</td>
				<td><%=rs.getString("notice_content") %></td>
			</tr>
			
			<tr>
				<td>notice_writer</td>
				<td><%=rs.getString("notice_writer") %></td>
			</tr>
			
			<tr>
				<td>createdate</td>
				<td><%=rs.getString("createdate") %></td>
			</tr>
			
			<tr>
				<td>updatedate</td>
				<td><%=rs.getString("updatedate") %></td>
			</tr>
		</table>
	<%		
		}
	%>
	<div>
		<a href="./updateNoticeForm.jsp?noticeNo=<%=noticeNo %>">수정</a>
		<a href="./deleteNoticeForm.jsp?noticeNo=<%=noticeNo %>">삭제</a>
	</div>
</body>
</html>