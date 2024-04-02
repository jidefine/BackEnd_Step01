package spms.servlets;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import spms.dao.MemberDao;

@SuppressWarnings("serial")
@WebServlet("/member/delete")
public class MemberDeleteServlet extends HttpServlet {

	@Override
	public void doGet(
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("MemberDeleteServlet::doGet() 호출");

		try {
//			Dao로부터 필요한 객체 생성
			ServletContext sc = this.getServletContext();
			MemberDao memberDao = (MemberDao)sc.getAttribute("memberDao"); 
			memberDao.delete(
					Integer.parseInt(request.getParameter("no")));			
			response.sendRedirect("list.do");
			
		} catch (Exception e) {
			throw new ServletException(e);
//			예외처리를 DispatchServlet에게 처리하도록 일원화하기 위해 주석 처리
//			e.printStackTrace();
//			request.setAttribute("error", e);
//			RequestDispatcher rd = request.getRequestDispatcher("/Error.jsp");
//			rd.forward(request, response);
			
		} 
		/*
		finally {
			try {if (stmt != null) stmt.close();} catch(Exception e) {}
			//try {if (conn != null) conn.close();} catch(Exception e) {}
		}
		*/
	}
}