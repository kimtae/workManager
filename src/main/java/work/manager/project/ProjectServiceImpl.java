package work.manager.project;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.postgresql.core.ResultHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ibatis.sqlmap.engine.mapping.sql.Sql;

@Service("projectService")
public class ProjectServiceImpl implements ProjectService {
	
	
	
	@Resource(name="projectMapper")
	private ProjectMapper projectMapper;

	@Override
	public void addProject(ProjectVO projectVO) {
		// TODO Auto-generated method stub\
		projectMapper.addProject(projectVO);
		
	}

	@Override
	public int countProject(String pr_writer) {
		// TODO Auto-generated method stub
		return projectMapper.countProject(pr_writer);
	}

	@Override
	public ProjectVO getDetail(int pr_num) {
		// TODO Auto-generated method stub
		return projectMapper.getDetail(pr_num);
	}

	@Override
	public void projcetDelete(int pr_num) {
		// TODO Auto-generated method stub
		projectMapper.projcetDelete(pr_num);
		
	}

	@Override
	public void modify(ProjectVO projectVO) {
		// TODO Auto-generated method stub
		projectMapper.modify(projectVO);
		
	}

	@Override
	public void projectDeleteWork(int pr_num) {
		// TODO Auto-generated method stub
		
	}

	

}
