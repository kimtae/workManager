package work.manager.work;

import java.sql.Date;

public class WorkVO {
	private int work_num;
	private int work_pr_num;
	private int work_file_num;
	private String work_title;
	private String work_content;
	private int work_progress;
	private int work_pr_order;
	private int work_pr_depth;
	private int work_using;
	private String work_writer;
	private Date reg_date;
	private Date work_modify_writer;
	private Date work_modify_date;
	
	public WorkVO() {
		// TODO Auto-generated constructor stub
	}
	
	public WorkVO(String work_writer,String work_title,String work_content,int work_progress,int work_pr_num) {
		// TODO Auto-generated constructor stub
		this.work_writer = work_writer;
		this.work_title = work_title;
		this.work_content = work_content;
		this.work_progress = work_progress;
		this.work_pr_num = work_pr_num;
		
	}
	
	
	public int getWork_num() {
		return work_num;
	}
	public void setWork_num(int work_num) {
		this.work_num = work_num;
	}
	public int getWork_pr_num() {
		return work_pr_num;
	}
	public void setWork_pr_num(int work_pr_num) {
		this.work_pr_num = work_pr_num;
	}
	public int getWork_file_num() {
		return work_file_num;
	}
	public void setWork_file_num(int work_file_num) {
		this.work_file_num = work_file_num;
	}
	public String getWork_title() {
		return work_title;
	}
	public void setWork_title(String work_title) {
		this.work_title = work_title;
	}
	public String getWork_content() {
		return work_content;
	}
	public void setWork_content(String work_content) {
		this.work_content = work_content;
	}
	public int getWork_progress() {
		return work_progress;
	}
	public void setWork_progress(int work_progress) {
		this.work_progress = work_progress;
	}
	public int getWork_pr_order() {
		return work_pr_order;
	}
	public void setWork_pr_order(int work_pr_order) {
		this.work_pr_order = work_pr_order;
	}
	public int getWork_pr_depth() {
		return work_pr_depth;
	}
	public void setWork_pr_depth(int work_pr_depth) {
		this.work_pr_depth = work_pr_depth;
	}
	public int getwork_using() {
		return work_using;
	}
	public void setwork_using(int work_using) {
		this.work_using = work_using;
	}
	public String getWork_writer() {
		return work_writer;
	}
	public void setWork_writer(String work_writer) {
		this.work_writer = work_writer;
	}
	public Date getreg_date() {
		return reg_date;
	}
	public void setreg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getWork_modify_writer() {
		return work_modify_writer;
	}
	public void setWork_modify_writer(Date work_modify_writer) {
		this.work_modify_writer = work_modify_writer;
	}
	public Date getWork_modify_date() {
		return work_modify_date;
	}
	public void setWork_modify_date(Date work_modify_date) {
		this.work_modify_date = work_modify_date;
	}
	@Override
	public String toString() {
		return "WorkVO [work_num=" + work_num + ", work_pr_num=" + work_pr_num + ", work_file_num=" + work_file_num + ", work_title=" + work_title + ", work_content=" + work_content + ", work_progress=" + work_progress + ", work_pr_order=" + work_pr_order + ", work_pr_depth=" + work_pr_depth + ", work_using=" + work_using + ", work_writer=" + work_writer + ", reg_date=" + reg_date + ", work_modify_writer=" + work_modify_writer + ", work_modify_date=" + work_modify_date + "]";
	}
}
