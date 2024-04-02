package spms.servlets;

import java.io.IOException;

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
		
		try {
//			Dao로부터 필요한 객체 생성
			ServletContext sc = this.getServletContext();
			MemberDao memberDao = (MemberDao)sc.getAttribute("memberDao");	
			Member member = memberDao.selectOne(
			          Integer.parseInt(req.getParameter("no")));
			req.setAttribute("member", member); //MemberUpdateForm.jsp에 전달하기 위한 용도
			
//			jsp 이동을 위한 jsp 페이지 정보를 request에 저장
			req.setAttribute("viewUrl", "/member/MemberUpdateForm.jsp");
			
//			이제 jsp로 직접 보내는 것이 아니라 DispatchServlet에게 이동을 맡긴다
//		      Member member = memberDao.selectOne(
//		          Integer.parseInt(req.getParameter("no")));
//
//		      req.setAttribute("member", member);
//			
//			RequestDispatcher rd = req.getRequestDispatcher(
//					"/member/MemberUpdateForm.jsp");
//			rd.forward(req, resp);			
			
		}catch(Exception e) {
//			예외처리를 DispatchServlet에게 처리하도록 일원화하기 위해 주석 처리
//			e.printStackTrace();
//			req.setAttribute("error", e);
//			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
//			rd.forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberUpdateServlet::doPost() 호출");

		try {
			ServletContext sc = this.getServletContext();
			MemberDao memberDao = (MemberDao)sc.getAttribute("memberDao");
			Member member = (Member)req.getAttribute("member");
			memberDao.update(member);
			
			req.setAttribute("viewUrl", "redirect:list.do");
			
//		      memberDao.update(new Member()
//				      .setNo(Integer.parseInt(req.getParameter("no")))
//				      .setName(req.getParameter("name"))
//				      .setEmail(req.getParameter("email")));			
//					
//			resp.sendRedirect("list");
			
		}catch(Exception e) {
			e.printStackTrace();
			req.setAttribute("error", e);
			RequestDispatcher rd = req.getRequestDispatcher("/Error.jsp");
			rd.forward(req, resp);
		}
	}
}