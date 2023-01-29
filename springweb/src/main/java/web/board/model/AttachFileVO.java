package web.board.model;

import lombok.Data;

@Data
public class AttachFileVO {
	
	private String fileName; //원본파일 이름
	private String uploadPath; //업로드 경로
	private String uuid; //UUID값
	private boolean image; //이미지인지 아닌지 여부
	
	private int bno;


	@Override
	public String toString() {
		return "AttachFileVO [fileName=" + fileName + ", uploadPath=" + uploadPath + ", uuid=" + uuid + ", image="
				+ image + ", bno=" + bno + "]";
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public boolean isImage() {
		return image;
	}

	public void setImage(boolean image) {
		this.image = image;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}
	
	
}
