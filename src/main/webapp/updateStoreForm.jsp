<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
	//유효성 검사
	if(request.getParameter("storeNo")==null){
		//값이 없을 때 다시 가야할 주소
		response.sendRedirect("./storeList.jsp");
		return;
	}

	// 값 저장
	int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	
	//디비 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/homework0419","root","java1234");
	// 해당 값을 불러와서 봐야하기 때문에 select문을 활용해야한다. where? 어디에서 store_no 는 사용자가 고른 번호로
	String sql = "select store_no, store_name, store_address, store_emp_cnt, store_begin, createdate, updatedate from store where store_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,storeNo);
	
	//디버깅
	System.out.println(stmt + "<--stmt 쿼리");
	
	// 결과값을 rs 에 넘겨준다
	ResultSet rs = stmt.executeQuery();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//결과 값을 가져오기
	if(rs.next()){ //이걸 사용하지않으면 에러가 날 수 있다.
%>
	<form action="./updateStoreAction.jsp" method="post">
		<table>
			<tr>
				<td>가게 순번</td>
				<td>
					<input type="number" name="storeNo" value="<%=rs.getInt("store_no")%>"
					readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>가게 이름</td>
				<td>
					<input type="text" name="storeName" value="<%=rs.getString("store_name")%>">
				</td>
			</tr>
			<tr>
				<td>가게 비밀번호</td>
				<td>
					<input type="password" name="storePw">
				</td>
			</tr>
			<tr>
				<td>가게 주소</td>
				<td>
					<input type="text" name="storeAddress" value="<%=rs.getString("store_address")%>">
				</td>
			</tr>
			<tr>
				<td>종업원 수</td>
				<td>
					<input type="number" name="storeEmpCnt" value="<%=rs.getInt("store_emp_cnt")%>">
				</td>
			</tr>
			<tr>
				<td>개업 일자</td>
				<td>
					<%=rs.getString("store_begin") %>
				</td>
			</tr>
			<tr>
				<td>createdate</td>
				<td>
					<%=rs.getString("createdate") %>
				</td>
			</tr>
			<tr>
				<td>updatedate</td>
				<td>
					<%=rs.getString("updatedate") %>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
<%
	}
%>	
</body>
</html>