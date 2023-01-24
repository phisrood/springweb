package web.board.service;

import java.sql.SQLException;

import web.board.model.MemberVO;

public interface MemberService {
	/* 회원가입 */
 	public void memberJoin(MemberVO memberVo) throws SQLException;
	/* 아이디 중복검사 */
	public int idCheck(String user_id) throws SQLException;
	/* 로그인 */
	public MemberVO memberLogin(MemberVO memberVo) throws Exception;
}
