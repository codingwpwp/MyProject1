package boardWeb.util;

public class PagingUtil {

	private int nowPage;
	private int startPage;
	private int endPage;
	private int total;
	private int perPage;
	private int lastPage;
	private int start;
	private int end;
	private int cntPage=6;
	
	public PagingUtil(int total, int nowPage, int perPage) {
		setNowPage(nowPage);
		setPerPage(perPage);
		setTotal(total);
		
		calcLastPage(total,perPage);
		
		calcStartEndPage(nowPage,cntPage);
		
		calcStartEnd(nowPage,perPage);
	}
	
	public void calcStartEnd(int nowPage, int perPage) {
		int start = (nowPage - 1) * perPage + 1;
		setStart(start);
		
		int end1 = start + perPage - 1;
		if (end1 > getTotal()) {
			setEnd(getTotal());
		} else {
			setEnd(end1);
		}
	}
	
	public void calcStartEndPage(int nowPage, int cntPage) {
		int endPage1 = (((int)Math.ceil((double)nowPage/cntPage))*cntPage);
		
		if(getLastPage() < endPage1) {
			setEndPage(getLastPage());
		} else {
			setEndPage(endPage1);
		}
		
		int startPage = (endPage1 - cntPage + 1);
		
		if(startPage < 1) {
			startPage = 1;
		}
		setStartPage(startPage);
	}
	
	public void calcLastPage(int total, int perPage) {
		int lastPage = (int)Math.ceil((double)total/perPage);
		setLastPage(lastPage);
		
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
}