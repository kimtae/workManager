package work.manager.user;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service("userService")
public class UserServiceImpl implements UserService {
	
	
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	
	@Override
	public void register(UserVO VO) throws Exception {
		// TODO Auto-generated method stub
		userMapper.register(VO);
		
	}

	

	@Override
	public int allowLogin(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.allowLogin(user_id);
	}

	@Override
	public String loginCheck(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.loginCheck(user_id);
	}

	@Override
	public UserVO getMyInfo(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getMyInfo(user_id);
	}

	@Override
	public int idCheck(String user_id){
		// TODO Auto-generated method stub
		return userMapper.idCheck(user_id);
	}

	

	@Override
	public int deleteCheck(UserVO VO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.deleteCheck(VO);
	}

	@Override
	public void doDelete(String user_id) {
		userMapper.doDelete(user_id);
	}

	@Override
	public void modify(UserVO VO) {
		// TODO Auto-generated method stub
		userMapper.modify(VO);
	}

	@Override
	public int checkUserType(String user_id) {
		// TODO Auto-generated method stub
		return userMapper.checkUserType(user_id);
	}

	@Override
	public void userUnLock(String user_id) {
		// TODO Auto-generated method stub
		userMapper.userUnLock(user_id);
	}

	@Override
	public void userLock(String user_id) {
		// TODO Auto-generated method stub
		userMapper.userLock(user_id);
	}

	@Override
	public void rootModifyUser(UserVO VO) {
		// TODO Auto-generated method stub
		userMapper.rootModifyUser(VO);
		
	}



	@Override
	public void userTypeModify(UserVO userVO) {
		// TODO Auto-generated method stub
		userMapper.userTypeModify(userVO);
	}



	
	




}
