package web.board.service;

import java.sql.SQLException;
import java.util.List;

import web.board.model.BoardVO;

public interface BoardService {
	
	/* 등록 */
	public void insertBoard(BoardVO boardVo) throws SQLException;
	/* 목록조회 */
	public List<BoardVO> getList() throws SQLException;
	/* 상세조회 */
	public BoardVO getPage(int bno) throws SQLException;
	/* 게시판 수정 */
	public int modify(BoardVO boardVo) throws SQLException;
}
