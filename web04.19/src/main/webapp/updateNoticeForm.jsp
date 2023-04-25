<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %> 
<%@ page import = "vo.*" %>
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
	
	//한 행만 가지고오면되기때문에 에레이리스트 안쓰고 모델데이터로 써준다.
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
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		h1{
			text-align: center;
		}	
		h1 img{
			margin-right: 10px;
		}
		.content{
			width: 1280px;
			height: 600px;
			background-color: #F6F6F6;
			margin: 0 auto;
			margin-top: 30px;
			padding-top: 40px;
		}
		table{
			height: 500px;
		}
		table, td{
			width: 70%;
			margin: 0 auto;
			line-height: 2;
			margin-left: 15%;
			margin-top: 10px;
			border: 1px solid #BDBDBD;
			border-collapse: collapse;
			text-align: center;
		}
		table td.title{
			background-color: #A6A6A6;
			width: 300px;
			font-weight: bold;
			color: #FFFFFF;
			font-size: 18px;
		}
		input{
			text-align: center;
		}
		input, textarea{
			float: left;
			margin-left: 10px;
		}
		button{
			background-color: #A6A6A6; 
			padding: 10px; 
			border-radius: 10px; 
			color: #FFFFFF; 
			font-size: 20px; 
			float: right;
			margin-right: 20px;
			margin-top: 10px;
		}
	</style>
</head>
<body>
	<form action="./updateNoticeAction.jsp" method="post">
		<h1><img alt="-" src="./img/notice.png" style="width: 35px;">공지 수정</h1>
		<div class="content">		
			<table>
				<tr>
					<td class="title">notice_no</td>
					<td>
						<input type="number" name="noticeNo" value="<%=notice.noticeNo%>"
						 readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="title">notice_pw</td>
					<td>
						<input type="password" name="noticePw">
					</td>
				</tr>
				<tr>
					<td class="title">notice_title</td>
					<td>
						<input type="text" name="noticeTitle" value="<%=notice.noticeTitle%>">
					</td>
				</tr>
				<tr>
					<td class="title">notice_content</td>
					<td>
						<textarea rows="5" cols="80" name="noticeContent"><%=notice.noticeContent %>
						</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">notice_writer</td>
					<td>
						<%=rs.getString("notice_writer")%>
					</td>
				</tr>
				<tr>
					<td class="title">createdate</td>
					<td>
						<%=rs.getString("createdate") %>
					</td>
				</tr>
				<tr>
					<td class="title">updatedate</td>
					<td>
						<%=rs.getString("updatedate") %>
					</td>
				</tr>
			</table>
			<button type="submit">수 정</button>
		</div>
	</form>
</body>
</html>