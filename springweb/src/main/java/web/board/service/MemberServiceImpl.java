package web.board.service;

import java.sql.SQLException;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import web.board.dao.CommonDao;
import web.board.model.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	@Resource(name="commonDao")
	private CommonDao commonDao;

	/* 회원가입 */
	@Override
	public void memberJoin(MemberVO memberVo) throws SQLException {
		commonDao.insert("memberJoin", memberVo);
	}
	
	/* 아이디 중복검사 */
	@Override
	public int idCheck(String user_id) throws SQLException{
		return (Integer) commonDao.select("idCheck", user_id);
	}

	@Override
	public MemberVO memberLogin(MemberVO memberVo) throws Exception {
		return (MemberVO) commonDao.select("memberLogin", memberVo);
	}
	
	
	
}
