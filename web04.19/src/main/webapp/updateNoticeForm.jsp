<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>    
<%@ page import = "java.sql.PreparedStatement" %> 
<%@ page import = "java.sql.ResultSet" %>  
<%
	//유효성 코드 추가 -> 분기(respon?) 추가해야함 -> return 으로 종료해서 끝내기
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList.jsp"); // 다시 가야할 주소를 보내주는것
		return; // 1)지금진행하는 실행코드를 종료할 때  2) 반환값을 남길때
	// if문에서 else를 쓰기보다는 return 으로 종료해버리는게 더 코드줄이기에 용의하다.
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, noticeNo); 
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
	<%
		if(rs.next()){ //이걸 안썼을 때 rs 값이 들어오지 않으니 계속 오류가 남, if 문을 써서 만약 rs.next 가 들어왔을때 값이 나오게해라 라는 명령을 해줘야함.
	%>
	<form action="./updateNoticeAction.jsp" method="post">		
		<table>
			<tr>
				<td>notice_no</td>
				<td>
					<input type="number" name="noticeNo" value="<%=rs.getInt("notice_no")%>"
					 readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>notice_pw</td>
				<td>
					<input type="password" name="noticePw">
				</td>
			</tr>
			<tr>
				<td>notice_title</td>
				<td>
					<input type="text" name="noticeTitle" value="<%=rs.getString("notice_title")%>">
				</td>
			</tr>
			<tr>
				<td>notice_content</td>
				<td>
					<textarea rows="5" cols="80" name="noticeContent">
						<%=rs.getString("notice_content") %>
					</textarea>
				</td>
			</tr>
			<tr>
				<td>notice_writer</td>
				<td>
					<%=rs.getString("notice_writer")%>
				</td>
			</tr>
			<tr>
				<td>createdate</td>
				<td>
					<%=rs.getString("createdate") %>
				</td>
			</tr>
			<tr>
				<td>updatedate</td>
				<td>
					<%=rs.getString("updatedate") %>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	<%
		}
	%>
</body>
</html>