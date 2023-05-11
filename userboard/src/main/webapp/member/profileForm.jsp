<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %> 
<%@ page import="vo.*" %>   
<%
	//세션 유효성 검사
	if(session.getAttribute("loginMemberId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	//로그인 중인 아이디 변수에 저장
	String loginMemberId = (String)session.getAttribute("loginMemberId");
	//디버깅
	System.out.println(loginMemberId + "<--loginMemberId");
	
	//디비접속
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//memberId 와 일치하는 행 조회하기
	PreparedStatement profileStmt = null;
	ResultSet profileRs = null;
	String profileSql = "SELECT member_id memberId, member_pw memberPw, createdate, updatedate FROM member WHERE member_id = ?";
	profileStmt = conn.prepareStatement(profileSql);
	profileStmt.setString(1, loginMemberId);
	// 위 sql문 디버깅
	System.out.println(profileStmt+"<--profileForm pram profileStmt");
	//전송한 sql문 반환
	profileRs = profileStmt.executeQuery();
	Member profile = null;
	if(profileRs.next()){
		profile = new Member();
		profile.setMemberId(profileRs.getString("memberId"));
		profile.setMemberPw(profileRs.getString("memberPw"));
		profile.setCreatedate(profileRs.getString("createdate"));
		profile.setUpdatedate(profileRs.getString("updatedate"));
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
	<h1>회원 정보</h1>
	<form action="<%=request.getContextPath()%>/member/updatePasswordForm.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="memberId" value="<%=profile.getMemberId()%>" readonly="readonly" >
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="memberPw">
				</td>
			</tr>
			<tr>
				<td>생성날짜</td>
				<td><%=profile.getCreatedate().substring(0,10) %></td>
			</tr>
		</table>
		<button type="submit">비밀번호 수정</button>
		<button type="submit" formaction="<%=request.getContextPath()%>/member/deletdMemberAction.jsp">회원 탈퇴</button>
	</form>
</div>
</body>
</html>