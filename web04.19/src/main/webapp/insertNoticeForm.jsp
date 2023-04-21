<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div> <!-- 메인메뉴 -->
		<a href="./form.jsp">홈으로</a>
		<a href="./noticeList.jsp">공지 리스트</a>
		<a href="./diaryList.jsp">일정 리스트</a>
	</div>
	<form action="./insertNoticeAction.jsp" method="post">
		<table>
         <tr>
            <td>notice_title</td>
            <td>
               <input type="text" name="noticeTitle">
            </td>
         </tr>
         <tr>
            <td>notice_content</td>
            <td>
               <textarea rows="5" cols="80" name="noticeContent"></textarea>
            </td>
         </tr>
         <tr>
            <td>notice_writer</td>
            <td>
               <input type="text" name="noticeWriter">
            </td>
         </tr>
         <tr>
            <td>notice_pw</td>
            <td>
               <input type="password" name="noticePw">
            </td>
         </tr>
         <tr>
            <td colspan="2">
               <button type="submit">입력</button>
            </td>
            <!-- <td></td> -->
         </tr>
      </table>  
     </form> 
</body>
</html>