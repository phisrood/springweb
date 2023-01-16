package web.board.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;


public class BoardVO {

    /* 게시판 제목 */
    private String title;
	/* 게시판 내용 */
    private String content;
    /* 게시판 작가 */
    private String writer;
    /* 등록 날짜 */
    private Date regdate;
    /* 수정 날짜 */
    private Date updateDate;
    /* 게시판 번호 */
    private int bno;
    private int rownum;
    
    /* 댓글 개수 */
    private int repCount;
    
    
	

	@Override
	public String toString() {
		return "BoardVO [title=" + title + ", content=" + content + ", writer=" + writer + ", regdate=" + regdate
				+ ", updateDate=" + updateDate + ", bno=" + bno + ", rownum=" + rownum + ", repCount=" + repCount + "]";
	}
	
	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public Date getRegdate() {
		return regdate;
	}


	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public int getBno() {
		return bno;
	}


	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
    
	public int getRepCount() {
		return repCount;
	}

	public void setRepCount(int repCount) {
		this.repCount = repCount;
	}
}
