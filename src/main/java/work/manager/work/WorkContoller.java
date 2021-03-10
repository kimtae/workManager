package work.manager.work;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import work.manager.paging.PagingService;
import work.manager.paging.PagingVO;

@RequestMapping(value = "/work")
@Controller
public class WorkContoller {
	Logger logger = Logger.getLogger(this.getClass());
	final String path = "C:\\path\\";
	private HashMap<String, Object> hashMap;
	private Gson gson = new Gson();
	private PagingVO pagingVO;
	private FileVO fileVO;
	@Resource(name = "workService")
	private WorkService workService;

	@Resource(name = "pagingService")
	private PagingService pagingService;

	// 일감등록
	@ResponseBody
	@RequestMapping(value = "/add.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String workAdd(MultipartHttpServletRequest multRequest,
			@ModelAttribute WorkVO workVO) {
		hashMap = new HashMap<String, Object>();
		if(workVO.getWork_title()!=null&&!workVO.getWork_title().isEmpty()){
			
			List<MultipartFile> fileList = multRequest.getFiles("file");
			File dir = new File(path);
			if (!dir.isDirectory()) {
				dir.mkdirs();
			}
			try {
				workService.write(workVO);
				int file_wnum = workService.getWorkNum();
				logger.info("일감번호 : "+file_wnum+" 등록");
				for (MultipartFile file : fileList) {
					if(file.getSize()>0){
						String file_original_name = file.getOriginalFilename();
						long file_size = file.getSize();
						String safeFile = path + System.currentTimeMillis()
								+ file_original_name;
						try {
							file.transferTo(new File(safeFile));
							fileVO = new FileVO(file_wnum, file_original_name,
									safeFile, file_size);
							workService.fileUpload(fileVO);
							hashMap.put("result", 1);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							// TODO: handle exception
							e.printStackTrace();
						} catch (Exception e) {
							e.printStackTrace();
							// TODO: handle exception
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else{
			hashMap.put("result", "등록 실패");
		}
		return gson.toJson(hashMap);
	}

	// 일감 수정
	@ResponseBody
	@RequestMapping(value = "/modify.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String modify(MultipartHttpServletRequest multRequest,
			@ModelAttribute WorkVO workVO) {

			hashMap = new HashMap<String, Object>();
			if(workVO.getWork_title()!=null&&!workVO.getWork_title().isEmpty()){
				
				workService.modify(workVO);
				logger.info("일감번호 : "+workVO.getWork_num()+" 수정");
				List<MultipartFile> fileList = multRequest.getFiles("file");
				File dir = new File(path);
				if (!dir.isDirectory()) {
					dir.mkdirs();
				}
				try {
					int file_wnum = workVO.getWork_num();
					for (MultipartFile file : fileList) {
						if(file.getSize()>0){
							String file_original_name = file.getOriginalFilename();
							long file_size = file.getSize();
							String safeFile = path + System.currentTimeMillis()
									+ file_original_name;
							try {
								file.transferTo(new File(safeFile));
								fileVO = new FileVO(file_wnum, file_original_name,
										safeFile, file_size);
								workService.fileUpload(fileVO);
								hashMap.put("result", "수정완료");
							} catch (IllegalStateException e) {
								e.printStackTrace();
							} catch (IOException e) {
								// TODO: handle exception
								e.printStackTrace();
							} catch (Exception e) {
								e.printStackTrace();
								// TODO: handle exception
							}
						}
						
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
				hashMap.put("result", "수정 실패");
			}
			
			return gson.toJson(hashMap);

	}
	
	//일감 삭제
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam(value="work_num")int work_num){
		hashMap = new HashMap<String, Object>();
		if(work_num >0){
			try {
				workService.delete(work_num);
				hashMap.put("result", 1); //삭제 성공
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "일감 삭제 오류");
		}
		
		return gson.toJson(hashMap);
		
	}
	
	//파일 삭제
	@ResponseBody
	@RequestMapping(value = "/fileDelete.do", method = RequestMethod.POST)
	public String fileDelete(@RequestParam(value="file_num")int file_num){
		hashMap = new HashMap<String, Object>();
		if(file_num >0){
			try {
				workService.fileDelete(file_num);
				hashMap.put("result", 1);
			} catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
		}else{
			hashMap.put("result", "파일 삭제 오류");
		}
		return gson.toJson(hashMap);
	}
	// 일감리스트
	@ResponseBody
	@RequestMapping(value = "/list.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String projectList(@RequestParam(value = "nowPage") int nowPage,
							  @RequestParam(value = "work_pr_num") int work_pr_num) {
		hashMap = new HashMap<String, Object>();
		if(nowPage>0&&work_pr_num>0){
			pagingVO = new PagingVO(pagingService.countWork(work_pr_num),nowPage, work_pr_num);
			try {
				hashMap.put("paging", pagingVO);
				hashMap.put("workList", pagingService.selectWork(pagingVO));
				hashMap.put("result", 1);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "일감 출력 오류");
		}
		
		return gson.toJson(hashMap);
	}

	// 일감 상세페이지
	@ResponseBody
	@RequestMapping(value = "/detail.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String detail(@RequestParam(value = "work_num") int work_num,
						 @RequestParam(value = "user_id", required = false) String user_id) {
		hashMap = new HashMap<String, Object>();
		if(work_num>0){
			//일감 정보 불러오기
			WorkVO workVO = workService.getWorkDetail(work_num);
			
			//일감에 담긴 파일리스트 불러오기 
			List<FileVO> fileVO = workService.getFile(work_num);
			try {
				hashMap.put("result", 1);
				hashMap.put("file", fileVO);
				hashMap.put("work", workVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "일감 상세페이지 오류");
		}
	
		return gson.toJson(hashMap);
	}

	// 파일다운로드 (GET)
	@RequestMapping(value = "/fileDown.do")
	public void fileDown(HttpServletResponse response,
			@RequestParam(value = "file_num") int file_num) {
		hashMap = new HashMap<String, Object>();
		if(file_num>0){
			//파일 정보 
			fileVO = workService.detailFile(file_num);
			try {
				File file = new File(fileVO.getFile_name());
				byte[] b = new byte[1024];

				response.reset();
				response.setContentType("application/octet-stream");

				String encoding = new String(fileVO.getFile_original_name().getBytes("utf-8"));
				response.setHeader("Content-Disposition", "attachment;filename="+ encoding);
				response.setHeader("Content-Length", String.valueOf(file.length()));

				if (file.isFile()) // 파일이 있을경우
				{
					FileInputStream fileInputStream = new FileInputStream(file);
					ServletOutputStream servletOutputStream = response
							.getOutputStream();
					while (fileInputStream.read(b, 0, 1024) != -1) {
						servletOutputStream.write(b, 0, 1024);
					}
					servletOutputStream.flush();
					servletOutputStream.close();
					fileInputStream.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}else{
			logger.debug("파일 다운로드 오류");
		}
	}

		
		

		

}
