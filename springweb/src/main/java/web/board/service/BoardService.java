package web.board.service;

import java.sql.SQLException;
import java.util.List;

import web.board.model.BoardVO;
import web.board.model.Criteria;

public interface BoardService {
	/* 목록조회 */
	public List<BoardVO> getList() throws SQLException;
	/* 게시판 목록(페에징 적용) */
	public List<BoardVO> getListPaging(Criteria cri) throws SQLException;
	/* 게시판 총 개수*/
	public int getTotal() throws SQLException;
	/* 등록 */
	public void insertBoard(BoardVO boardVo) throws SQLException;
	/* 상세조회 */
	public BoardVO getPage(int bno) throws SQLException;
	/* 게시판 수정 */
	public int modify(BoardVO boardVo) throws SQLException;
	/* 게시판 삭제 */
	public int delete(int bno) throws SQLException;
	

}
