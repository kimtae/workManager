package work.manager.comment;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;







import com.google.gson.Gson;

@RequestMapping(value="/comment")
@Controller
public class CommentController {
	
	Logger logger = Logger.getLogger(this.getClass());
	private HashMap<String, Object> hashMap;
	private Gson gson = new Gson();
	private CommentVO commentVO;
	
	
	@Resource(name="commentService")
	private CommentService commentService;
	
	
	//댓글등록
	@RequestMapping(value="/add.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	@ResponseBody
	public String commentAdd(@RequestParam(value="user_id")String cm_writer,
							 @RequestParam(value="cm_content")String cm_content,
							 @RequestParam(value="cm_wnum")int cm_wnum){
		hashMap =new HashMap<String, Object>();
		if(cm_writer!=null&&!cm_writer.isEmpty()&&cm_content!=null&&!cm_content.isEmpty()&&cm_wnum>0){
			commentVO = new CommentVO(cm_writer, cm_content,cm_wnum);
			try {
				commentService.add(commentVO);
				
				hashMap.put("result", 1);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "내용을 입력해주세요");
		}
		
		return gson.toJson(hashMap);
	}
	
	//댓글 리스트 (스크롤)
	@RequestMapping(value="/list.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	@ResponseBody
	public String list(@RequestParam(value="work_num")int work_num){
		hashMap = new HashMap<String, Object>();
		if(work_num>0){
			try {
				hashMap.put("list", commentService.list(work_num)); 
			} catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
		}else{
			logger.debug("댓글 리스트 오류");
		}
		
		
		return gson.toJson(hashMap);
	}
	
	//댓글 정보 불러오기
	@RequestMapping(value="/getComment.do",produces = "application/text; charset=utf8", method = RequestMethod.POST)
	@ResponseBody
	public String getComment(@RequestParam(value="cm_num")int cm_num){
		hashMap = new HashMap<String, Object>();
		if(cm_num>0){
			try {
				hashMap.put("comment",commentService.getComment(cm_num));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			logger.info("댓글 정보 불러오기 오류");
		}
		
		return gson.toJson(hashMap);
	}
	
	//댓글 수정오류
	@ResponseBody
	@RequestMapping(value="/modify.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String modify(@RequestParam(value="cm_num")int cm_num,
						 @RequestParam(value="cm_content")String cm_content){
		hashMap = new HashMap<String, Object>();
		if(cm_num>0&&cm_content!=null&&!cm_content.isEmpty()){
			commentVO = new CommentVO(cm_num, cm_content);
			try {
				commentService.modify(commentVO);
				hashMap.put("result", commentService.getComment(cm_num));
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			logger.debug("댓글 수정 오류");
		}
		return gson.toJson(hashMap);
	}
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value="/delete.do", method=RequestMethod.POST)
	public String delete(@RequestParam(value="cm_num")int cm_num){
		hashMap = new HashMap<String, Object>();
		if(cm_num>0){
			try {
				hashMap.put("work_num", commentService.getComment(cm_num).getCm_wnum());
				hashMap.put("result", 1);
				commentService.delete(cm_num);
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "댓글 삭제 오류");
		}
		
		return gson.toJson(hashMap);
	}
}
