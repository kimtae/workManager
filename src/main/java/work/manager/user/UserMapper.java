package work.manager.user;


import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {
		public void register(UserVO VO)throws Exception;
		public int allowLogin(String user_id);
		public String loginCheck(String user_id);
		public UserVO getMyInfo(String user_id);
		public int idCheck(String user_id);
		public void doDelete(String user_id);
		public int deleteCheck(UserVO VO);
		public void modify(UserVO VO);
		public int checkUserType(String user_id);
		public void userUnLock(String user_id);
		public void userLock(String user_id);
		public void rootModifyUser(UserVO VO);

		void userTypeModify(UserVO userVO);
		
		
}
