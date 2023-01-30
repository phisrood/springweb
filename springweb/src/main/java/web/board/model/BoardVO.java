package web.board.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class BoardVO {

    /* 게시판 제목 */
    private String title;
	/* 게시판 내용 */
    private String content;
    /* 게시판 작가 */
    private String writer;
    
    /* 등록 날짜 */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regdate;
    
    /* 수정 날짜 */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateDate;
    /* 게시판 번호 */
    private int bno;
    private int rownum;
    
    /* 댓글 개수 */
    private int repCount;
    
    private String ATTACH_PATH; 
    private int FILE_NO;


	@Override
	public String toString() {
		return "BoardVO [title=" + title + ", content=" + content + ", writer=" + writer + ", regdate=" + regdate
				+ ", updateDate=" + updateDate + ", bno=" + bno + ", rownum=" + rownum + ", repCount=" + repCount
				+ ", ATTACH_PATH=" + ATTACH_PATH + ", FILE_NO=" + FILE_NO + "]";
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
	
    public int getFILE_NO() {
		return FILE_NO;
	}

	public void setFILE_NO(int fILE_NO) {
		FILE_NO = fILE_NO;
	}

	public String getATTACH_PATH() {
		return ATTACH_PATH;
	}

	public void setATTACH_PATH(String aTTACH_PATH) {
		ATTACH_PATH = aTTACH_PATH;
	}
	
}
