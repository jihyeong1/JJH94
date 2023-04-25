<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   
<%
	// 일단 인코등 처리를 하자.
	request.setCharacterEncoding("utf-8");
	

	// 입력값이 들어왔을 때 null값이거나 공백인지 확인하자.
	if(
		request.getParameter("noticePw")==null
		|| request.getParameter("noticeTitle")==null
		|| request.getParameter("noticeContent")==null
		|| request.getParameter("noticePw").equals("")
		|| request.getParameter("noticeTitle").equals("")
		|| request.getParameter("noticeContent").equals("")
		){
			int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
			response.sendRedirect("./updateNoticeForm.jsp?noticeNo="+noticeNo);
			
			// 틀리면 어느페이지로 갈지 설정
			return;
	}
	
	// 값을 불러와서 저장할 수 있는 공간을 만들자. 변수에 값 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	//DB를 연결하자.
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		
	//테이블에 수정할 데이터를 전송하는 sql 만들자.
	String send = "update notice set notice_title=?, notice_content=?, updatedate=now() where notice_no=? and notice_pw=?";
	// update를 할때 변경될 부분이 앞으로 오고 where절을 넣어서 해당 값들이 맞는지 확인 후에 수정할 수 있도록 해야한다.
	PreparedStatement stmt = conn.prepareStatement(send);
	stmt.setString(1, noticeTitle);
	stmt.setString(2, noticeContent);
	stmt.setInt(3, noticeNo);
	stmt.setString(4, noticePw);
	// 물음표의 순서에 맞게 번호를 매겨야함
	
	//디버깅으로 확인하기
	System.out.println(stmt + "<-- stmt 잘갔나?");
	
	
	// row 는 sql 문이 성공했는지 안했는지 알아보는 것
	int row = stmt.executeUpdate();
	System.out.println(row);
	
	// sql문이 틀리거나 성공했으면 어디로 갈지 설정
	if(row==0){
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo="+noticeNo);
	}else{
		response.sendRedirect("./noticeOne.jsp?noticeNo="+noticeNo);
		//성공하면 어느페이지로 갈지 설정
	}
	
%>