<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	//세션 유효성 검사
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
</div>
<h1>회원가입</h1>
<%
	if(request.getParameter("msg") != null){
%>
		<%=request.getParameter("msg")%>
<%		
	}
%>
<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp">
	<table>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="insertMemberId">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="insertMemberPw">
			</td>
		</tr>
	</table>
	<button type="submit">회원가입</button>
</form>
<div>
	<jsp:include page="/inc/copyright.jsp"></jsp:include>
</div>
</body>
</html>