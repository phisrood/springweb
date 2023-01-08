package web.board.model;

public class PageMakerDTO {
	/* 시작 페이지 = 시작번호 정보 */
	private int startPage;
	/* 끝 페이지 = 끝 번호 정보 */
	private int endPage;
	/* 이전 페이지, 다음 페이지 존재 유무 */
	private boolean prev, next;
	/* 전체 게시물 수 */
	private int total;
	/* 현재 페이지, 페이지당 게시물 표시수 정보 <- Criteria 클래스의 pageNum(현재 페이지) 변수 값을 얻기 위해 선언 */
	private Criteria cri;
	
	
	/* 생성자 <- 현재 페이지에 대한 정보인 'Criteria'와 게시물의 총개수인 'total'을 파라미터를 부여한 PageMakerDTO 생성자*/
	public PageMakerDTO(Criteria cri, int total) {
		this.cri   = cri;
		this.total = total;
		
		/* (화면에 보여질)마지막 페이지 */
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10; // (int)로 다시 형변환 해주는 이유는 Math.ceil()메소드의 반환 타입이 double이기 때문
		/* (화면에 보여질)시작 페이지 */
		this.startPage = this.endPage-9;
		/* 전체 마지막 페이지 */
		int realEnd = (int)(Math.ceil(total*1.0/cri.getAmount())); // total에 1.0을 곱해준 이유는 int형인 total과 int형인 amount를 나눌 경우 본래는 소수점이 나와야 하는 경우에도 실제로는 소수점을 없애버리고 정수만 리턴하기 때문
		
		/* 전체 마지막 페이지(realEnd)가 화면에 보이는 마지막페이지(endPage)보다 작은 경우, 보이는 페이지(endPage)값 조정 */
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		/* 시작 페이지(startPage)값이 1보다 큰 경우: true */
		this.prev = this.startPage > 1;
		/* 마지막 페이지(endPage)값이 1보다 큰 경우: true */
		this.next = this.endPage <realEnd;
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


	public boolean isPrev() {
		return prev;
	}


	public void setPrev(boolean prev) {
		this.prev = prev;
	}


	public boolean isNext() {
		return next;
	}


	public void setNext(boolean next) {
		this.next = next;
	}


	public int getTotal() {
		return total;
	}


	public void setTotal(int total) {
		this.total = total;
	}


	public Criteria getCri() {
		return cri;
	}


	public void setCri(Criteria cri) {
		this.cri = cri;
	}


	@Override
	public String toString() {
		return "PageMakerDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + "]";
	}
	
	
}
