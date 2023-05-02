<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/home.jsp">홈으로</a>
		</li>
		<!-- 로그인전 : 회원가입
		로그인후 : 회원정보 / 로그아웃(로그인정보는 세션 loginMemberId -->
		<%
			if(session.getAttribute("loginMemberId") == null ){
				//로그인전
		%>	
				<li>
					<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
				</li>
		<%		
			}else{
		%>
				<li>
					<a href="<%=request.getContextPath()%>">회원정보</a>
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
				</li>
		<%		
			}
		%>
	
	</ul>
</div>