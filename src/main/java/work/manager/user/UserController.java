package work.manager.user;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import work.manager.paging.PagingService;
import work.manager.paging.PagingVO;

import com.google.gson.Gson;

@RequestMapping(value="/user")
@Controller
public class UserController {
	Logger logger = Logger.getLogger(this.getClass());
	
	private HashMap<String, Object> hashMap;
	private Gson gson  = new Gson();
	private PagingVO vo;
	private UserVO userVO;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="pagingService")
	private PagingService pagingService;
	
	//메인페이지(로그인페이지) 이동
	@RequestMapping(value="/main.do")
	public String main() throws Exception{
		return "main";
	}
	
	//회원 등록 
	@RequestMapping(value="/register.do", method = RequestMethod.POST)
	public String register(@RequestParam("user_id")String user_id,
						   @RequestParam("user_pw")String user_pw,
						   @RequestParam("user_name")String user_name){
		if(user_id!=null&&!user_id.isEmpty()&&user_pw!=null&&!user_pw.isEmpty()&&user_name!=null&&!user_name.isEmpty()){
			userVO = new UserVO(user_id, user_pw, user_name);
			try {
				userService.register(userVO);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "main";
		}else{
			return "error";	
		}
	}
	
	//회원등록 페이지 이동
	@RequestMapping(value="/insert.do")
	public String insertPage(){
		return "user/insert";
	}
	
	@ResponseBody
	@RequestMapping(value="/changeType.do", produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String userTypeModify(@RequestParam("user_type")int user_type,
								 @RequestParam("uesr_id")String user_id){
		
		hashMap = new HashMap<String, Object>();
		if(user_type>0&&user_id!=null&&!user_id.isEmpty()){
			userVO = new UserVO(user_id, user_type);
			logger.info(userVO.toString());
			try {
				userService.userTypeModify(userVO);
				hashMap.put("result", "변경하였습니다");
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}else{
			hashMap.put("result", "변경하지 못하였습니다");
		}
		return gson.toJson(hashMap);
	}
	
	
	 
	//가입 승인 완료된 아이디인지 확인
	@ResponseBody
	@RequestMapping(value="/allowLogin.do", method = RequestMethod.POST)
	public String allowLogin(@RequestParam("user_id") String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				hashMap.put("user_using", userService.allowLogin(user_id));
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}	
		}else{
			hashMap.put("user_using", "승인이 완료되지 않은 사용자입니다");
		}
		
		return gson.toJson(hashMap);
		
	}
	
	// 로그인시 아이디와 비밀번호 확인
	@ResponseBody
	@RequestMapping(value="/loginCheck.do",produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String loginCheck(@RequestParam("user_id") String user_id,
							 @RequestParam("user_pw") String user_pw){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()&&user_pw!=null&&!user_pw.isEmpty()){
			
			try {
				String getPassword = userService.loginCheck(user_id);
				int result = 0;
				if(getPassword.equals(user_pw)){
					result = 1; //  로그인 성공
				}
				hashMap.put("result", result);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result","빈칸을 입력해주세요.");
		}
		return gson.toJson(hashMap);
	}
	
	//session에 ID등록
	@RequestMapping(value="/loginOk.do", method = RequestMethod.GET)
	public String loginOk(@RequestParam("user_id")String user_id,HttpSession session){
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				session.setAttribute("user_id", user_id);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			logger.debug("Session Error");
		}
		
		return "user/loginOk";
	}
	
	
	// 내정보 페이지로 이동 
	@RequestMapping(value="/myInfo.do", method = RequestMethod.GET)
	public String myInfoPage(){
		return "user/myInfo";
	}
	
	//DB에 ID가 있는지 검사
	@ResponseBody
	@RequestMapping(value="/idCheck.do",method = RequestMethod.POST)
	public String idCheck(@RequestParam("user_id") String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				hashMap.put("result", userService.idCheck(user_id));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "IDCHECK 오류");
		}

		return gson.toJson(hashMap);
	}
	
	//회원 삭제 
	@ResponseBody
	@RequestMapping(value="/doDelete.do",produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String delete(@RequestParam("user_id")String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				userService.doDelete(user_id);
				hashMap.put("result", "삭제되었습니다");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "삭제되지 않았습니다");
		}
	
		return gson.toJson(hashMap);
		
	}
	
	//회원수정 
	@RequestMapping(value="/modify.do", method = RequestMethod.POST)
	public String modify(@RequestParam("user_id")String user_id,
						 @RequestParam("user_pw")String user_pw,
						 @RequestParam("user_name")String user_name){
		if(user_id!=null&&!user_id.isEmpty()&&user_pw!=null&&!user_pw.isEmpty()&&user_name!=null&&!user_name.isEmpty()){
			UserVO userVO = new UserVO(user_id, user_pw, user_name);
			try {
				userService.modify(userVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "main";
		}
			
		return "error";
	
		
		
		
	}
	//(관리자) 회원수정 
	@ResponseBody
	@RequestMapping(value="/rootModifyUser.do", method = RequestMethod.POST)
	public String rootModifyUser(@RequestParam("user_id")String user_id,
								 @RequestParam("user_pw")String user_pw,
								 @RequestParam("user_name")String user_name){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()&&user_pw!=null&&!user_pw.isEmpty()&&user_name!=null&&!user_name.isEmpty()){
			UserVO userVO = new UserVO(user_id, user_pw, user_name);
			
			try {
				userService.rootModifyUser(userVO);
				hashMap.put("result", 1); //회원정보 수정 성공
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "빈칸을 입력해주세요"); //회원정보 수정 실패
		}
	
		return gson.toJson(hashMap);
	}

	//유저의 타입 체크 (일반 사용자 / 관리자 )
	@ResponseBody
	@RequestMapping(value="/checkUserType.do", method = RequestMethod.POST)
	public String checkUserType(@RequestParam("user_id")String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			hashMap.put("result", userService.checkUserType(user_id));
			
		}else{
			hashMap.put("result", "권한이 없습니다");
		}
		return gson.toJson(hashMap);
	}
	
	
	//회원해제
	@ResponseBody
	@RequestMapping(value="/unlock.do" , method = RequestMethod.POST)
	public String userUnLock(@RequestParam("user_id")String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				userService.userUnLock(user_id);
				hashMap.put("result", 1);
			} catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
			}
		}else{
			hashMap.put("result", "승인오류");
		}

		return gson.toJson(hashMap);
	}
	
	//회원승인
	@ResponseBody
	@RequestMapping(value="/lock.do" , method = RequestMethod.POST)
	public String userLock(@RequestParam("user_id")String user_id){
		hashMap = new HashMap<String, Object>();
		if(user_id!=null&&!user_id.isEmpty()){
			try {
				userService.userLock(user_id);
				hashMap.put("result", 1);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}else{
			hashMap.put("result", "승인오류");
		}
		
		return gson.toJson(hashMap);
	}
	
	//사용자 관리 페이지 이동 
	@RequestMapping(value="/rootPage.do")
	public String rootPage(){
		return "user/rootpage";
	}
	
	//유저리스트 출력
	@ResponseBody
	@RequestMapping(value="/userList.do",produces = "application/text; charset=utf8",method = RequestMethod.POST)
	public String userList(@RequestParam(value="nowPage")int nowPage){
			hashMap = new HashMap<String, Object>();
			if(nowPage>0){
				vo = new PagingVO(pagingService.countAllUser(), nowPage);
				try {
					hashMap.put("paging", vo);
					hashMap.put("userList", pagingService.selectUser(vo));
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
			
			return gson.toJson(hashMap);
	}
	
	
		
	
	
	@RequestMapping(value="/logOut.do")
	public String lougOut(HttpSession session){
		
		session.removeAttribute("user_id");
		
		return "main";
	}
	
}
