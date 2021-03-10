package work.manager.user;



public interface UserService {
	void register(UserVO VO)throws Exception;
	public int allowLogin(String user_id)throws Exception;
	public String loginCheck(String user_id)throws Exception;
	public UserVO getMyInfo(String user_id)throws Exception;
	public int idCheck(String user_id);
	public void doDelete(String user_id);
	public int deleteCheck(UserVO VO)throws Exception;
	public void modify(UserVO VO);
	public int checkUserType(String user_id);
	public void userUnLock(String user_id); 
	public void userLock(String user_id);
	public void rootModifyUser(UserVO VO);
	void userTypeModify(UserVO userVO);
	
	
	
	
	
}
