<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>    
<%
	// 현재페이지 만들기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 디버깅
	System.out.println(currentPage + " <-- currentPage");
	
	// DB 연결
	// 드라이버 불러오기
	Class.forName("org.mariadb.jdbc.Driver");
	java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("select store_no, store_name, store_category, store_address, store_emp_cnt, store_begin from store order by store_no asc limit ?,? ");
	
	//페이지 당 출력 할 행의 수
	int rowPerPage = 20; 
	
	// 시작 행번호
	int StartRow = (currentPage - 1) * rowPerPage;
	/*  currentpage    startpow(20)
			1			0
			2			20
			3			40
	*/
	
	stmt.setInt(1,StartRow);
	stmt.setInt(2,rowPerPage);
	
	ResultSet rs = stmt.executeQuery();
	
	// 마지막페이지
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from store");
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if(rs2.next()){ // 차례대로 정렬
		totalRow = rs2.getInt("count(*)");
	}
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0 ){
		lastPage = lastPage +1;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		h1{
			text-align: center;
			margin: 20px;
		}
		table{
			text-align: center;
		}
		a{
			text-decoration: none;
			background-color: #FFB2D9;
			border-radius: 15px;
			color: #FFFFFF;
			padding: 15px 25px;
			font-size: 20px;
		}
		.currentPage{
			margin-top: 40px;
		}
		span{
			padding: 0px 20px;
			font-weight: bold;
			font-size: 20px;
		}
		.delete{
			font-size: 20px;
			padding: 5px;
		}
		.update{
			background-color: #A6A6A6;
			font-size: 20px;
			padding: 5px;
		}
	</style>
</head>
<body class="container-fluid">
	<h1><img alt="#" src="./img/store.png" style="width: 50px;"> 맛집 리스트 <img alt="#" src="./img/store.png" style="width: 50px;"></h1>
	<table class="table table-striped">
		<tr>
			<th>순번</th>
			<th>맛집 이름</th>
			<th>가게 업종</th>
			<th>가게 주소</th>
			<th>종업원 수</th>
			<th>개업 일자</th>
			<th>삭 제</th>
			<th>수 정</th>
		</tr>
	<%
		while(rs.next()){
	%>
		<tr>
			<td><%=rs.getInt("store_no")%></td>
			<td><%=rs.getString("store_name") %></td>
			<td><%=rs.getString("store_category") %></td>
			<td><%=rs.getString("store_address") %></td>
			<td><%=rs.getInt("store_emp_cnt") %></td>
			<td><%=rs.getString("store_begin")%></td>
			<td>
				<a href="./deleteStoreForm.jsp?storeNo=<%=rs.getInt("store_no")%>" class="delete">삭제</a>
			</td>
			<td>
				<a href="./updateStoreForm.jsp?storeNo=<%=rs.getInt("store_no")%>" class="update">수정</a>
			</td>
		</tr>
	<%		
		}
	%>		
	</table>
	<% 
		if(currentPage > 1){
	%>
		<div class="currentPage">
			<a href="./storeList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
	<%		
		}
	%>
			<span><%=currentPage + "페이지" %></span>
	<%
		if(currentPage < lastPage){
	%>
			<a  href="./storeList.jsp?currentPage=<%=currentPage+1 %> ">다음</a>
		</div>	
	<%		
		}
	%>
</body>
</html>