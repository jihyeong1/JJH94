<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 사용자만이 접근
	if(session.getAttribute("loginId") == null){ //현재 사용자 브라우저에서 로그인이 없다
		String msg = URLEncoder.encode("잘못된 접근입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginform.jsp?msg="+msg);
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
	<%
		String loginId =(String)session.getAttribute("loginId");
	%>
	<h1>홈</h1>
	<div>
		<%=loginId %> 님 반갑습니다.
		<a href="<%=request.getContextPath()%>/logoutAction.jsp">로그아웃</a>
	</div>
</body>
</html>