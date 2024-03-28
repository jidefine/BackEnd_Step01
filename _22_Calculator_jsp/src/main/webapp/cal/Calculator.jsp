<!-- page 지시자
원래 jsp를 다른 언러로 지원하려고 하였으나, 워낙 기술의 빠른 발달로 다른 web 방식도 나오니까
그냥 jsp는 java로 변환된다는 약속이다 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Model One 방식 
Java코드(Controller, Dao) + html코드가 함께 있는 코딩 방식

->나중에 java코드의 Controller는 Servlet으로, DB/Query는 java클래스로 만들고
jsp는 주로 View 역할(html)만 담당

지금은 jsp를 설명하기 위해 java코드를 넣었다
- 1) jsp도 서블릿이기 때문에 (즉, java) java 코드가 동작한다.
- 2) html과 java는 서로 다른 영역의 언어이다
	그런데 우리는 html에 DB로 부터 가져온 변수값들을 html에 넣어서 전송해야 할 필요가 있다.
	그런데 그냥 java 코드를 html에 바로 넣는 것은 불가능하다
	그래서 jsp는 java의 변수를 html에 삽입하는 방법을 제공한다.
	나중에는 주로 EL과 jstl은 표현식이기 때문에 간결하게 표현되어진다
	
	스프링 부트는 jsp도 사용가능하지만 타임리프를 사용함
-->

<%
/*스크립트릿: java 코드를 넣을 수 있음 
- service() 함수 안에 들어감*/
String v1 = "";
String v2 = "";
String result = "";
String[] selected = {"", "", "", ""};

//request는 jsp가 java로 변환되어 _jspService() 영역으로 들어가면
//브라우저의 요청이 담긴 객체 이름이다
if(request.getParameter("v1") != null){
	v1 = request.getParameter("v1");
	v2 = request.getParameter("v2");
	String op = request.getParameter("op");
	
	result = calculate(Double.parseDouble(v1), Integer.parseInt(v2), op);
	
	if("+".equals(op))
		selected[0] = "selected";
	else if("-".equals(op))
		selected[1] = "selected";
	else if("*".equals(op))
		selected[2] = "selected";
	else if("/".equals(op))
		selected[3] = "selected";	
}
%>    

<!-- 템플릿 데이터: 브라우저에 표현되어지는 html코드 -->
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>계산기</title>
</head>
<body>
	<h2>JSP 계산기</h2>
	<form action="Calculator.jsp" method="get">
		<input type="text" name="v1" size="4" value="<%=v1 %>">
		<select name="op">
			<option value="+" <%=selected[0] %>>+</option>
			<option value="-" <%=selected[1] %>>-</option>
			<option value="*" <%=selected[2] %>>*</option>
			<option value="/" <%=selected[3] %>>/</option>
		</select>
		<input type="text" name="v2" size="4" value="<%=v2 %>">
		<input type="submit" value="=">
		<input type="text" size="8" value="<%=result %>"><br>
	</form>
</body>
</html>

<%!
/*
jsp 선언문
메서드나 필드를 선언할 대 이렇게 하면 Calculator jsp 클래스의 멤버가 된다
*/
private String calculate(double a, double b, String op){
	double result = 0;
	
	if("+".equals(op)) result = a + b;
	else if("-".equals(op)) result = a - b;
	else if("*".equals(op)) result = a * b;
	else if("/".equals(op)) result = a / b;
	
	return Double.toString(result);	
}
%>