package work.manager.paging;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import work.manager.project.ProjectVO;
import work.manager.project.SearchVO;
import work.manager.user.UserVO;
import work.manager.work.WorkVO;

@Service("pagingService")
public class PagingServiceImpl implements PagingService {


	@Resource(name="pagingMapper")
	private PagingMapper pagingMapper;
	@Override
	public int countAllUser() {
		// TODO Auto-generated method stub
		return pagingMapper.countAllUser();
	}

	@Override
	public List<UserVO> selectUser(PagingVO vo) {
		// TODO Auto-generated method stub
		return pagingMapper.selectUser(vo);
	}

	@Override
	public int countProject() {
		// TODO Auto-generated method stub
		return pagingMapper.countProject();
	}

	@Override
	public List<ProjectVO> selectProject(PagingVO vo) {
		// TODO Auto-generated method stub
		return pagingMapper.selectProject(vo);
	}

	@Override
	public int countWork(int work_pr_num) {
		// TODO Auto-generated method stub
		return pagingMapper.countWork(work_pr_num);
	}

	@Override
	public List<WorkVO> selectWork(PagingVO vo) {
		// TODO Auto-generated method stub
		return pagingMapper.selectWork(vo);
	}

	@Override
	public int searchCount(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return pagingMapper.searchCount(searchVO);
	}

	@Override
	public List<ProjectVO> searchPrList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return pagingMapper.searchPrList(searchVO);
	}

	@Override
	public List<WorkVO> searchWoList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return pagingMapper.searchWoList(searchVO);
	}



}
