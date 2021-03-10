package work.manager.paging;



public class PagingVO {
	
	private int nowPage;  //현제페이지
	private int startPage; //시작 페이지
	private int endPage; // 끝 페이지
	private int total; //전체 수
	private int lastPage; //마지막 페이지
	private int start;  //DB에 들어갈 시작 값
	public int getCntPerPage() {
		return cntPerPage;
	}
	public int getStart() {
		return start;
	}


	private int cntPage = 5; //페이지 보기 수
	private int cntPerPage = 5; //페이지 마다 보여지는 수 
	private int work_pr_num; //일감 상위 프로젝트 번호
	public PagingVO() {
		// TODO Auto-generated constructor stub
	}
	public PagingVO(int total, int nowPage, int work_pr_num) {
		this.total = total;
		this.nowPage = nowPage;
		this.work_pr_num = work_pr_num;
		calcLastPage(total, cntPerPage);
		calcStartEndPage(nowPage, cntPage);
		calcStart(nowPage, cntPerPage);
	}
	
	public PagingVO(int total, int nowPage) {
		this.total = total;
		this.nowPage = nowPage;
		calcLastPage(total, cntPerPage);
		calcStartEndPage(nowPage, cntPage);
		calcStart(nowPage, cntPerPage);
	}
	



	// 제일 마지막 페이지 계산
	public void calcLastPage(int total, int cntPerPage) {
		setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
	}
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int cntPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		setStartPage(getEndPage() - cntPage + 1);
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}
	// DB 쿼리에서 사용할 start
		public void calcStart(int nowPage, int cntPerPage) {
			setStart(nowPage*cntPerPage-5);
		}
		
	
	
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public void setStart(int start) {
		this.start = start;
	}

	
	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total + ", lastPage=" + lastPage + ", start=" + start +", cntPage=" + cntPage + ", cntPerPage=" + cntPerPage + ", work_pr_num=" + work_pr_num + "]";
	}	
	

	
	
	
	
}