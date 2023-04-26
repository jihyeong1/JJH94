<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		header{
			width: 1280px;
			height: 60px;
			margin: 0 auto;
			padding: 10px;
		}
		a{
			text-decoration: none;
			color: #000000;
		}
		.nav{
			width: 100%;
			display: flex;
			justify-content: space-between;
			align-items: center;
			border-bottom: 2px solid #BDBDBD;
		}
		.nav div h2{
			margin-left: 30px;
			font-size: 40px;
			line-height: 3px;
		}
		li{
			list-style: none;
			float: left;
			padding: 0px 40px 20px 20px;
			font-size: 20px;
		}	
		.content{
			width: 1280px;
			height: 600px;
			background-color: #F6F6F6;
			margin: 0 auto;
			text-align: center;
			margin-top: 50px;
			padding-top: 30px;
		}
		table{
			height: 500px;
		}
		table, td{
			width: 70%;
			margin: 0 auto;
			line-height: 2;
			margin-left: 15%;
			margin-top: 10px;
			border: 1px solid #BDBDBD;
			border-collapse: collapse;
			text-align: center;
		}
		table td.title{
			background-color: #A6A6A6;
			width: 300px;
			font-weight: bold;
			color: #FFFFFF;
			font-size: 18px;
		}
		input{
			text-align: center;
			width: 580px;
		}
		input, textarea{
			float: left;
			margin-left: 10px;
		}
		button{
			background-color: #A6A6A6; 
			padding: 10px; 
			border-radius: 10px; 
			color: #FFFFFF; 
			font-size: 20px; 
			float: right;
			margin-right: 20px;
			margin-top: 10px;
		}
	</style>
</head>
<body>
	<header>
		<div class="nav"> <!-- 메인메뉴 -->
			<div>		
				<h2><img alt="-" src="./img/notice.png" style="width: 35px;"> Add notice page</h2>
			</div>
			<div>
				<ul>
					<li>
						<a href="./form.jsp">Home</a>
					</li>
					<li>
						<a href="./noticeList.jsp">공지 리스트</a>
					</li>
					<li>
						<a href="./scheduleList.jsp">일정 리스트</a>
					</li>
				</ul>
			</div>
		</div>
	</header>
	
	<form action="./insertNoticeAction.jsp" method="post">
	<div class="content">
		<table>
         <tr>
            <td class="title">notice_title</td>
            <td>
               <input type="text" name="noticeTitle" style="height: 50px;">
            </td>
         </tr>
         <tr>
            <td class="title">notice_content</td>
            <td>
               <textarea rows="5" cols="80" name="noticeContent"></textarea>
            </td>
         </tr>
         <tr>
            <td class="title">notice_writer</td>
            <td>
               <input type="text" name="noticeWriter" style="height: 50px;">
            </td>
         </tr>
         <tr>
            <td class="title">notice_pw</td>
            <td>
               <input type="password" name="noticePw" style="width: 200px;">
            </td>
         </tr>
      </table> 
      <button type="submit">입력</button>
      </div> 
     </form> 
</body>
</html>