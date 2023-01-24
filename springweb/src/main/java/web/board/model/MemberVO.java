package web.board.model;

import java.util.Date;

public class MemberVO {
	/* 회원 아이디 */
	private String user_id ;
	/* 회원 비밀번호 */
	private String user_pw ;
	/* 회원 이름 */
	private String user_nm ;
	/* 관리자 구분 (0:일반사용자, 1:관리자) */
	private int admin_ck ;
	/* 등록일자 */
	private Date regDate ;

	@Override
	public String toString() {
		return "MemberVO [user_id=" + user_id + ", user_pw=" + user_pw + ", user_nm=" + user_nm + ", admin_ck="
				+ admin_ck + ", regDate=" + regDate + "]";
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public int getAdmin_ck() {
		return admin_ck;
	}
	public void setAdmin_ck(int admin_ck) {
		this.admin_ck = admin_ck;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	
	
	  
	  
}
