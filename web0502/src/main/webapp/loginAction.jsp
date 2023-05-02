<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	System.out.println(id + "<-- loginAction id");
	System.out.println(pw + "<-- loginAction pw");

	//db접근 후 멤버테이블에 입력한 id(기본키)와 pw가 일치하는 행이 있으면 ->로그인 성공, 없으면 ->실패
	//select * from member where id=? and pw=?
	
	final String tableId = "admin";
	final String tablePw = "1234";
	
	if(tableId.equals(id) && tablePw.equals(pw)) {
		System.out.println("로그인 성공");
		// 로그인 성공 정보(사용자 id)만을 세팅
		session.setAttribute("loginId", id);
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	}else{
		System.out.println("로그인 실패");
		String msg = URLEncoder.encode("아이디와 비밀번호를 다시 입력", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginform.jsp?msg="+msg);
	}
%>