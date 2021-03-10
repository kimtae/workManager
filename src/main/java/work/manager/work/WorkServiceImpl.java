package work.manager.work;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;


@Service("workService")
public class WorkServiceImpl implements WorkService{

	@Resource(name="workMapper")
	private WorkMapper workMapper;
	
	

	@Override
	public void write(WorkVO workVO) {
		// TODO Auto-generated method stub
		workMapper.write(workVO);
		
	}

	

	@Override
	public int getWorkNum() {
		// TODO Auto-generated method stub
		return workMapper.getWorkNum();
	}



	@Override
	public void fileUpload(FileVO fileVO) {
		// TODO Auto-generated method stub
		workMapper.fileUpload(fileVO);
	}



	@Override
	public WorkVO getWorkDetail(int work_num) {
		// TODO Auto-generated method stub
		return workMapper.getWorkDetail(work_num);
	}



	@Override
	public List<FileVO> getFile(int work_num) {
		// TODO Auto-generated method stub
		return workMapper.getFile(work_num);
	}



	@Override
	public void fileDownLoad(HttpServletResponse response, String file_name) {
		// TODO Auto-generated method stub
		
	}



	@Override
	public FileVO detailFile(int file_num) {
		// TODO Auto-generated method stub
		return workMapper.detailFile(file_num);
	}



	@Override
	public void modify(WorkVO workVO) {
		// TODO Auto-generated method stub
		workMapper.modify(workVO);
		
	}



	@Override
	public void fileDelete(int file_num) {
		// TODO Auto-generated method stub
		workMapper.fileDelete(file_num);
	}



	@Override
	public void delete(int work_num) {
		// TODO Auto-generated method stub
		workMapper.delete(work_num);
		
	}

}
