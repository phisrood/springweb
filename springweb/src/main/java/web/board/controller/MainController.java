package web.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	// 로그기록을 남기기 위해 Logger클래스인 logger변수 선언 
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
		
	@GetMapping("/main/yunHome")
	public void yunHome() {
		
	}
	
	@GetMapping("/main/profile")
	public void profile() {
		
	}
	
}
