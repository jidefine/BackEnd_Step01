package spms.controls;

import java.util.Map;

import javax.servlet.http.HttpSession;

import spms.dao.MemberDao;
import spms.vo.Member;

public class LogInController implements Controller {

	@Override
	public String execute(Map<String, Object> model) throws Exception {
		if(model.get("member") == null) {			// get 요청
			
			return "/auth/LogInForm.jsp";
			
		}else {										// post 요청
			MemberDao memberDao = (MemberDao)model.get("memberDao");
			Member member = memberDao.exist(model.get("email"), model.get("password"));
			memberDao.insert(member);
			
			if (member != null) {
		        HttpSession session = model.put("session");
		        session.setAttribute("member", member);
		        return "../member/list.do";

		    } else {
		    	return "/auth/LogInFail.jsp";
		    }
		}
	}
}