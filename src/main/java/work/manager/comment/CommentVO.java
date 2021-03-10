package work.manager.comment;

import java.sql.Date;

public class CommentVO {
	private int cm_num;
	private int cm_wnum;
	private String cm_content;
	private int cm_using;
	private String cm_writer;
	private Date cm_date;
	private Date cm_modify_date;
	
	public CommentVO() {
		// TODO Auto-generated constructor stub
	}
	public CommentVO(int cm_num,String cm_content) {
		// TODO Auto-generated constructor stub
		
		this.cm_content=cm_content;
		this.cm_num= cm_num;
	}
	public CommentVO(String cm_writer,String cm_content,int cm_wnum) {
		// TODO Auto-generated constructor stub
		this.cm_writer = cm_writer;
		this.cm_content=cm_content;
		this.cm_wnum= cm_wnum;
	}
	
	
	public int getCm_wnum() {
		return cm_wnum;
	}
	@Override
	public String toString() {
		return "CommentVO [cm_num=" + cm_num + ", cm_wnum=" + cm_wnum
				+ ", cm_content=" + cm_content + ", cm_using=" + cm_using
				+ ", cm_writer=" + cm_writer + ", cm_date=" + cm_date
				+ ", cm_modify_date=" + cm_modify_date + "]";
	}
	
}
