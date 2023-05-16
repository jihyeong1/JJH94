<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %> 
<%
	//넘어온 값 확인 
	System.out.println(request.getParameter("localName")+"<--넘어온 localName"); 
	System.out.println(request.getParameter("boardTitle")+"<--넘어온 boardTitle");
	System.out.println(request.getParameter("boardContent")+"<--넘어온 boardContent");
	System.out.println(request.getParameter("memberId")+"<--넘어온 memberId");

	//loginMemberId 세션 검사
	if(session.getAttribute("loginMemberId") == null) {
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//유효성 검사
	String msg = "";
	if(request.getParameter("localName") == null
		||request.getParameter("localName").equals("")){
		
	}
%>