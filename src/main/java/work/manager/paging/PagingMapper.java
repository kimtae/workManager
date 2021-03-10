package work.manager.paging;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import work.manager.project.ProjectVO;
import work.manager.project.SearchVO;
import work.manager.user.UserVO;
import work.manager.work.WorkVO;

@Mapper("pagingMapper")
public interface PagingMapper {

	public int countAllUser();
	public List<UserVO> selectUser(PagingVO vo);
	public int countProject();
	public List<ProjectVO> selectProject(PagingVO vo);
	public int countWork(int work_pr_num);
	public List<WorkVO> selectWork(PagingVO vo);
	public int searchCount(SearchVO searchVO);

	public List<ProjectVO> searchPrList(SearchVO searchVO);
	public List<WorkVO> searchWoList(SearchVO searchVO);
}
