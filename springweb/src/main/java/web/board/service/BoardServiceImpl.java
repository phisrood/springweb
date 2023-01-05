package web.board.service;

import java.sql.SQLException;
import java.util.HashMap;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import web.board.dao.CommonDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDao dao;
	
	@Override
	public void insertArticle() throws SQLException{
		try {
		int cnt = dao.insert("insertUser", new HashMap());
		logger.info("================"+String.valueOf(cnt));
		dao.insert("test.insertTest");
		}catch (Exception e) {
			logger.info(e.getMessage());
			throw new SQLException();
		}
	}

}
