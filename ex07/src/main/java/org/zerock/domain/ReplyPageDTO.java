package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
// 게시물에 달린 댓글 수와 댓글 리스트를 담는 DTO
public class ReplyPageDTO {
	private int replyCnt;
	private List<ReplyVO> list;
}
