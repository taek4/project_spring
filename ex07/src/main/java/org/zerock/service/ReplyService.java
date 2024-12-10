package org.zerock.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);

	public ReplyVO get(Long bno);

	public int remove(Long targetRno);

	public int modify(ReplyVO reply);

	public List<ReplyVO> getList(@Param("cri") Criteria cri, @Param("bno") Long bno);

	// 현재 페이징 정보와 클릭한 게시물의 기본키를 받아내 댓글 리스트를 가져오는 메서드
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
