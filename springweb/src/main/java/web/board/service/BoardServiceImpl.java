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

	@Override
	public void insertBoard(BoardVO boardVo) throws SQLException {
		commonDao.insert("insertBoard",boardVo);
	}

	@Override
	public List<BoardVO> getList() throws SQLException {
		return commonDao.selectList("getList");
	}

	@Override
	public BoardVO getPage(int bno) throws SQLException {
		return (BoardVO) commonDao.select("getPage", bno);
	}

	@Override
	public int modify(BoardVO boardVo) throws SQLException {
		return commonDao.update("modify", boardVo);
	}
	
//	@Override
//	public void insertBoard(BoardVO boardVo) {
//		commonDao.insertBoard(boardVo);
//		
//	}
//
//	@Override
//	public List<BoardVO> getList() {
//		return commonDao.getList();
//	}
//
//	@Override
//	public BoardVO getPage(int bno) {
//		return commonDao.getPage(bno);
//	}
//
//	@Override
//	public int modify(BoardVO boardVo) {
//		// TODO Auto-generated method stub
//		return commonDao.modify(boardVo);
//	}

}
