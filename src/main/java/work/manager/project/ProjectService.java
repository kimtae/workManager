package work.manager.project;

import javax.servlet.http.HttpServletResponse;



public interface ProjectService {
	void addProject(ProjectVO projectVO);
	int countProject(String pr_writer);
//	String getTitle(ProjectVO projectVO);

	ProjectVO getDetail(int pr_num);
	void projcetDelete(int pr_num);
	void modify(ProjectVO projectVO);
	void projectDeleteWork(int pr_num);
	
}
