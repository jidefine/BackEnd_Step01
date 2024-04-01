package spms.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import spms.dao.MemberDao;
import spms.vo.Member;

@WebServlet("/member/add")
@SuppressWarnings("serial")
public class MemberAddServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberAddServlet::doGet() 호출");
		RequestDispatcher rd = req.getRequestDispatcher("/member/MemberForm.jsp");
		rd.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberAddServlet::doPost() 호출");
		
		Connection conn = null;			// DB 서버와의 연결 객체
		PreparedStatement stmt = null; 
		
		try {
			ServletContext sc = this.getServletContext();
			conn = (Connection) sc.getAttribute("conn"); //tutor
			
			// 추가 부분 ~
			//Member member = new Member();

			//member.setEmail(req.getParameter("email"));
			//member.setPassword(req.getParameter("password"));
			//member.setName(req.getParameter("name"));
			
			MemberDao memberDao = new MemberDao();
			//memberDao.insert(member);// ~ 추가 부분
			
			memberDao.setConnection(conn);  //tutor~
		      
		    memberDao.insert(new Member()
		       .setEmail(req.getParameter("email"))
		       .setPassword(req.getParameter("password"))
		       .setName(req.getParameter("name")));
			
		    resp.sendRedirect("list");  //~tutor
		    
			RequestDispatcher rd = req.getRequestDispatcher(
						"/member/MemberForm.jsp");
			
			resp.setContentType("text/html;charset=UTF-8");
			
			// include방식으로 전달한다.
			rd.include(req, resp);
		}catch(Exception e) {
			e.printStackTrace();
			req.setAttribute("error", e);
			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
			rd.forward(req, resp);
		}finally {
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
			//
			//try {if(conn!=null) conn.close();} catch(Exception e) {}
		}
	}
}