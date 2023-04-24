<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
	//현재 페이지 만들기
	int currntpage = 1;
	if(request.getParameter("currntpage") != null){
		currntpage = Integer.parseInt(request.getParameter("currntpage"));
	}
	
	//디버깅
	System.out.println(currntpage +"<== currntpage");
	
	//디비 연결하기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	String sql ="SELECT store_no, store_name, store_category, store_address FROM store ORDER BY store_no LIMIT ?,?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	//디버깅
	System.out.println(stmt +"<== stmt");
	
	//몇 개씩 출력할지 설정
	int rowpage = 15;
	
	// 페이지를 출력했을 때 나오는 순서
	int startpage = (currntpage - 1)*rowpage;
	
	// limit 설정
	stmt.setInt(1, startpage);
	stmt.setInt(2, rowpage);
	
	ResultSet rs = stmt.executeQuery();
	
	//마지막 페이지에서 출력해야할 게 더 남았을 때 어떻게 해야하는지 설정
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from store");
	ResultSet rs2 = stmt2.executeQuery();
	int totalpage = 0;
	if(rs2.next()){ // 정렬되었을 때 
		totalpage = rs2.getInt("count(*)"); // 전체 갯수는 토탈로우로 설정
	}
	int lastpage = totalpage/rowpage;
	if(lastpage != 0){
		lastpage = lastpage + 1; //라스트페이지의 값이 0이 아닐때 라스트 페이지를 1개 더 생성
	}
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./storeList.jsp" method="post">
		<table>
			<tr>
				<th>가게 번호</th>
				<th>가게 이름</th>
				<th>분류</th>
				<th>가게 주소</th>
			</tr>
	<%
		while(rs.next()){
	%>
		<tr>
			<td><%=rs.getInt("store_no")%></td>
			<td>
				<a href="./listOne.jsp?storeNo=<%=rs.getInt("store_no")%>">
				<%=rs.getString("store_name") %></a>
			</td>
			<td><%=rs.getString("store_category") %></td>
			<td><%=rs.getString("store_address") %></td>
		</tr>
	<%
		}
		if(currntpage > 1){
	%>
		<div>
			<a href="./home.jsp?currntpage=<%=currntpage - 1 %>">이전</a>
		</div>
	<%		
		}
		if(currntpage < lastpage){
	%>
		<div>
			<a href="./home.jsp?currntpage=<%=currntpage + 1 %>">다음</a>
		</div>
	<%	
		}
	%>
		</table>
	</form>
</body>
</html>