<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		 페이지 속성 변수 - <%=pageContext.getAttribute("x") %>
	</div>
	<div>
		세션 속성 변수 - <%=session.getAttribute("y1") %>
	</div>
	<div>
		세션 속성 변수(random) - <%=session.getAttribute("y2") %>
	</div>
	<div>
		어플리케이션 속성 변수(random) - <%=application.getAttribute("z") %>
	</div>
</body>
</html>