<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 전 사용자만이 접근 가능
	if(session.getAttribute("loginId") != null){ //현재 사용자 브라우저에서 로그인이 없다
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
	<h1>로그인 폼</h1>
	<%
		if(request.getParameter("msg") != null){
	%>
			<div><%=request.getParameter("msg")%></div>	
	<%		
		}
	%>
	<!-- request.getContextPath()는 절대주소이며 프로젝트폴더를 불러오는 코드 -->
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="id">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="pw">	
				</td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>