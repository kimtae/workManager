package work.manager.work;



import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("workMapper")
public interface WorkMapper {

	void write(WorkVO workVO);
	void fileUpload(FileVO fileVO);
	int getWorkNum();

	WorkVO getWorkDetail(int work_num);
	List<FileVO> getFile(int work_num);
	
	
	
	FileVO detailFile(int file_num);
	void fileDelete(int file_num);
	void modify(WorkVO workVO);

	void delete(int work_num);
}
