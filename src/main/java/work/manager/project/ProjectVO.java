package work.manager.project;

import java.sql.Date;

public class ProjectVO {
	private int pr_num;
	private String pr_title;
	private String pr_content;
	private int pr_using;
	private String pr_writer;
	private Date reg_date;
	private String pr_modify_writer;
	private Date pr_modify_date;
	
	
	public ProjectVO() {
		
	}
	public ProjectVO(int pr_num,String pr_writer) {
		this.pr_num = pr_num;
		this.pr_writer=pr_writer;
	}
	public ProjectVO(int pr_num,String pr_title,String pr_content) {
		this.pr_num = pr_num;
		this.pr_title = pr_title;
		this.pr_content = pr_content;
	}
	
	public ProjectVO(String pr_writer,String pr_title,String pr_content) {
		this.pr_writer=pr_writer;
		this.pr_title=pr_title;
		this.pr_content=pr_content;
	}
	public ProjectVO(int pr_num, String pr_title,String pr_content,String pr_writer) {
		this.pr_num = pr_num;
		this.pr_writer=pr_writer;
		this.pr_title=pr_title;
		this.pr_content=pr_content;
	}
	
	
	@Override
	public String toString() {
		return "ProjectVO [pr_num=" + pr_num + ", pr_title=" + pr_title + ", pr_content=" + pr_content + ", pr_using=" + pr_using + ", pr_writer=" + pr_writer + ", reg_date=" + reg_date + ", pr_modify_writer=" + pr_modify_writer + ", pr_modify_date=" + pr_modify_date + "]";
	}
	
	
}
