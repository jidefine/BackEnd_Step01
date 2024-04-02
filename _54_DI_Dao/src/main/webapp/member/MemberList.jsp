<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="spms.vo.Member" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
	<%
	//<jsp:forward page="/Forward.jsp" />
	 %>
	<jsp:include page="/Header.jsp" />

	<h1>회원 목록</h1>
	<p><a href='add.do'>신규 회원</a></p>
	
	<!-- jstl은 Apache에서 만든 확장 라이브러리

	EL은 자바 표현식을 대신해서 값을 html에 보여주고 싶을 때,
	JSTL은 반복문, 조건문 html, EL과 사용하고 싶을 때 -->
	
	<!-- for문으로 반복 -->
	<c:forEach var='member' items="${members }">
		${member.no },
		<a href='update.do?no=${member.no }'>${member.name }</a>,
		${member.email },
		${member.createdDate }
		<a href='delete.do?no=${member.no }'>[삭제]</a><br>
	</c:forEach>
	
	<jsp:include page="/Tail.jsp" />
</body>
</html>