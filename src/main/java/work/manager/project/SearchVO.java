package work.manager.project;

public class SearchVO {
	private int con1;
	private int con2;
	private String con3;
	private int start;
	private int cntPerPage;
	
	public SearchVO() {
		// TODO Auto-generated constructor stub
	}
	
	public SearchVO(int con1,int con2,String con3){
		this.con1=con1;
		this.con2=con2;
		this.con3=con3;
	}
	public SearchVO(int con1,int con2,String con3,int start,int cntPerPage){
		this.con1=con1;
		this.con2=con2;
		this.con3=con3;
		this.start=start;
		this.cntPerPage=cntPerPage;
	}
	
	@Override
	public String toString() {
		return "SearchVO [con1=" + con1 + ", con2=" + con2 + ", con3=" + con3 + "]";
	}
	
}
