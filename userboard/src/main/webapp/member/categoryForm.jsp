<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %> 
<%@ page import="vo.*" %>
<%
	//세션검사
	if(session.getAttribute("loginMemberId") == null) {				// 로그인 중이 아니라면
		response.sendRedirect(request.getContextPath()+"/home.jsp");// 홈으로
		return;	
	}
	//모델링
	//디비
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//로컬리스트쿼리문
	PreparedStatement localStmt = null;
	ResultSet localRs = null;
	/* SELECT local_name localName, createdate, updatedate form local; */
	String localSql="SELECT local_name localName, createdate, updatedate from local;";
	localStmt = conn.prepareStatement(localSql);
	
	//디버깅
	System.out.println(localStmt + "<--categoryForm pram localStmt");
	localRs = localStmt.executeQuery();
	
	//localList 모델데이터
	ArrayList<LocalList> localList = new ArrayList<LocalList>();
	while(localRs.next()){
		LocalList l = new LocalList();
		l.setLocalName(localRs.getString("localName"));
		l.setCreatedate(localRs.getString("createdate"));
		l.setUpdatedate(localRs.getString("updatedate"));
		localList.add(l);
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
	<h1>카테고리 목록</h1>
</div>
<a href="<%=request.getContextPath()%>/board/localInsertForm.jsp">카테고리 추가</a>
<table>
	<tr>
		<th>지역명</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
		<%
			for(LocalList l : localList){
		%>
		<tr>
				<td><%=l.getLocalName()%></td>
				<td>
					<a href="<%=request.getContextPath()%>/board/localUpdateForm.jsp?localName=<%=l.getLocalName()%>">수정</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/board/localDeletAction.jsp?localName=<%=l.getLocalName()%>">삭제</a>
				</td>
		</tr>
		<%		
			}
		%>
</table>
</body>
</html>