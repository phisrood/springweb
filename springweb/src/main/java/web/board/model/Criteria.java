package web.board.model;

public class Criteria {

	/* 현재 페이지 */
	private int pageNum;
	/* 한 페이지 당 보여질 게시물 개수 */
	private int amount;
	
	/* 기본 생성자(파라미터 없이 criteria클래스 호출했을때 기본적 세팅) : pageNum = 1, amount = 10 */
	public Criteria() {
		this(1,10);
	}

	/* 생성자 => 원하는 pageNum, 원하는 amount */
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + "]";
	}
	
	
}
