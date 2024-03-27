package study01.sevlets;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class HelloWorld extends GenericServlet{
	
	@Override
	public void service(ServletRequset req, ServletResponse res) throws Servlet{
		System.out.println("service() 호출");
	}
}