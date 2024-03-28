package spms.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class MemberUpdateServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName(this.getInitParameter("driver"));
			conn = DriverManager.getConnection(
					this.getInitParameter("url"),
					this.getInitParameter("username"),
					this.getInitParameter("password")
					);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(
					"SELECT mno, email, mname, cre_date FROM members"+
					"WHRERE mno='" + req.getParameter("no")+"'"
					);
			
			//
			
			rs.next();
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<html><head><title>회원정보</title></head>");
			out.println("<body><h1>회원정보</h1>");
			out.println("<from action='update' method='post'>");
			out.println("번호: ,input type='text' name='no' value='" +
						req.getParameter("no")+ "'readonly><br>" );
			out.println("이름: <input type='text' name='name'" +
					" value='" + rs.getString("mname") + "'><br>");
			out.println("이메일: <input type='text' name='email'" + 
						" value='" + rs.getString("email") + "'><br>");
			out.println("가입일: " + rs.getDate("CRE_DATE") + "<br>");
			out.println("<input type='submit' value='저장'");
			out.println("<input type='button' value='취소'" + 
						" onclick='location.href=\"list\"'>");
			out.println("</form>");
			
			out.println("</body></html>");
		}catch(Exception e) {
			throw new ServletException(e);
		}finally {
			try {if(rs!=null) rs.close();} catch(Exception e) {}
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
			try {if(conn!=null) conn.close();} catch(Exception e) {}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//한글이 깨지지 않게
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			Class.forName(this.getInitParameter("driver"));
			conn = DriverManager.getConnection(
					this.getInitParameter("url"),
					this.getInitParameter("username"),
					this.getInitParameter("password")
					);
			stmt = conn.prepareStatement("UPDATE members SET email=?, mname=?, mod_date=NOW()" 
					+ " WHERE mno=?");
			//컴파일 : 데이터베이스에 최적화된 상태로 데이터를 보냄?
			stmt.setString(1, req.getParameter("email"));
			stmt.setString(2,  req.getParameter("name"));
			stmt.setInt(3,  Integer.parseInt(req.getParameter("no")));
			stmt.executeUpdate();
			
			resp.sendRedirect("list");
		}catch(Exception e) {
			throw new ServletException(e);
		}finally {
			try {if(stmt!=null) stmt.close();} catch(Exception e) {}
			try {if(conn!=null) conn.close();} catch(Exception e) {}
		}
	}
}
