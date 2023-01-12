package web.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import web.board.model.BoardVO;
import web.board.model.Criteria;
import web.board.model.PageMakerDTO;
import web.board.model.ReplyVO;
import web.board.service.BoardService;
import web.board.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	
	/* 게시판 목록 페이지 접속 */
	/*@GetMapping("/list")
	public void listBoardGET(Model model, HttpServletRequest request) {
		System.out.println("/board/list - 게시판 리스트 진입");
		try {
			List<BoardVO> list = boardService.getList();
			model.addAttribute("list", list);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		//return "/board/list";
	}*/
	/* 게시판 목록 페이지 접속(페이징 적용) */
	@GetMapping("/list")
	public void boardListGET(Model model, Criteria cri) {
		System.out.println("/board/list - 게시판 목록 진입");
		try {
			List<BoardVO> list = boardService.getListPaging(cri);
			model.addAttribute("list", list);
			
			int total = boardService.getTotal();
			
			PageMakerDTO pageMaker = new PageMakerDTO(cri, total);
			
			model.addAttribute("pageMaker", pageMaker);
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* 게시판 등록 페이지 접속 */
	@GetMapping("/insert")
	public void insertPageGET() {
		log.info("게시판 등록 페이지 진입");
	}
	
	/* 등록 */
	@PostMapping("/insert")
	public String insertBoardPOST(BoardVO boardVo, RedirectAttributes rttr, MultipartHttpServletRequest mpRequest) throws Exception {
		log.info("BoardVO: "+ boardVo);
		try {
			boardService.insertBoard(boardVo, mpRequest);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		rttr.addFlashAttribute("result", "insert success");
		
		return "redirect:/board/list";
	}
	
	/* 상세조회 */
	@GetMapping("/get")
	public void boardGetPageGET(int bno, Model model, Criteria cri) {
		try {
			model.addAttribute("pageInfo", boardService.getPage(bno));
			model.addAttribute("cri", cri);
			
			List<Map<String, Object>> fileList = boardService.selectFileList(bno);
			model.addAttribute("file", fileList);
			
			List<ReplyVO> replyList = replyService.readReply(bno);
			
			model.addAttribute("replyList", replyList);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* 수정 페이지 이동 */
	@GetMapping("/modify")
	public void boardModifyGET(int bno, Model model, Criteria cri) {
		try {
			model.addAttribute("pageInfo", boardService.getPage(bno));
			model.addAttribute("cri", cri);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* 수정 */
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO boardVo, RedirectAttributes rttr) {
		System.out.println("/board/modify - 수정테스트");
		try {
			boardService.modify(boardVo, null, null, null);	
			rttr.addFlashAttribute("result", "modify success");
		}catch(SQLException e) {
			e.printStackTrace();
			
		}
		
		return "redirect:/board/list";
	}
	
	/* 삭제 */
	@PostMapping("/delete")
	public String boardDeletePOST(int bno, RedirectAttributes rttr) throws SQLException {
		System.out.println("/board/delete - 삭제테스트");
		try {
			boardService.delete(bno);
			rttr.addFlashAttribute("result", "delete success");
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/list";
	}
	
	/* 파일 다운로드 */
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws SQLException, IOException {
		Map<String, Object> resultMap = boardService.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		//파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\yun\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	/* 댓글 작성 */
	@PostMapping("/writeReply")
	public String writeReply(ReplyVO replyVo, RedirectAttributes rttr) throws SQLException{
		
		try {
			replyService.writeReply(replyVo);			
		}catch(SQLException e) {
			e.printStackTrace();
		}

		rttr.addAttribute("bno", replyVo.getBno());
		
		return "redirect:/board/get";
	}
	
	/* 댓글 수정 페이지에 접근하기 위한 컨트롤러 : GET */
	 @GetMapping("/replyUpdateView") 
	 public String replyUpdateView(ReplyVO replyVo, Model model) throws SQLException{
		System.out.println("/replyUpdateView - 수정페이지 진입");
		try { 
			 model.addAttribute("replyUpdate", replyService.selectReply(replyVo.getRno())); 
		}catch(SQLException e) {
			 e.printStackTrace(); 
		}
	  
		return "board/replyUpdateView"; 
	 }
	 
	
	/* 댓글 수정 : POST */
	@PostMapping("/replyUpdate") 
	public String replyUpdate(ReplyVO replyVo,RedirectAttributes rttr) throws SQLException{ 
		try {
			replyService.updateReply(replyVo); 
		}catch(SQLException e) {
			e.printStackTrace(); 
		}
	  
		rttr.addAttribute("bno", replyVo.getBno());
		rttr.addAttribute("rno", replyVo.getRno());
	  
		return "redirect:/board/get"; 
	}
	
	
	/* 댓글 삭제 : post */
	@PostMapping("/replyDelete")
	public String replyDelete(ReplyVO replyVo, RedirectAttributes rttr) throws SQLException{
		try {
			replyService.deleteReply(replyVo);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		rttr.addAttribute("bno", replyVo.getBno());
		
		return "redirect:/board/get";
	}
	 
	
	
}
