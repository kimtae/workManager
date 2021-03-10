package work.manager.user;

import java.sql.Date;

public class UserVO {
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private int user_type;
	private int user_using;
	private Date user_reg_date;
	private Date user_modify_date;
	private String user_modify_writer;
	public UserVO() {
		// TODO Auto-generated constructor stub
	}
	public UserVO(String user_id, int user_type) {
		// TODO Auto-generated constructor stub
		this.user_id = user_id;
		this.user_type = user_type;
	}
	public UserVO(String user_id, String user_pw,String user_name) {
		// TODO Auto-generated constructor stub
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
	}
	public UserVO(String user_id, String user_pw,String user_name,String user_modify_writer) {
		// TODO Auto-generated constructor stub
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_modify_writer=user_modify_writer;
	}

	

	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_type=" + user_type + ", user_using=" + user_using + ", user_reg_date=" + user_reg_date + ", user_modify_date=" + user_modify_date + ", user_modify_writer=" + user_modify_writer + "]";
	}
	
	
	
	
}
