package web.board.model;

import lombok.Data;

@Data
public class AttachFileVO {
	
	private String fileName; //원본파일 이름
	private String uploadPath; //업로드 경로
	private String uuid; //UUID값
	private boolean image; //이미지인지 아닌지 여부
	
}
