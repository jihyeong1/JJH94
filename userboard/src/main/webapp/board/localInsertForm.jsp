<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>     
<%
	//세션검사
	if(session.getAttribute("loginMemberId") == null) {				// 로그인 중이 아니라면
		response.sendRedirect(request.getContextPath()+"/home.jsp");// 홈으로
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
<div>
	<h1>카테고리 추가</h1>
	<%
		if(request.getParameter("msg") != null){
	%>
		<%=request.getParameter("msg") %>
	<%		
		}
	%>
	<form action="<%=request.getContextPath()%>/board/localInsertAction.jsp" method="post">
		<table>
			<tr>
				<td>지역명</td>
				<td>
					<input type="text" name="localName">
				</td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
</div>
</body>
</html>