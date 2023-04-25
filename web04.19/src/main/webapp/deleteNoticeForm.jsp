<%@page import="java.awt.Insets"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청값 유효성 검사
	if(request.getParameter("noticeNo") == null) {
		response.sendRedirect("./noticeList.jsp"); // 다시 가야할 주소를 보내주는것
		return;} // 1)지금진행하는 실행코드를 종료할 때  2) 반환값을 남길때

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo	+ "<-- deletNoticeForm param noticeNo");
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
			width: 1180px;
			height: 400px;
			background-color: #F6F6F6;
			margin: 0 auto;
			margin-top: 30px;
			padding-top: 40px;
		}
		table{
			height: 200px;
			width: 700px;
		}
		table, td{
			margin: 0 auto;
			line-height: 2;
			margin-left: 15%;
			margin-top: 50px;
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
	<h1><img alt="-" src="./img/notice.png" style="width: 35px;">공지 삭제</h1>
	<form action="./deleteNoticeAction.jsp" method="post">
		<div class="content">	
			<table>
				<tr>
				<td class="title">notice_no</td>
				<td>
					<%-- <input type="hidden" name="noticeNo" value="<%=noticeNo%>"> --%> <!-- 화면에 안보이게 수정하는 것, 따라서 수정할 수 없음 -->
					<input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"> <!-- 화면에 보이게 하는 것 다만 리드온니로 수정할 수 없게함 -->
				</td>
				</tr>
				<tr>
					<td class="title">notice_pw</td>
					<td>
						<input type="password" name="noticePw">
					</td>
				</tr>
			</table>
			<button type="submit">삭제 </button>
		</div>
	</form>
</body>
</html>