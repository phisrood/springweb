package web.board.model;

import java.util.Date;

public class ReplyVO {

	private int bno ;
	private int rno ;
	private String rContent ;
	private String rWriter ;
	private Date rRegdate ;
	private int rDepth; 
	private int rGroup;
	
	
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public Date getrRegdate() {
		return rRegdate;
	}
	public void setrRegdate(Date rRegdate) {
		this.rRegdate = rRegdate;
	}
	
	
	public int getrDepth() {
		return rDepth;
	}
	public void setrDepth(int rDepth) {
		this.rDepth = rDepth;
	}
	public int getrGroup() {
		return rGroup;
	}
	public void setrGroup(int rGroup) {
		this.rGroup = rGroup;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", rContent=" + rContent + ", rWriter=" + rWriter
				+ ", rRegdate=" + rRegdate + ", rDepth=" + rDepth + ", rGroup=" + rGroup + "]";
	}
	
	
}
