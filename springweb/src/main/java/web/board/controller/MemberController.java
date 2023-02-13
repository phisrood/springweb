package web.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import web.board.model.MemberVO;
import web.board.service.MemberService;


@Controller // 이 클래스가 컨트롤러 역할을 한다고 스프링에 선언하는 역할
@RequestMapping("/member/*")
public class MemberController {
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	/* 메인 페이지 이동 */
	@GetMapping("/main")
	public void mainPageGet() {
		log.info("메인 페이지 진입");
		
	}
	
	
	/* 회원가입 페이지 이동 */
	@GetMapping("/join")
	public void loginGET() {
		log.info("회원가입 페이지 진입");
	}
	
	/* 회원가입 */
	@PostMapping("/join")
	public String joinPOST(MemberVO memberVo) throws Exception{
			
		log.info("join 진입");
		
		// 회원가입 서비스 실행
		memberService.memberJoin(memberVo);
		
		log.info("join Service 성공");
		
		//return "redirect:/member/main";
		return "redirect:/board/list";
			
	}
	
	/* 아이디 중복 검사 */
	@PostMapping("/memberIdChk")
	@ResponseBody //결과 반환기능?
	public String memberIdChkPOST(String user_id) throws Exception{
		int result = memberService.idCheck(user_id);
		
		log.info("결과값 = " + result);
		
		if(result != 0) {
			return "fail";	// 중복 아이디가 존재
		} else {
			return "success";	// 중복 아이디 x
		}	
	
	} 
	
	
	
	
	/* 로그인 페이지 이동 */
	@GetMapping("/login")
	public void joinGET() {
		log.info("로그인 페이지 진입");
	}

	/* 로그인  */
	//MemberVo -> 데이터 전달받기위해
	//HttpServletRequest -> 로그인 성공시 session에 회원정보를 저장하기위해
	//RedirectAttributes -> 로그인 실패시 리다이렉트된 로그인 페이지에 실패를 의미하는 데이터를 전송하기 위해 
	@PostMapping("/login")
	public String loginPOST(HttpServletRequest request, MemberVO memberVo, RedirectAttributes rttr) throws Exception{
		//session사용하기위해 session변수 선언 및 초기화
		HttpSession session = request.getSession();
		
		//MemberVO 타입의 변수 선언, MemberService.java의 memberLogin메서드로 초기화
		// MemberVO 객체를 반환받아서 변수 vo에 저장
		MemberVO vo = memberService.memberLogin(memberVo);
		
		if(vo == null) {                                // 일치하지 않는 아이디, 비밀번호 입력 경우
            int result = 0; // 0:거짓 , 1:참
            rttr.addFlashAttribute("result", result);
            return "redirect:/member/login";    
        }
        
        session.setAttribute("member", vo);             // 일치하는 아이디, 비밀번호 경우 (로그인 성공)
        
        return "redirect:/main/yunHome";
        //return "redirect:/board/list";
	}
	
	/* 메인페이지 로그아웃 */
	@PostMapping("/logout")
	public String logoutMainGET(HttpServletRequest request) throws Exception{
		log.info("logoutMainGET메소드 진입");
		
		//로그인된 세션 정보를 제거해야하기 때문에 HttpSession타입의 session변수 선언 및 초기화
		HttpSession session = request.getSession();
		
		/**
		 * session을 제거할 수 있는 메소드 
		 * 		invalidate() : 세션 전체를 무효화시키는 메소드
		 * 		removeAttribute() : 특정 이름으로 지정한 session객체를 타겟하여 삭제하는 메소드
		 */
		session.invalidate(); 
		
		return "redirect:/main/yunHome" ;
		//return "redirect:/board/list" ;
	}
}
