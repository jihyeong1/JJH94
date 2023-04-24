<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
	// 디버깅
	System.out.println(request.getParameter("storeNo" + "home에서 넘어온 storeNo값"));
	System.out.println(request.getParameter("store_name" + "home에서 넘어온 store_name"));
	System.out.println(request.getParameter("store_category" + "home에서 넘어온 store_category"));
	System.out.println(request.getParameter("store_address" + "home에서 넘어온 store_address"));
	
	// 유효성 검사
	if(request.getParameter("storeNo")==null){
		response.sendRedirect("./home.jsp");
		return;
	}
	
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	
	// 디비연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	String sql ="SELECT store_no, store_name, store_category, store_address, store_emp_cnt, store_begin, createdate, updatedate FROM store where store_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, storeNo);
	
	//디버깅
	System.out.println(stmt + "<--stmt");
	
	ResultSet rs = stmt.executeQuery();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>가게 상세 설명</h1>
	<%
		if(rs.next()){
	%>
	<table>
		<tr>
			<td>가게 번호</td>
			<td><%=rs.getInt("store_no")%></td>
		</tr>
		<tr>
			<td>가게 이름</td>
			<td><%=rs.getString("store_name")%></td>
		</tr>
		<tr>
			<td>가게 업종</td>
			<td><%=rs.getString("store_category")%></td>
		</tr>
		<tr>
			<td>가게 주소</td>
			<td><%=rs.getString("store_address")%></td>
		</tr>
		<tr>
			<td>종업원 수</td>
			<td><%=rs.getInt("store_emp_cnt")%></td>
		</tr>
		<tr>
			<td>개업 일자</td>
			<td><%=rs.getString("store_begin")%></td>
		</tr>
		<tr>
			<td>createdate</td>
			<td><%=rs.getString("createdate")%></td>
		</tr>
		<tr>
			<td>updatedate</td>
			<td><%=rs.getString("updatedate")%></td>
		</tr>
	</table>
	<%		
		}
	%>
	<div>
		<a href="">수정</a>
		<a href="">삭제</a>
	</div>
</body>
</html>