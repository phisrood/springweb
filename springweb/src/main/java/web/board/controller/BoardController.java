package web.board.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import web.board.model.BoardVO;
import web.board.model.Criteria;
import web.board.model.PageMakerDTO;
import web.board.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	@Resource(name="boardService")
	private BoardService boardService;
	
	
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
	
	@PostMapping("/insert")
	public String insertBoardPOST(BoardVO boardVo, RedirectAttributes rttr) {
		log.info("BoardVO: "+ boardVo);
		try {
			boardService.insertBoard(boardVo);
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
			boardService.modify(boardVo);	
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
	

	
	
	
	
}
