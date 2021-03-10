package work.manager.project;


import javax.servlet.http.HttpServletResponse;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("projectMapper")
public interface ProjectMapper {
		void addProject(ProjectVO projectVO);
		int countProject(String pr_writer);
		ProjectVO getDetail(int pr_num);
		void projcetDelete(int pr_num);
		void modify(ProjectVO projectVO);
		void projectDeleteWork(int pr_num);
}
