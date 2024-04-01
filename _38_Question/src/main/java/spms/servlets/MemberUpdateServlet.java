package spms.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import spms.dao.MemberDao;
import spms.vo.Member;

@WebServlet("/member/update")
@SuppressWarnings("serial")
public class MemberUpdateServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberUpdateServlet::doGet() 호출");
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			ServletContext sc = this.getServletContext();
			conn = (Connection) sc.getAttribute("conn"); //tutor
			/*Class.forName(sc.getInitParameter("driver"));
			conn = DriverManager.getConnection(
						sc.getInitParameter("url"),
						sc.getInitParameter("username"),
						sc.getInitParameter("password")
					);
			stmt = conn.createStatement();
			
			// 추가 부분 ~
			Member member = new Member();
			member.getNo();*/
						
			MemberDao memberDao = new MemberDao(); // 추가 부분~
			memberDao.setConnection(conn); //tutor
			
		    Member member = memberDao.selectOne(
		 	         Integer.parseInt(req.getParameter("no")));

			req.setAttribute("member", member);
			
			RequestDispatcher rd = req.getRequestDispatcher(
					"/member/MemberUpdateForm.jsp"); 
			rd.forward(req, resp);			
			
			/*
			rs.next();
			
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<html><head><title>회원정보</title></head>");
			out.println("<body><h1>회원정보</h1>");
			out.println("<form action='update' method='post'>");
			out.println("번호: <input type='text' name='no' value='" + 
						req.getParameter("no") + "' readonly><br>");
			out.println("이름: <input type='text' name='name'" +
						" value='" + rs.getString("mname") + "'><br>");
			out.println("이메일: <input type='text' name='email'" + 
						" value='" + rs.getString("email") + "'><br>");
			out.println("가입일: " + rs.getDate("CRE_DATE") + "<br>");
			out.println("<input type='submit' value='저장'>");
			out.println("<input type='button' value='삭제' "
					+ "onclick='location.href=\"delete?no=" + 
					req.getParameter("no") + "\";'>");
			out.println("<input type='button' value='취소'" + 
				" onclick='location.href=\"list\"'>");
			out.println("</form>");
			out.println("</body></html>");
			*/
		}catch(Exception e) {
			//throw new ServletException(e);
			e.printStackTrace();
			req.setAttribute("error", e);
			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
			rd.forward(req, resp);
		}finally {
			try {if(rs!=null) rs.close();} catch(Exception e) {}
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
			//try {if(conn!=null) conn.close();} catch(Exception e) {}			
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberUpdateServlet::doPost() 호출");
		
		// CharacterEncodingFilter로 전처리 했으므로 이제 안해도 됨
		//req.setCharacterEncoding("UTF-8");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			ServletContext sc = this.getServletContext();
			conn = (Connection) sc.getAttribute("conn"); //tutor
			/*conn = DriverManager.getConnection(
						sc.getInitParameter("url"),
						sc.getInitParameter("username"),
						sc.getInitParameter("password")
					);
			
			// 추가 부분 ~
			Member member = new Member();
			member.setEmail(req.getParameter("email"));
			member.setPassword(req.getParameter("password"));
			member.setName(req.getParameter("name"));*/
									
			MemberDao memberDao = new MemberDao();
			/*memberDao.update(member);*/
			// ~ 추가 부분
			memberDao.setConnection(conn);//tutor
	         
		    memberDao.update(new Member()
				     .setNo(Integer.parseInt(req.getParameter("no")))//tutor
				     .setName(req.getParameter("name"))//tutor
				     .setEmail(req.getParameter("email")));	//tutor
			
			resp.sendRedirect("list");
			
		}catch(Exception e) {
			//throw new ServletException(e);
			e.printStackTrace();
			req.setAttribute("error", e);
			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
			rd.forward(req, resp);
		}finally {
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
			//try {if(conn!=null) conn.close();} catch(Exception e) {}
		}
	}
}