package work.manager.work;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface WorkService {

	

	void write(WorkVO workVO);


	void fileUpload(FileVO fileVO);

	int getWorkNum();


	WorkVO getWorkDetail(int work_num);


	List<FileVO> getFile(int work_num);


	void fileDownLoad(HttpServletResponse response, String file_name);


	FileVO detailFile(int file_num);


	void modify(WorkVO workVO);


	void fileDelete(int file_num);


	void delete(int work_num);

}
