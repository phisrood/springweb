package web.board.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import web.board.model.BoardVO;
import web.board.model.Criteria;

public interface BoardService {
	/* 목록조회 */
	public List<BoardVO> getList() throws SQLException;
	/* 게시판 목록(페에징 적용) */
	public List<BoardVO> getListPaging(Criteria cri) throws SQLException;
	/* 게시판 총 개수*/
	public int getTotal() throws SQLException;
	/* 등록 (첨부파일)*/
	public void insertBoard(BoardVO boardVo, MultipartHttpServletRequest mpRequest) throws SQLException, Exception;
	/* 상세조회 */
	public BoardVO getPage(int bno) throws SQLException;
	/* 첨부파일 조회 */
	public List<Map<String, Object>> selectFileList(int bno) throws SQLException;
	/* 첨부파일 다운로드 */
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws SQLException;
	
	/* 게시판 수정 */
	public void modify(BoardVO boardVo, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws SQLException, Exception;
	/* 게시판 삭제 */
	public int delete(int bno) throws SQLException;
	
	/* 첨부파일이미지 경로*/
	public List<BoardVO> selectFilePath(int fILE_NO) throws SQLException;
	public List<BoardVO> listFilePath(int bno)throws SQLException;
	

}
