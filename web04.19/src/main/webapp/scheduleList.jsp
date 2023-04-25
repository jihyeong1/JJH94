<%@page import="javax.print.CancelablePrintJob"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
<%@ page import = "vo.*" %> 
<%
	int targetYear = 0;
	int targetMonth = 0;
	
	// 년 월이 요청값에 넘어오지 않으면 오늘 날짜의 년 월값으로
	if(request.getParameter("targetYear")==null
		||request.getParameter("targetMonth")==null){
		Calendar c = Calendar.getInstance();
		targetYear = c.get(Calendar.YEAR);
		targetMonth = c.get(Calendar.MONTH);
	}else {
		targetYear =Integer.parseInt(request.getParameter("targetYear"));
		targetMonth =Integer.parseInt(request.getParameter("targetMonth"));
	}
	
	//디버깅
	System.out.println(targetYear + "<== scheduleList param targetYear");
	System.out.println(targetMonth + "<== scheduleList param tagetMonth");
	
	// 오늘 날짜 
	Calendar today = Calendar.getInstance();
	int todayDate = today.get(Calendar.DATE);
	
	// 타켓달 1일의 요일?
	Calendar firstDay = Calendar.getInstance(); // 오늘로 이야기하면 2023 4 24 일
	firstDay.set(Calendar.YEAR, targetYear); 
	firstDay.set(Calendar.MONTH, targetMonth);
	firstDay.set(Calendar.DATE, 1); // 여기서 날짜를 1일로 바꿔서 현재 값은 2023 4 1 로 되어있다.
	
	// 년23 월12 을입력 캘린더 API가 년24 월1로 변경한다.
	// 년23 월-1 을 입력하면 캘린더 내부 API가 년22 월12로 변경 한다. 
	targetYear = firstDay.get(Calendar.YEAR);
	targetMonth = firstDay.get(Calendar.MONTH);
	
	int firstYoil = firstDay.get(Calendar.DAY_OF_WEEK); // 2023 4 1일이 몇번째 요일인지 , 일요일일때1, 토요일일때7
	
	// 1일앞의 공백칸의 수
	int startBlank = firstYoil - 1; 
	System.out.println(startBlank + "<== startBlank");
	
	// 타겟달 마지막일
	int lastDate = firstDay.getActualMaximum(Calendar.DATE);
	System.out.println(lastDate + "<== lastDate");
	
	// 전체 td의 7의 나머지값은 0
	// lastDate날짜 뒤의 공백칸의 수
	int endBlank = 0;
	if((startBlank+lastDate) % 7 !=0 ){
		endBlank = 7-(startBlank+lastDate)%7;
	}
	
	// 전체 td의 개수
	int totalTd = startBlank + lastDate + endBlank;
	System.out.println(totalTd + "<== totalTd");
	
	// db data를 가져오는 알고리즘
	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
	java.sql.Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	/*
		select schedule_no scheduleNo, 
		day(Schedule_date) ScheduleDate
		substr(schedule_memo 1,5) scheduleMemo, 
		Schedule_color ScheduleColor
		from schedule
		where year(schedule_date) = ? and month(schedule_date) = ?
		order by  day(schedule_date) asc; 		
	*/
	PreparedStatement stmt = conn.prepareStatement("select schedule_no scheduleNo, day(Schedule_date) ScheduleDate, substr(schedule_memo,1,5) scheduleMemo, Schedule_color ScheduleColor from schedule where year(schedule_date) = ? and month(schedule_date) = ? order by  day(schedule_date) asc");
		
		
	stmt.setInt(1,targetYear);
	stmt.setInt(2,targetMonth + 1);
	System.out.println(stmt + " <--stmt");
		
	//출력할 공지 데이터
	ResultSet rs = stmt.executeQuery();
	
	//rs를 ArrayList<Schedule>
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
		while(rs.next()){
			Schedule s = new Schedule();
			s.scheduleNo = rs.getInt("ScheduleNo");
			s.scheduleDate = rs.getString("ScheduleDate"); //전체 날짜가 아닌 일 데이터만 들어있음
			s.scheduleMemo = rs.getString("ScheduleMemo"); //전체가 아닌 5글자만 들어있음
			s.scheduleColor = rs.getString("ScheduleColor");
			scheduleList.add(s);
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
	table, td{
		border:  1px solid #000000;
	}
	h1{
		text-align: center;
	}
</style>
</head>
<body>
	<div> <!-- 메인메뉴 -->
		<a href="./form.jsp" class="btn btn-secondary">홈으로</a>
		<a href="./noticeList.jsp" class="btn btn-secondary">공지 리스트</a>
		<a href="./scheduleList.jsp" class="btn btn-secondary">일정 리스트</a>
	</div>
	
	<h1><%=targetYear%>년 <%=targetMonth+1%>월 </h1>
	<div>
		<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth-1%>" class="btn btn-secondary">이전달</a>
		<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth+1%>" class="btn btn-secondary" style="float: right;">다음달</a>
	</div>
	<table style="width: 100%;" class="table-bordered">
		<tr>
			<%
				for(int i=0; i<totalTd; i+=1){
					int num = i-startBlank+1;
					
					if(i !=0 && i%7==0){			
			%>
					</tr><tr>
			<%		
					}
					String tdStyle = "";
					if(num>0 && num<=lastDate){
						//오늘 날짜이면
						if(today.get(Calendar.YEAR) == targetYear && 
							today.get(Calendar.MONTH) == targetMonth
							&& today.get(Calendar.DATE) == num){
							tdStyle = "background-color:orange;";		
						}else{
							tdStyle="";			
						}
			%>			
						<td style="<%=tdStyle%>">
							<div> <!-- 날짜 숫자 -->
								<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=num%>"><%=num%></a>
							</div>
							<div> <!-- 일정 memo(5글자만) -->
								<%
									for(Schedule s : scheduleList) {
										if(num == Integer.parseInt(s.scheduleDate)){
								%>
									<div style="color: <%=s.scheduleColor%>"><%=s.scheduleMemo %></div>
								<%			
										}	
									} //for닫힘
								%>
							</div>
						</td>
			<%		
					}else{
			%>
					<td>&nbsp;</td>
			<%			
					}
				}
			%>
		</tr>
	</table>
</body>
</html>