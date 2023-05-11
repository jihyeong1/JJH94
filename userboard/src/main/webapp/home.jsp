<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>  
 <%
	// 요청분석(컨트롤러 계층)
	// 1.세션 session JSP내장(기본)객체
	// 2. request / response
	int currentPage = 1;
 	if(request.getParameter("currentPage") != null){
 		currentPage = Integer.parseInt(request.getParameter("currentPage"));
 	}
 	System.out.println(currentPage + "<--currentPage값");
 	
 	//출력 행 설정
 	int rowPerPage = 10;
 	int startRow = (currentPage - 1) * rowPerPage;
 	
 	int totalRow = 0;
 	
 	//localName의 초기화설정
	String localName = "전체"; //기본값을 "전체"로 설정
	if(request.getParameter("localName") != null){ //전체값이 들어오지않았을 때
		localName = request.getParameter("localName"); //localName에 값 저장
	}
	System.out.println(localName + "<--localName");
	
	// 모델 계층
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	PreparedStatement subMenuStmt = null;
	ResultSet subMenuRs = null;
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	//subMenuList 쿼리문 만들기
	/* SELECT '전체' localName,COUNT(local_name) cnt FROM board
	UNION all
	SELECT local_name, COUNT(local_name) FROM board group BY local_name; */
	String subMenuSql = "SELECT '전체' localName,COUNT(local_name) cnt FROM board UNION all SELECT local_name, COUNT(local_name) FROM board group BY local_name";
	subMenuStmt = conn.prepareStatement(subMenuSql);
	subMenuRs = subMenuStmt.executeQuery();
	
	//subMenuList <-- 모델데이터
	ArrayList<HashMap<String, Object>> subMenuList = new ArrayList<HashMap<String, Object>>();
	while(subMenuRs.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("localName", subMenuRs.getString("localName"));
		m.put("cnt", subMenuRs.getInt("cnt"));
		subMenuList.add(m);					
	}
	
	//subMenuBoard 쿼리문 만들기
	/* SELECT local_name, board_title, SUBSTRING(board_content, 1, 11) FROM board; */
	PreparedStatement subMenuBoardStmt = null;
	ResultSet subMenuBoardRs = null;
	String subMenuBoard = "SELECT board_no boardNo, local_name localName, board_title boardTitle, SUBSTRING(board_content, 1, 11) boardContent, createdate FROM board";
	String subMenuAddSql = " WHERE local_name = ?";
	if(!localName.equals("전체")){
		subMenuBoard += subMenuAddSql + " LIMIT ?, ?"; //전체 값이 설정되지않았을 때 sql문 합치기
		subMenuBoardStmt = conn.prepareStatement(subMenuBoard);
		subMenuBoardStmt.setString(1, localName);
		subMenuBoardStmt.setInt(2, startRow);
		subMenuBoardStmt.setInt(3, rowPerPage);
	} else {
		subMenuBoard += " LIMIT ?, ?";
		subMenuBoardStmt = conn.prepareStatement(subMenuBoard);
		subMenuBoardStmt.setInt(1, startRow);
		subMenuBoardStmt.setInt(2, rowPerPage);
	}		
	
	subMenuBoardRs = subMenuBoardStmt.executeQuery(); //DB쿼리 결과셋 모델
	
	//디버깅
	System.out.println(subMenuBoardStmt + "<-- subMenuBoardStmt");
	
	//subMenuBoard <-- 모델데이터
	ArrayList<SubList> subList = new ArrayList<SubList>();
	while(subMenuBoardRs.next()){
		SubList s = new SubList();
		s.setBoardNo(subMenuBoardRs.getInt("boardNo"));
		s.setLocalName(subMenuBoardRs.getString("localName"));
		s.setBoardTitle(subMenuBoardRs.getString("boardTitle"));
		s.setBoardContent(subMenuBoardRs.getString("boardContent"));
		s.setCreatedate(subMenuBoardRs.getString("createdate"));
		subList.add(s);
	}
	
	//pageCnt 쿼리문
	PreparedStatement pageCntstmt = null;
	ResultSet pageCntRs = null;
	String pageCntsql = "";
	String pageCntAddsql = "";
	pageCntsql = "SELECT local_name, count(*) from board";
	pageCntAddsql = " WHERE local_name = ?";
	//if문으로 분기
	if(localName.equals("전체")
		|| localName == null || localName.equals("")){
		pageCntstmt = conn.prepareStatement(pageCntsql);
	}else{
		pageCntsql += pageCntAddsql;
		pageCntstmt = conn.prepareStatement(pageCntsql);
		pageCntstmt.setString(1, localName);
	}
	pageCntRs = pageCntstmt.executeQuery();
	
	System.out.println(pageCntstmt + "<--pageCntstmt");
	
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
			background-color: #EAEAEA;
		}
		li{
			list-style: none;
		}
		a{
			text-decoration: none;
			color:#000000;
		}
		.mainmenu{
			position: absolute;
		}
		.submenulist{
			display: flex;
			justify-content: space-between;
			padding-top: 20px;
			padding-top: 80px;
			font-size: 18px;
			line-height: 2;
		}
		.submenulistleft h3{
			font-size: 20px;
			padding-left: 30px;
		}
		.submenulistleft{
			border: 1px solid #BDBDBD;
			border-radius: 10px;
			padding: 10px 25px 10px 10px;
			margin-left: 70px;
			background-color: #F6F6F6;
		}
		.submenulistright{
			margin-right: 40px;
		}
		.submenulistright table{
			border-collapse: collapse;
			border-radius: 10px;
			background-color: #F6F6F6;
		}
		table, th, td {
		border: 1px solid #BDBDBD;
		}
		.sublist table{
			border-collapse: collapse;
			margin: 0 auto;
			margin-top: 20px;
			width: 1250px;
			line-height: 2;
			text-align: center;
		}
		.sublist table th{
			background-color: #FFFFFF;
		}
		.cate{
			background-color: gray;
			padding: 5px;
			border-radius: 10px;
			margin-left: 28px;
			font-size: 15px;
		}
	</style>
