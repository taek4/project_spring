package org.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String uuid;		// 게시물의 UUID를 포함하는 이름
	private String uploadPath;	// 실제로 저장되어있는 경로
	private String fileName;	// 파일의 실제 이름
	private boolean fileType;	// 이미지 파일 구분값
	
	private Long bno;			// 어느 게시물의 첨부파일인지 저장하는 필드
}
