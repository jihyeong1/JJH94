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
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<div>
		<!-- home 내용 : 로그인폼/ 카테고리별 게시글 5개씩  -->
		<!-- 로그인 폼 -->
		<%
			if(session.getAttribute("loginMemberId")==null){
				//로그인전이면 로그인폼출력
		%>
			<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td>
							<input type="text" name="memberId">
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw">	
						</td>
					</tr>
				</table>
				<button type="submit">로그인</button>
			</form>
		<%		
			}
		%>
		<!-- 카테고리별 게시글 5개씩 -->
	</div>
	
	<div>
		<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
		<jsp:include page="/inc/copyright.jsp"></jsp:include>
	</div>
</body>
</html>