</head>
<body>
<div class="wrap">
	<!-- 메인 메뉴(가로) -->
	<div class="mainmenu">
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<!-- 서브메뉴(세로) subMenuList모델 출력 -->
	<div class="submenulist">
		<div class="submenulistleft">
			<h3>* 카테고리 *</h3>
			<ul>
				<%
					for(HashMap<String, Object> m : subMenuList){
				%>
						<li>
							<a href="<%=request.getContextPath()%>/home.jsp?localName=<%=(String)m.get("localName")%>">
								<%=(String)m.get("localName")%>(<%=(Integer)m.get("cnt")%>)
							</a>
						</li>	
				<%
					}
				%>
			</ul>
			<a href="<%=request.getContextPath()%>/member/categoryForm.jsp" class="cate">카테고리 관리</a>
		</div>
		<div>
			<img alt="d" src="./img/trip.jpg" style="width:700px; height: 550px; margin-top: 5px;">
		</div>
		<div class="submenulistright">
			<!-- home 내용 : 로그인폼/ 카테고리별 게시글 5개씩  -->
			<!-- 로그인 폼 -->
			<%
				if(session.getAttribute("loginMemberId")==null){
					//로그인전이면 로그인폼출력
			%>
				<form action="<%=request.getContextPath()%>/member/loginAction.jsp" method="post">
					<table>
						<tr>
							<td>아이디</td>
							<td>
								<input type="text" name="memberId">
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="password" name="memberPw">	
							</td>
						</tr>
					</table>
					<button type="submit">로그인</button>
				</form>
			<%		
				}
			%>
		</div>
	</div>
	
	<!-- 카테고리 별 내용 출력 -->
	<div class="sublist">
		<table>
			<tr>
				<th>localName</th>
				<th>boardTitle</th>
				<th>boardContent</th>
				<th>createdate</th>
			</tr>
			<%
				for(SubList s : subList){
			%>
					<tr>
						<td><%=s.getLocalName() %></td>
						<td>
							<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=s.getBoardNo()%>">
								<%=s.getBoardTitle() %>
							</a>
						</td>
						<td><%=s.getBoardContent().substring(1, 11) %></td>
						<td><%=s.getCreatedate() %></td>
					</tr>
			<%		
				}
			%>
		</table>	
	</div>
	<!-- 페이징 설정 -->
	<div>
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=currentPage - 1%>&localName=<%=localName%>">이전</a>
		<%		
			}
		%>
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=currentPage + 1%>&localName=<%=localName%>">다음</a>
		<%		
			}
		%>
	</div>
	
	<div>
		<!-- include 페이지 : Copyright &copy; 구디아카데미 -->
		<jsp:include page="/inc/copyright.jsp"></jsp:include>
	</div>
</div>	
</body>
</html>