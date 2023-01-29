package web.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.coobird.thumbnailator.Thumbnailator;
import web.board.model.AttachFileVO;
import web.board.model.BoardVO;
import web.board.model.Criteria;
import web.board.model.PageMakerDTO;
import web.board.model.ReplyVO;
import web.board.service.BoardService;
import web.board.service.ReplyService;


@Controller // 이 클래스가 컨트롤러 역할을 한다고 스프링에 선언하는 역할
@RequestMapping("/board/*")
public class BoardController {
	// 로그기록을 남기기 위해 Logger클래스인 logger변수 선언 
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="replyService")
	private ReplyService replyService;

	
	///////////////////////////////////////////////////////////////////////////////////
	/* 테스트용_첨부파일 업로드*/
	@GetMapping("/uploadFile")
	public void uploadfileForm() {
		System.out.println("uploadFile 진입");
		log.info("upload form");
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\yun\\file";
		
		for(MultipartFile multipartFile : uploadFile) {
			System.out.println("--------------------------------");
			System.out.println("Upload File Name: " + multipartFile.getOriginalFilename());
			System.out.println("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}//end catch
			
		}//end for
	}
	
	
	/* 년/월/일 폴더 생성: 한 번에 폴더를 생성하거나 존재하는 폴더를 이용하는 방식  */
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	/* 업로드된 파일이 이미지 종류의 파일인지 확인 */
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	/**
	 * 해당 경로가 있는지 검사 -> 폴더생성 및 폴더로 파일을 저장
	 * : 폴더를 생성한 후 uploadPath 경로에 파일을 저장하게 되면 자동으로 폴더가 생성되면서 파일이 저장됨
	 */
	@PostMapping(value="/uploadFile", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileVO>> uploadAjaxPost(MultipartFile[] uploadFile) { 
		
		List<AttachFileVO> list = new ArrayList<AttachFileVO>();
		String uploadFolder = "C:\\yun" ;
		
		String uploadFolderPath = getFolder();
		//make folder ------------
		File uploadPath = new File(uploadFolder, getFolder()); //getFolder(): 오늘 날짜의 경로를 문자열로 생성(생성된 경로는 폴더 경로로 수정된 뒤 반환)
		System.out.println("upload path: " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); //mkdirs(): 필요한 상위 폴더까지 한 번에 생성
		}
		//make yyyy/MM/dd folder
		
		for(MultipartFile multipartFile : uploadFile) {
			System.out.println("----------------------------------------");
			System.out.println("Upload File Name: " + multipartFile.getOriginalFilename());
			System.out.println("Upload File Size: " + multipartFile.getSize());
			
			AttachFileVO attachVo = new AttachFileVO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE has file path : IE의 경우 전체 파일 경로가 전송되므로, 마지막 '\'를 기준으로 잘라낸 문자열이 실제 파일 이름이 된다.
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			System.out.println("only file name: "+ uploadFileName);

			attachVo.setFileName(uploadFileName);
			
			//UUID: 중복방지
			UUID uuid = UUID.randomUUID(); //randomUUID(): 임의의 값 생성 
			uploadFileName = uuid.toString() + "_" + uploadFileName; //생성된 값은 원래의 파일이름과 구분할 수 있도록 중간에 '_' 추가 
			// => 그래서 첨부파일을 업로드하면 UUID가 생성된 파일이 생기므로, 원본 이름과 같더라도 다른 이름의 파일로 생성됨
			
			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachVo.setUuid(uuid.toString());
				attachVo.setUploadPath(uploadFolderPath);
				
				//특정한 파일이 이미지타입인지 검사
				//만약 이미지 타입이면 섬네일 생성
				if(checkImageType(saveFile)) { 
					attachVo.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 500, 500);
					thumbnail.close();
				}
				
				//add to List
				list.add(attachVo);
				
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}//end catch
		}//end for
		return new ResponseEntity<List<AttachFileVO>>(list, HttpStatus.OK);
	}
	
	
	/* 섬네일 데이터 전송하기 */
	@GetMapping("/display")
	@ResponseBody // <-스프링에서 비동기처리하는경우 body에 데이터를 담아서 보내야하는데 그때 사용(요청본분:requestBody,응답본문:responseBody를 담아서 보냄)
	public ResponseEntity<byte[]> getFile(String fileName){ //ResponseEntity: httpentity를 상속받는, 결과 데이터와 HTTP상태코드를 직접 제어할 수있는 클래스
		System.out.println("fileName: "+ fileName);
		File file = new File("c:\\yun\\" + fileName);
		System.out.println("file: "+ file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	/* 첨부파일 다운로드 */
	/**
	 * MIME 란? 
	 * Multipurpose Internet Mail Extensions의 약자
	 * 파일 변환
	 */
	@GetMapping(value="/download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		System.out.println("download file: "+ fileName);
		
//		Resource resource = new FileSystemResource("c:\\yun\\"+ fileName);
		org.springframework.core.io.Resource resource = new FileSystemResource("c:\\yun\\"+ fileName);
		
		System.out.println("resouce: " + resource);
		
		return null;
	}
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	
	
	
	
	/* 게시판 목록 페이지 접속(페이징 적용) */
	@GetMapping("/list")
	public void boardListGET(BoardVO boardVo ,Model model, Criteria cri) {
		System.out.println("/board/list - 게시판 목록 진입");
		try {
			List<BoardVO> list = boardService.getListPaging(cri);
			model.addAttribute("list", list);

			int total = boardService.getTotal();
			model.addAttribute("listTotal", total);
			
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
	public void boardGetPageGET(String user_id, String user_nm, ReplyVO replyVo, int bno, Model model, Criteria cri) {
		try {
			model.addAttribute("pageInfo", boardService.getPage(bno));
			model.addAttribute("cri", cri);
			
			List<Map<String, Object>> fileList = boardService.selectFileList(bno);
			model.addAttribute("file", fileList);
			model.addAttribute("fileCnt", fileList.size());
			
			List<ReplyVO> replyList = replyService.readReply(bno);
			model.addAttribute("replyList", replyList);
			
			model.addAttribute("user_id", user_id);
			model.addAttribute("user_nm", user_nm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* 수정 페이지 이동 */
	@GetMapping("/modify")
	public void boardModifyGET(int fileCnt, String user_id, String user_nm, int bno, Model model, Criteria cri) {
		try {
			model.addAttribute("pageInfo", boardService.getPage(bno));
			model.addAttribute("cri", cri);
			model.addAttribute("user_id", user_id);
			model.addAttribute("user_nm", user_nm);
			model.addAttribute("fileCnt", fileCnt);
			
			List<Map<String, Object>> fileList = boardService.selectFileList(bno);
			model.addAttribute("file", fileList);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/* 수정 */
	@PostMapping("/modify")
	public String boardModifyPOST(BoardVO boardVo, RedirectAttributes rttr, 
			                     @RequestParam(value="fileNoDel[]") String[] files,
			                     @RequestParam(value="fileNameDel[]") String[] fileNames,
			                     MultipartHttpServletRequest mpRequest) {
		System.out.println("/board/modify - 수정테스트");
		try {
			boardService.modify(boardVo, files, fileNames, mpRequest);	
			rttr.addFlashAttribute("result", "modify success");
			
		}catch(SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
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
	
	/* 파일 수정*/
	
	
	
	
	/****************************************************************************************************************************/
	/* 댓글 작성 */
	@PostMapping("/writeReply")
	public String writeReply(String user_id, String user_nm, ReplyVO replyVo, RedirectAttributes rttr) throws SQLException{
		
		try {
			replyService.writeReply(replyVo);			
		}catch(SQLException e) {
			e.printStackTrace();
		}

		rttr.addAttribute("bno", replyVo.getBno());
		rttr.addAttribute("user_id", user_id);
		rttr.addAttribute("user_nm", user_nm);
		
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
	public String replyDelete(String user_id, String user_nm, ReplyVO replyVo, RedirectAttributes rttr) throws SQLException{
		try {
			replyService.deleteReply(replyVo);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		rttr.addAttribute("bno", replyVo.getBno());
		rttr.addAttribute("user_id", user_id);
		rttr.addAttribute("user_nm", user_nm);
		
		return "redirect:/board/get";
	}

	

	 /* 답변 등록: POST */
	 @PostMapping("/reReplyInsert")
	 public String reReplyInsert(String user_id, String user_nm, ReplyVO replyVo, RedirectAttributes rttr) throws SQLException{
		 
		 replyService.reWriteReply(replyVo);
		 
		 rttr.addAttribute("bno", replyVo.getBno());
		 rttr.addAttribute("user_id", user_id);
		 rttr.addAttribute("user_nm", user_nm);
		 
		 return "redirect:/board/get";
	 }
	 
	 
	@GetMapping("/getImage")
	@ResponseBody
	public byte[] getImage(int FILE_NO) throws SQLException {
		List<BoardVO> fileList = boardService.selectFilePath(FILE_NO);
		String path = fileList.get(0).getATTACH_PATH();

		byte[] data = new byte[0];
		String inputFile = path;

		try {
		    InputStream inputStream = new FileInputStream(inputFile);
		    long fileSize = new File(inputFile).length();
		    data = new byte[(int) fileSize];
		    inputStream.read(data);
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return data;
	}
	 

	
}
