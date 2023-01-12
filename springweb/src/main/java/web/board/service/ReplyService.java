package web.board.service;

import java.sql.SQLException;
import java.util.List;

import web.board.model.ReplyVO;

public interface ReplyService {
	/* 댓글 목록조회 */
	public List<ReplyVO> readReply(int bno) throws SQLException ;
	/* 댓글 작성 */
	public void writeReply(ReplyVO replyVo) throws SQLException ;
	/* 댓글 수정 */
	public void updateReply(ReplyVO replyVo) throws SQLException;
	/* 선택된 댓글 조회 */
	public ReplyVO selectReply(int rno) throws SQLException;
	/* 댓글 삭제 */
	public void deleteReply(ReplyVO replyVo) throws SQLException;
}
