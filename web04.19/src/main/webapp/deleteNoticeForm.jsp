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
</head>
<body>
	<h1>공지 삭제</h1>
	<form action="./deleteNoticeAction.jsp" method="post">
		<table>
			<tr>
			<td>notice_no</td>
			<td>
				<%-- <input type="hidden" name="noticeNo" value="<%=noticeNo%>"> --%> <!-- 화면에 안보이게 수정하는 것, 따라서 수정할 수 없음 -->
				<input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly"> <!-- 화면에 보이게 하는 것 다만 리드온니로 수정할 수 없게함 -->
			</td>
			</tr>
			<tr>
				<td>notice_pw</td>
				<td>
					<input type="password" name="noticePw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">삭제 </button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>