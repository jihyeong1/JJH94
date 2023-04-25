<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//값이 잘 넘어왔는지 디버깅
	System.out.println(request.getParameter("scheduleNo")+ "<==넘어온 scheduleNo");

	//요청값 유효성 검사
	if(request.getParameter("scheduleNo")==null){
		response.sendRedirect("./scheduleListByDate.jsp");
	}
	
	//scheduleNo 값 불러오기
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./deleteScheduleAction.jsp" method="post">
		<h1>스케줄 삭제</h1>
		<div>
			<%
				if(request.getParameter("msg1") != null){
			%>
					<%=request.getAttribute("msg1") %>
			<%		
				}
			%>
		</div>
		<table>
			<tr>
				<th>schedule_no</th>
				<td>
					<input type="hidden" name="y" value="<%=y%>" readonly="readonly">
					<input type="hidden" name="m" value="<%=m%>" readonly="readonly">
					<input type="hidden" name="d" value="<%=d%>" readonly="readonly">
					<input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>schedule_pw</th>
				<td>
					<input type="password" name="schedulePw">
				</td>
			</tr>
		</table>
		<button type="submit">삭제</button>
	</form>
</body>
</html>