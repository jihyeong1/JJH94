<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>     
<%
	//세션검사
	if(session.getAttribute("loginMemberId") == null) {				// 로그인 중이 아니라면
		response.sendRedirect(request.getContextPath()+"/home.jsp");// 홈으로
		return;	
	}
	
	// 요청값 검사
	if(request.getParameter("localName") == null
		|| request.getParameter("localName").equals("")){
		 String msg = URLEncoder.encode("지역명을 입력해주세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/board/localInsertForm.jsp?msg="+msg);
	}
	// 넘어온 localName이 없을 때
	// 변수 설정
	// 디비연결
	// localName 추가(insert)하는 쿼리문 설정
	// insert가 잘 되었는지 추가 확인(row)
%>