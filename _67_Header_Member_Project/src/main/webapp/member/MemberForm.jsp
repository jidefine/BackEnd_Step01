<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="spms.vo.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
</head>
<body>
	<jsp:include page="/Header.jsp" />
	<jsp:useBean id="member"
			scope="session"
			class="spms.vo.Member" />
	<% if(member.getEmail() == null) { %>
	
	<h1>회원 등록</h1>
	<form action='add.do' method='post'>
		이름 : <input type='text' name='name'><br>
		이메일 : <input type='text' name='email'><br>
		암호 : <input type='text' name='password'><br>
		<input type='submit' value='추가'>
		<input type='reset' value='취소'>
	</form>
	<jsp:include page="/Tail.jsp" />
	<% } %>
</body>
</html>