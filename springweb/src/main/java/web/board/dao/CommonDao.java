package web.board.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
    

    /* 총 개수 */
    public int selectTotal(String queryId) throws SQLException {
    	return sqlSession.selectOne(queryId);
    }
}