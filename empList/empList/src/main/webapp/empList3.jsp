<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Controller Layer
	// gender(null, "", M, F) 값이 들어올 수 있고 SearchWord(null, "", "검색단어")
	String gender = "";
	if(request.getParameter("gender") != null){
		gender = request.getParameter("gender");
	}
	String searchWord = "";
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
	}
	
	//Model Layer
	//쿼리분기 1)둘다공백 2)서치워드공백 3)젠더 공백 4)둘다 값가짐
	// 1) select * from employee
	// 2)  select * from employee where gender = ?
	// 3)  select * from employee where	searchWord like = ?
	// 4)  select * from employee where gender = ? searchWord like = ?
	/*
	젠더가 널
	콜 값 
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>사원 목록</h1>
	<table>
		<thead>
			<tr>
				<th>empNo</th>
				<th>birthDate</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>gender</th>
				<th>hireDate</th>
			</tr>
		</thead>
		<tbody>
			<!-- 어레이리스트 모델 자료구조 수노한 출력 -->
		</tbody>
	</table>
	<!-- 요청 폼 -->
	<div>
		<form action="./empList3.jsp" method="get">
			<label>성별 : </label>
			<select name="gender">
			<%
				if(gender.equals("")){
			%>
					<option value="" selected="selected">선택</option>
					<option value="M">남</option>
					<option value="F">여</option>
			<%		
				}else if(gender.equals("M")){
			%>
					<option value="" >선택</option>
					<option value="M" selected="selected">남</option>
					<option value="F">여</option>
			<%							
				}else if(gender.equals("F")){
			%>
					<option value="">선택</option>
					<option value="M">남</option>
					<option value="F" selected="selected">여</option>
			<%		
				}
			%>
			</select>
			<label>이름검색 : </label>
			<input type="text" name="searchWord" value="<%=searchWord%>">
			<button type="submit">조회</button>
		</form>
	</div>
	<!-- 페이지 네비게이션 -->
	<div>
		<a href="">이전</a>
		<a href="">다음</a>	
	</div>
</body>
</html>