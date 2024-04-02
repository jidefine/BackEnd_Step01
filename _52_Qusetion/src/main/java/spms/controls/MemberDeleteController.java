package spms.controls;

import java.util.Map;

import spms.dao.MemberDao;

public class MemberDeleteController implements Controller {
	
	@Override
	public String execute(Map<String, Object> model) throws Exception {
			System.out.println("MemberDeleteController::execute() - get 요청"); // get 요청
			
			MemberDao memberDao = (MemberDao)model.get("memberDao"); 
			
			memberDao.delete(Integer.parseInt(model.get("no")));	
			
			return "redirect:list.do";
			
	}
}