package study01.sevlets;

import javax.servlet.http.HttpServlet;

/*HttpServlet 추상 클래스 extend*/

public class HelloWorld extends HttpServlet{
	
	@Override
	protected void serviceHttp(HttpServletRequset req, HttpServletResponse res) throws Servlet{
		System.out.println("service() 호출");
	}// 생태주기
}