package web.board.controller;

import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import web.board.service.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="boardService")
	private BoardService boardService;
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Board Controller");
		
		try {
			boardService.insertArticle();
		}catch (Exception e) {
			logger.info("error");
		}
		
		return "/board/basicBoard";
	}
	
}
