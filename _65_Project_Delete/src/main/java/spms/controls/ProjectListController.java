package spms.controls;

import java.util.List;
import java.util.Map;

import spms.annotation.Component;
import spms.dao.ProjectDao;
import spms.vo.Project;

@Component("/project/list.do")
public class ProjectListController implements Controller {

	ProjectDao projectDao;
	
	public ProjectListController setMember(ProjectDao projectDao) {
		this.projectDao = projectDao;
		return this;
	}
	
	@Override
	public String execute(Map<String, Object> model) throws Exception {
		
		List<Project> projects = projectDao.selectList();

		System.out.println(projects);
		
		model.put("projects", projectDao.selectList());
		
		return "/project/ProjectList.jsp";
	}

}
