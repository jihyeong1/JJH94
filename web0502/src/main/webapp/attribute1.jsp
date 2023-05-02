<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//페이지 변수는 다른페이지에서 호출할 수 없다. ->컴파일 에러
	String name = "page local variable : gdj66";
	//페이지 속성변수는 다른페이지에서 호출은 가능하지만 null값이 나온다. (값이 넘어가지 않는다.)
	pageContext.setAttribute("x", "pageContext : gdj66");
%>
	<div>
		<%=name%>
	</div>
	<div>	
		페이지 속성 변수 - <%=pageContext.getAttribute("x")%>
	</div>
<%
	//세션 속성 변수
	session.setAttribute("y1", "session : gdj66");
	session.setAttribute("y2", Math.random());
%>	
	<div>
		세션 속성 변수 - <%=session.getAttribute("y1") %>
	</div>
	<div>
		세션 속성 변수(random) - <%=session.getAttribute("y2") %>
	</div>
<!-- 페이지 변수는 페이지 내에서만 변수사용이 가능하다 하지만 세션 변수는 페이지를 이동하더라고
그 이동페이지에서 변수를 사용할 수 있다. -->

<%
	//어플리케이션 속성 변수
	application.setAttribute("z", Math.random());
%>	
	<div>
		<!-- 모든 클라이언트에서 접근 가능하다. -->
		어플리케이션 속성 변수 - <%=application.getAttribute("z") %>
	</div>
	<div>
		<a href="./attribute2.jsp">attribute2</a>
	</div>
</body>
</html>