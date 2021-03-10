package work.manager.project;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import work.manager.paging.PagingService;
import work.manager.paging.PagingVO;

import com.google.gson.Gson;

@RequestMapping(value="/project")
@Controller
public class ProjectController {
	Logger logger = Logger.getLogger(this.getClass());
	
	private Gson gson  = new Gson();
	
	private ProjectVO projectVO;
	
	private PagingVO pagingVO;
	
	private HashMap<String, Object> hashMap;
	
	
	@Resource(name="projectService")
	private ProjectService projectSerivce;
	
	@Resource(name="pagingService")
	private PagingService pagingService;
	
	//프로젝트 추가 페이지로 이동
	@RequestMapping(value="/addForm.do")
	public String addProjectForm(){
		
		return "project/addForm";
	}
	
	
	
	//프로젝트 추가
	@ResponseBody
	@RequestMapping(value="/addProject.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String addProject(@RequestParam("pr_writer")String pr_writer,
							 @RequestParam("pr_title")String pr_title,
							 @RequestParam(value="pr_content", required=false)String pr_content){
		hashMap = new HashMap<String, Object>();
		if(pr_writer!=null&&!pr_writer.isEmpty()&&pr_title!=null&&!pr_title.isEmpty()){
			projectVO = new ProjectVO(pr_writer, pr_title, pr_content);
			try {
				projectSerivce.addProject(projectVO);
				hashMap.put("result", "등록되었습니다");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "프로젝트 추가 오류");
		}
		return gson.toJson(hashMap);
	}
	
	
	@ResponseBody
	@RequestMapping(value="/detail.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String projectDetail(@RequestParam(value="pr_num")int pr_num){
		hashMap = new HashMap<String, Object>();
		if(pr_num>0){
			try {
				hashMap.put("project", projectSerivce.getDetail(pr_num));
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else{
			logger.debug("프로젝트 상세 페이지 오류");
		}
		
		return gson.toJson(hashMap);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/delete.do",produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String projcetDelete(@RequestParam("pr_num")int pr_num){
		hashMap = new HashMap<String, Object>();
		if(pr_num>0){
			try {
				projectSerivce.projcetDelete(pr_num);
				projectSerivce.projectDeleteWork(pr_num);
				hashMap.put("result", "삭제되었습니다");
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "삭제되지 않았습니다.");
		}
		
		return gson.toJson(hashMap);
	}
	
	
	@RequestMapping(value="/projectModifyDo.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String projectModifyDo(@RequestParam("pr_num")int pr_num, 
								  @RequestParam("pr_title")String pr_title,
								  @RequestParam(value="pr_content",required=false)String pr_content){
		if(pr_num>0&&pr_title!=null&&!pr_title.isEmpty()){
			projectVO = new ProjectVO(pr_num, pr_title, pr_content);
			try{
				projectSerivce.modify(projectVO);
			}catch(Exception e){
				e.printStackTrace();
			}
		}else{
			logger.debug("프로젝트 수정 오류");
		}
		
		return "user/loginOk";
	}
	@ResponseBody
	@RequestMapping(value="/pr_modify.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String pr_modify(@RequestParam("pr_num")int pr_num, 
					     	@RequestParam("pr_title")String pr_title,
					     	@RequestParam(value="pr_content",required=false)String pr_content,
					     	@RequestParam("pr_writer")String pr_writer){
		hashMap = new HashMap<String, Object>();
		if(pr_num>0&&pr_title!=null&&!pr_title.isEmpty()&&pr_writer!=null&&!pr_writer.isEmpty()){
			projectVO = new ProjectVO(pr_num, pr_title, pr_content, pr_writer);
			try{
				projectSerivce.modify(projectVO);
				hashMap.put("result", "수정되었습니다");
			}catch(Exception e){
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "관리자 프로젝트 수정 오류");
		}
		
		return gson.toJson(hashMap);
	}
	//프로젝트 리스트 출력
		@ResponseBody
		@RequestMapping(value="/getProjectList.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
		public String projectList(@RequestParam(value="nowPage")int nowPage){
			hashMap = new HashMap<String, Object>();
			
			if(nowPage>0){
				pagingVO = new PagingVO(pagingService.countProject(),nowPage);
				try {	
					hashMap.put("paging", pagingVO);
					hashMap.put("projectList", pagingService.selectProject(pagingVO));
				} catch(Exception e) {
					e.printStackTrace();
				}
				
			}else{
				logger.debug("프로젝트 리스트 오류");
			}
			return gson.toJson(hashMap);
		}

	@ResponseBody
	@RequestMapping(value="/search.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String search(
				  @RequestParam("con1")int con1,
				  @RequestParam("con2")int con2,
				  @RequestParam("con3")String con3,
				  @RequestParam("nowPage")int nowPage){
		hashMap = new HashMap<String, Object>();
		
		if(con1>0&&con2>0&&con3!=null&&!con3.isEmpty()){
			//초기 검색 설정 값 
			SearchVO searchVO = new SearchVO(con1, con2, con3);
			//초기 검색 설정 값으로 TOTAL 값 추출
			pagingVO = new PagingVO(pagingService.searchCount(searchVO), nowPage);
			hashMap.put("paging", pagingVO);
			SearchVO search = new SearchVO(con1, con2, con3, pagingVO.getStart(),pagingVO.getCntPerPage());
			if(con1 == 1){
				hashMap.put("type", 1);
				hashMap.put("projectList", pagingService.searchPrList(search));
			}else{
				hashMap.put("workList", pagingService.searchWoList(search));
			}
			hashMap.put("searchVO", search);
		}
		
		return gson.toJson(hashMap);
	}
	

	
				  
	
}
