<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// post방식을 인코딩 처리
	request.setCharacterEncoding("utf-8");

	// 유효성 검사, 널값이거나 공백일때 입력폼으로 돌아가는 것
	if(request.getParameter("noticeTitle") == null
	|| request.getParameter("noticeContent") == null
	|| request.getParameter("noticeWriter") == null
	|| request.getParameter("noticePw") == null
	|| request.getParameter("noticeTitle").equals("")
	|| request.getParameter("noticeContent").equals("")
	|| request.getParameter("noticeWriter").equals("")
	|| request.getParameter("noticePw").equals("")
	){
		response.sendRedirect("./insertNoticeForm.jsp");
		return;
	}

	// 변수에 값저장
	String noticeTitle=request.getParameter("noticeTitle");
	String noticeContent=request.getParameter("noticeContent");
	String noticeWriter=request.getParameter("noticeWriter");
	String noticePw=request.getParameter("noticePw");
	
	   // 값들을 DB 테이블에 입력
	   /*
	      입력 폼에서 입력 받은 값을 테이블에 데이터를 추가하는 sql
	      "insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) values(?,?,?,?,now(),now())"
	   */
	   // 드라이버 로딩
	   Class.forName("org.mariadb.jdbc.Driver");
	   // DB 접속
	   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	   // noitce 테이블에 새로운 데이터를 삽입하는 sql 전송
	   String sql = "insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) values(?,?,?,?,now(),now())";
	   PreparedStatement stmt = conn.prepareStatement(sql);
	   stmt.setString(1, noticeTitle);    // 1번째 ? = noticeTitle
	   stmt.setString(2, noticeContent);    // 2번째 ? = noticeContent
	   stmt.setString(3, noticeWriter);    // 3번째 ? = noticeWriter
	   stmt.setString(4, noticePw);       // 4번째 ? = noticePw
	   int row = stmt.executeUpdate();      // 디버깅 : 1(ex:2)이면 1행(ex:2행) 입력성공, 0이면 입력된 행이 없다
	   // row값을 이용한 디버깅
	   System.out.println(row + " <--row");
	   // conn.setAutoCommit(true);         // true일 때 conn.comit() 자동으로 실행, 디폴트값 true이므로 conn.commit();생략 가능
	   // conn.commit();                   // 메모리에 저장되어있는 데이터를 최종적으로 데이터베이스에 저장
	   // sql 디버깅
	   System.out.println(stmt + " <--stmt");
	   
	   // redirection
	   response.sendRedirect("./noticeList.jsp"); // 리스트로 가라고 명령
	%>
