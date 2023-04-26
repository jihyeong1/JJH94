<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//페이지 만들기
	//현재페이지 설정
	int currentpage = 1;
	if(request.getParameter("currentpage") != null){
		currentpage = Integer.parseInt(request.getParameter("currentpage"));
	}
	System.out.println(currentpage + "<-- 현재 currentpage");
	
	//출력 할 리스트 행 갯수 설정
	int outPutPage = 10;
	
	//페이지 넘길 때 시작하는 행 번호 설정
	int startrow = (currentpage - 1) * outPutPage;
	
	//첫 페이지 설정 해줬으니 디비 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3307/employees","root","java1234");
	//sql설정하기
	/*
		SELECT
		emp_no empNo,
		birth_date birthDate,
		first_name firstName,
		last_name lastName,
		gender gender,
		hire_date hireDate
		YEAR(birth_date) byear,
		MONTH(birth_date) bmonth,
		DAY(birth_date) bday
		FROM employees
		LIMIT ?, ?;
	*/
	String col = "emp_no";
	String aseDesc = "ASC";
	
	if(request.getParameter("col") != null 
		&& request.getParameter("aseDesc") != null){
		col = request.getParameter("col"); 
		aseDesc = request.getParameter("aseDesc");
	}
	// ex col -> birth_date 라는 문자열이 넘어오고 order -> ASC 값이 넘어오면 "birth_date ASC" 로 만들어진다
		
	//나이를 구하기 위해서 sql에서 년,월,일을 짤라서 가져왔다.
	String sql = "SELECT emp_no empNo, birth_date birthDate, first_name firstName, last_name lastName, gender gender, hire_date hireDate, YEAR(birth_date) byear, MONTH(birth_date) bmonth, DAY(birth_date) bday FROM employees ORDER BY "+col+" "+aseDesc+" LIMIT ?, ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startrow);
	stmt.setInt(2, outPutPage);
	
	//디버깅
	System.out.println(stmt + "<-- stmt 값");
	ResultSet rs = stmt.executeQuery();
	
	//에리아리스트 설정, 리스트를 나오게 하자
	ArrayList<EmpList> empList = new ArrayList<EmpList>();
	while(rs.next()){
		EmpList e = new EmpList();
		e.empNo = rs.getInt("empNo");
		e.birthDate = rs.getString("birthDate");
		e.firstName = rs.getString("firstName");
		e.lastName = rs.getString("lastName");
		e.gender = rs.getString("gender");
		e.hireDate = rs.getString("hireDate");
		// 짤라온 sql문을 에리아리스트에 넣어준다.
		e.byear = rs.getInt("byear");
		e.bmonth = rs.getInt("bmonth");
		e.bday = rs.getInt("bday");
		empList.add(e);
	}
	
	//마지막 페이지 설정
	//sql설정
	/*
		SELECT count(*) from employees
	*/
	String sql2 = "SELECT count(*) from employees";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = stmt2.executeQuery();
	//디버깅 확인
	System.out.println(stmt2 +"<-- stmt2 값");
	
	//토탈로우 설정
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("count(*)");
	}
	//마지막페이지 출력했을 때 남는 행 있으면 어떻게 해야하는지 설정
	int lastPage = totalRow/outPutPage;
	if(totalRow % outPutPage != 0){
		lastPage = lastPage +1;
	}
	
	//나이 출력
	//캘린더 가져오기
	Calendar today = Calendar.getInstance();
	int year = today.get(Calendar.YEAR);
	int month = today.get(Calendar.MONTH);
	int day = today.get(Calendar.DATE);
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		table, td, th {
			border: 1px solid #BDBDBD; 
		}
		table {
			border-collapse: collapse;
			width: 1280px;
			height: 600px;
			background-color: #F6F6F6;
			text-align: center;
			margin: 0 auto;
		}
		th{
			background-color: #FFB2D9;
		}
		.content{
			text-align: center;
			margin-top: 50px;
		}
		footer{
			width: 1280px;
			margin: 0 auto;
		}
	</style>
</head>
<body>
	<h1 style="text-align: center; font-size: 50px;"><img alt="*" src="./img/job-seeker.png" style="width: 50px; margin-right: 15px;">emp List</h1>
	<div class="content">
		<table>
			<tr>
				<th>
					empNo
					<a href="./empList.jsp?col=emp_no&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=emp_no&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					birthDate
					<a href="./empList.jsp?col=brith_date&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=brith_date&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					age
					<a href="./empList.jsp?col=age&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=age&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					firstName
					<a href="./empList.jsp?col=first_name&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=first_name&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					lastName
					<a href="./empList.jsp?col=last_name&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=last_name&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					gender
					<a href="./empList.jsp?col=gender&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=gender&aseDesc=DESC">[desc]</a>
				</th>
				<th>
					hireDate
					<a href="./empList.jsp?col=hire_date&aseDesc=ASC">[asc]</a>
					<a href="./empList.jsp?col=hire_date&aseDesc=DESC">[desc]</a>
				</th>
			</tr>
			<%
				for(EmpList e : empList){
			%>
			<tr>
				<td><%=e.empNo%></td>
				<td><%=e.birthDate%></td>
			<%
				// 캘린더 year 와 가져온 byear을 빼서 현재 나이 구하기			
				int age = year - e.byear;	
				if(e.bmonth < month && e.bday < day){
					// 만약 달과 일이 지났으면 +1해서 나이 계산
			%>
					<td><%=age = age+1 %></td>
			<%		
				}else{
			%>
					<td><%=age = age-1 %></td>
			<%		
				}
			%>	
				<td><%=e.firstName%></td>
				<td><%=e.lastName%></td>
				<td><img alt="*" src="./img/<%=e.gender%>.png"></td>
				<td><%=e.hireDate%></td>
			</tr>
		<%		
			}
		%>
		</table>
	</div>
	<footer>
		<%
				if(currentpage > 1){
			%>
					<a href="./empList.jsp?currentpage=<%=currentpage-1%>"style="float: left; padding-left: 10px;"><img alt="+" src="./img/next1.png"></a>
			<%		
				}
				if(currentpage < lastPage){
			%>
					<div style="margin-top: 30px; font-size: 25px; text-align: center;" ><%=currentpage %> 페이지	
					<a href="./empList.jsp?currentpage=<%=currentpage+1%>"style="float: right; padding-right: 10px;"><img alt="+" src="./img/next.png"></a></div>
			<%		
				}
			%>
	</footer>
</body>
</html>