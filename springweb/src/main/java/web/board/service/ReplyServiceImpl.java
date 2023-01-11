package web.board.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import web.board.dao.CommonDao;
import web.board.model.ReplyVO;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {

	@Resource(name="commonDao")
	private CommonDao commonDao;
	
	/* 댓글 목록조회 */
	@Override
	public List<ReplyVO> readReply(int bno) throws SQLException {
		return commonDao.selectList("readReply", bno);
	}

	/* 댓글 작성 */
	@Override
	public void writeReply(ReplyVO replyVo) throws SQLException {
		commonDao.insert("writeReply", replyVo);
	}

	/* 댓글 수정 */
	@Override
	public void updateReply(ReplyVO replyVo) throws SQLException {
		commonDao.update("updateReply", replyVo);
	}

	/* 선택된 댓글 조회 */
	@Override
	public ReplyVO selectReply(int rno) throws SQLException {
		return (ReplyVO) commonDao.select("selectReply", rno);
	}
	
	

	
}
