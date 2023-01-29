package web.board.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.board.dao.CommonDao;
import web.board.model.BoardVO;
import web.board.model.Criteria;
import web.board.util.FileUtils;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name="commonDao")
	private CommonDao commonDao;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	/* 목록조회 */
	@Override
	public List<BoardVO> getList() throws SQLException {
		return commonDao.selectList("getList");
	}
	/* 게시판 목록(페이징 적용) */
	@Override
	public List<BoardVO> getListPaging(Criteria cri) throws SQLException {
		return commonDao.selectList("getListPaging", cri);
	}

	/* 게시판 총 개수 */
	@Override
	public int getTotal() throws SQLException {
		return commonDao.selectTotal("getTotal");
	}
	
	/* 등록 */
	@Override
	public void insertBoard(BoardVO boardVo, MultipartHttpServletRequest mpRequest) throws Exception {
		commonDao.insert("insertBoard",boardVo);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVo, mpRequest); 
		int size = list.size();

		for(int i=0; i<size; i++){ 
			commonDao.insertFile(list.get(i)); 
		}
	}

	/* 상세조회 */
	@Override
	public BoardVO getPage(int bno) throws SQLException {
		return (BoardVO) commonDao.select("getPage", bno);
	}
	
	/* 첨부파일 조회 */
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws SQLException {
		return commonDao.selectFileList(bno);
	}

	/* 첨부파일 다운로드 */
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws SQLException {
		return commonDao.selectFileInfo(map);
	}
	
	/* 수정 */
	@Override
	public void modify(BoardVO boardVo, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception {
		commonDao.update("modify", boardVo);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardVo, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				commonDao.insertFile(tempMap);
			}else {
				commonDao.updateFile(tempMap);
			}
		}
		
	}

	/* 삭제*/
	@Override
	public int delete(int bno) throws SQLException {
		return commonDao.delete("delete", bno);
	}
	
	/* 첨부파일  이미지경로 */
	@Override
	public List<BoardVO> selectFilePath(int fILE_NO) throws SQLException{
		return (List<BoardVO>) commonDao.selectList("selectFilePath", fILE_NO);
	}
	




	

	


}
