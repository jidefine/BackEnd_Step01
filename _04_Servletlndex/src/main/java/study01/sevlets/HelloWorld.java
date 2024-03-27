package study01.sevlets;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class HelloWorld implements Servlet {
/* tomcat에 실행될 때 자동을 서비스에 참여하는 '서블릭 객체'가 되기 위해서는 
 * 1)Servlet 인터페이스를 상속 받아야 한다.
 * 2) @webSㄷㅅ
 * 
 */
	
	ServletConfig config;
	/*톰캣이 종료될 때*/
	@Override
	public void destroy() {
		System.out.println("destry() 호출");

	}
	/*톰캣은 서블릿 객체와 연결된 주로로 요청이 들어옴
	 * 그때 해당 객체를 생성한다.
	 * 객체 생성 시 호출되는 메서드는 init()*/
	@Override
	public ServletConfig getServletConfig() {
		System.out.println("getServletCon() 호출");
	}
	/*서블릿 */
	@Override
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void init(ServletConfig arg0) throws ServletException {
		System.out.println("init() 호출");

	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
