package spms.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

@SuppressWarnings("serial")
public class AppInitServlet extends HttpServlet{

	@Override
	public void init() throws ServletException {
		System.out.println("AppInitServlet::init() 호출");
	}
	
	@Override
	public void destroy() {
		System.out.println("AppInitServlet::destroy() 호출");
	}
}