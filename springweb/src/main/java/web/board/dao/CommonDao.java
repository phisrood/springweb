package web.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import web.board.model.ReplyVO;

@Repository(value="commonDao")
public class CommonDao {
 
    @Autowired
    private SqlSessionTemplate sqlSession;
    
    /*insert, delete, update, select 메소드 모두 재정의*/
    public Object select(String queryId) throws SQLException{
    	return sqlSession.selectOne(queryId);
    }
    
    public Object select(String queryId, Object params) throws SQLException{
        return sqlSession.selectOne(queryId, params);
    }
 
    public List selectList(String queryId) throws SQLException{
    	return sqlSession.selectList(queryId);
    }
    
    public List selectList(String queryId, Object params) throws SQLException{
        return sqlSession.selectList(queryId,params);
    }
    
    public int delete(String queryId) throws SQLException {
    	return sqlSession.delete(queryId);
    }
    
    public int delete(String queryId, Object params) throws SQLException {
    	return sqlSession.delete(queryId,params);
    }
    
    public int insert(String queryId) throws SQLException {
    	return sqlSession.insert(queryId);
    }
    
    public int insert(String queryId, Object params) throws SQLException {
    	return sqlSession.insert(queryId,params);
    }
    
    public int update(String queryId) throws SQLException {
    	return sqlSession.update(queryId);
    }
    
    public int update(String queryId, Object params) throws SQLException {
    	return sqlSession.update(queryId,params);
    }
    

    /* 게시글 총 개수 */
    public int selectTotal(String queryId) throws SQLException {
    	return sqlSession.selectOne(queryId);
    }  

    /* 첨부파일 업로드 */
	public void insertFile(Map<String, Object> map) throws SQLException{
		sqlSession.insert("insertFile", map);
	}
	/* 첨부파일 조회 */
	public List<Map<String, Object>> selectFileList (int bno) throws SQLException{
		return sqlSession.selectList("selectFileList", bno);
	}
	/* 첨부파일 다운로드 */
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws SQLException{
		return sqlSession.selectOne("selectFileInfo", map);
	}
	/* 첨부파일 수정 */
	public void updateFile(Map<String, Object> map) throws SQLException {
		sqlSession.update("updateFile", map);
	}

}