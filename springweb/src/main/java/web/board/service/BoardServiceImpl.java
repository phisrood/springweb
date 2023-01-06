package web.board.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import web.board.dao.CommonDao;
import web.board.model.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name="commonDao")
	private CommonDao commonDao;

	/* 등록 */
	@Override
	public void insertBoard(BoardVO boardVo) throws SQLException {
		commonDao.insert("insertBoard",boardVo);
	}

	/* 목록조회 */
	@Override
	public List<BoardVO> getList() throws SQLException {
		return commonDao.selectList("getList");
	}

	/* 상세조회 */
	@Override
	public BoardVO getPage(int bno) throws SQLException {
		return (BoardVO) commonDao.select("getPage", bno);
	}

	/* 수정 */
	@Override
	public int modify(BoardVO boardVo) throws SQLException {
		return commonDao.update("modify", boardVo);
	}
	


}
