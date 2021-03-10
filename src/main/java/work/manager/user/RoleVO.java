package work.manager.user;

import java.sql.Date;

public class RoleVO {
	private int role_name;
	private String role_content;
	private Date role_reg_date;
	private String role_registrant;
	private Date role_modfiy_date;
	private String role_Modifier;
	
	public RoleVO() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "RoleVO [role_name=" + role_name + ", role_content=" + role_content + ", role_reg_date=" + role_reg_date + ", role_registrant=" + role_registrant + ", role_modfiy_date=" + role_modfiy_date + ", role_Modifier=" + role_Modifier + "]";
	}
}
