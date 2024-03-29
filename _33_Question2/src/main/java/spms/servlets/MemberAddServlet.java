package spms.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		ResultSet rs = null;			// Select문의 결과
		PreparedStatement stmt = null; 
		
		try {
			ServletContext sc = this.getServletContext();
			Class.forName(sc.getInitParameter("driver"));
			conn = DriverManager.getConnection(
					sc.getInitParameter("url"),	// JDBC url
					sc.getInitParameter("username"),								// id
					sc.getInitParameter("password"));

			stmt = conn.prepareStatement(
					"INSERT INTO members(email,pwd,mname,cre_date,mod_date)" + 
					" VALUES(?,?,?,NOW(),NOW())"
					);
			stmt.setString(1,  req.getParameter("email"));
			stmt.setString(2,  req.getParameter("password"));
			stmt.setString(3,  req.getParameter("name"));
			stmt.executeUpdate();
			
			// MemberListServlet객체에서 MemberList.jsp로 
			// request객체와 response객체를 전달한다.
			RequestDispatcher rd = req.getRequestDispatcher(
						"/member/MemberForm.jsp");
			
			resp.setContentType("text/html;charset=UTF-8");
			
			// include방식으로 전달한다.
			rd.include(req, resp);
		}catch(Exception e) {
			req.setAttribute("error", e);
			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
			rd.forward(req, resp);
		}finally {
			//try {if(rs!=null) rs.close();} catch(Exception e) {} // 내가 추가함
			try {if(stmt!=null) stmt.close();} catch(Exception e) {} // tutor
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
		}
	}
}