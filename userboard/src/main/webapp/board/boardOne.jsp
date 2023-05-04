<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %> 
<%
	//요청값 검사
	if(request.getParameter("boardNo") == null
		|| request.getParameter("boardNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	
	}
	System.out.println(request.getParameter("boardNo") + "<--불러온 boardNo");
	
	//불러온 값 저장하기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
 		currentPage = Integer.parseInt(request.getParameter("currentPage"));
 	}
 	System.out.println(currentPage + "<--currentPage값");
 	
	int rowPerPage = 10;  
	int startRow = (currentPage - 1)*rowPerPage;
	
	int totalRow = 0;
	
	//모델링 설정 시작점
	//디비 연결하기
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//상세리스트 모델링 하기
	// boardOne 결과셋
	PreparedStatement boardDetailStmt = null;
	ResultSet boardDetailRs = null;
	String boardDetailsql="";
	/* select board_no boardNo, local_name localName, board_title boardTitle, board_content boardContent, member_id memberId, createdate, updatedate 
	from board where board_no = ? */
	boardDetailsql= "select board_no boardNo, local_name localName, board_title boardTitle, board_content boardContent, member_id memberId, createdate, updatedate from board where board_no = ? ";
	boardDetailStmt = conn.prepareStatement(boardDetailsql);
	boardDetailStmt.setInt(1,boardNo);
	boardDetailRs = boardDetailStmt.executeQuery(); //row ->1
	
	//디버깅
	System.out.println(boardDetailStmt + "<--boardDetailStmt");
	
	SubList subList = null;
	if(boardDetailRs.next()){
		subList = new SubList();
		subList.boardNo = boardDetailRs.getInt("boardNo"); 
		subList.localName = boardDetailRs.getString("localName"); 
		subList.boardTitle = boardDetailRs.getString("boardTitle"); 
		subList.boardContent = boardDetailRs.getString("boardContent"); 
		subList.memberId = boardDetailRs.getString("memberId"); 
		subList.createdate = boardDetailRs.getString("createdate"); 
		subList.updatedate = boardDetailRs.getString("updatedate"); 
	}
	
	//comment list 결과셋
	/* SELECT comment_no, board_no, comment_content
	FROM comment
	WHERE board_no = 1000;
	LIMIT 0, 10; */ 
	PreparedStatement commentListStmt = null;
	ResultSet commentListRs = null;
	//수정해야함
	String commentListSql="SELECT comment_no commentNo, board_no boardNo, comment_content commentContent, member_id memberId, createdate, updatedate FROM comment WHERE board_no = ? ORDER BY createdate DESC LIMIT ?,?";
	commentListStmt = conn.prepareStatement(commentListSql);
	commentListStmt.setInt(1, boardNo);
	commentListStmt.setInt(2, startRow);
	commentListStmt.setInt(3, rowPerPage);
	commentListRs = commentListStmt.executeQuery(); //row -> 최대10
	
	//디버깅
	System.out.println(commentListStmt + "<--commentListStmt");
	ArrayList<Comment> commentList = new ArrayList<Comment>();
	while(commentListRs.next()){
		Comment c = new Comment(); 
		c.commentNo = commentListRs.getInt("commentNo");
		c.boardNo = commentListRs.getInt("boardNo");
		c.commentContent = commentListRs.getString("commentContent");
		c.memberId = commentListRs.getString("memberId");
		c.createdate = commentListRs.getString("createdate");
		c.updatedate = commentListRs.getString("updatedate");
		commentList.add(c);
	}
	
	//pageCnt 쿼리문
	PreparedStatement pageCntstmt = null;
	ResultSet pageCntRs = null;
	String pageCntsql = "SELECT local_name, count(*) from board WHERE board_no = ?";
	pageCntstmt = conn.prepareStatement(pageCntsql);
	pageCntstmt.setInt(1, boardNo);
	pageCntRs = pageCntstmt.executeQuery();
	if(pageCntRs.next()){
		totalRow = pageCntRs.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	
%>     
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.wrap{
			width: 1280px;
			margin: 0 auto;
			background-color: #F6F6F6;
		}
		table, td {
			border-bottom: 1px solid #BDBDBD;
			border-collapse: collapse;
		}
		table{
			width: 800px;
			height: 400px;
			margin: 0 auto;
			text-align: center;
		}
		a{
			text-decoration: none;
			color: #000000;
			border: 1px solid #000000;
		}
		h1{
			text-align: center;
			margin-right: 500px;
			margin-bottom: 30px;
			padding-top: 30px;
		}
		.title{
			width: 30%;
			font-weight: bold;
		}
		.button{
			float: right;
		}
	</style>
</head>
<body>
<div class="wrap">
<h1>게시글 상세설명</h1>
	<table>
			<tr>
				<td class="title">boardNo</td>
				<td><%=subList.boardNo %></td>
			</tr>
			
			<tr>
				<td class="title">localName</td>
				<td><%=subList.localName%></td>
			</tr>
			
			<tr>
				<td class="title">boardTitle</td>
				<td><%=subList.boardTitle %></td>
			</tr>
			
			<tr>
				<td class="title">boardContent</td>
				<td><%=subList.boardContent %></td>
			</tr>
			
			<tr>
				<td class="title">memberId</td>
				<td><%=subList.memberId%></td>
			</tr>
			
			<tr>
				<td class="title">createdate</td>
				<td><%=subList.createdate %></td>
			</tr>
			<tr>
				<td class="title">updatedate</td>
				<td><%=subList.updatedate %></td>
			</tr>
	</table>
	<div class="button">
		<a href = "">수정</a>
		<a href = "">삭제</a>
	</div>
	<!-- comment 입력 : 세션유무에 따른 분기 -->
	<%
		//로그인 사용자만 댓글 입력 허용
		if(session.getAttribute("loginMemberId") != null){
			//현재 로그인 사용자의 아이디
			String loginMemberId = (String)session.getAttribute("loginMemberId");
	%>		
		<div>
			<form action="<%=request.getContextPath()%>/board/insertCommentAction.jsp">
				<input type="hidden" name="boardNo" value="<%=subList.boardNo%>">
				<input type="hidden" name="memberId" value="<%=loginMemberId%>">
				<table>
					<tr>
						<th>commentContent</th>
						<td>
							<textarea rows="2" cols="80" name="commentContent"></textarea>
						</td>
					</tr>
				</table>
				<button type="submit">댓글입력</button>
			</form>
		</div>
	<%		
		}
	%>
	
	<!-- comment list 결과셋 -->
	<table>
		<tr>
			<th>commentContent</th>
			<th>memberId</th>
			<th>creatdate</th>
			<th>updatedate</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
		  for(Comment c : commentList){
		%>
			<tr>
				<td><%=c.commentContent%></td>
				<td><%=c.memberId%></td>
				<td><%=c.createdate%></td>
				<td><%=c.updatedate%></td>
				<td>
					<a href="">수정</a>
				</td>
				<td>
					<a href="">삭제</a>
				</td>
			</tr>
		<%	  
		  }
		%>
	</table>
	
	<div>
		<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>&currentPage=<%=currentPage - 1%>">이전</a>
		<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>&currentPage=<%=currentPage + 1%>">다음</a>
	</div>
</div>	
</body>
</html>