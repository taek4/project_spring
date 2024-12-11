package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	// 셀렉트 어노테이션에 쿼리를 등록하거나, BoardMapper.xml에 쿼리를 등록하거나
	// 둘 중 한가지 방법을 택하면 됨.
	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	// 페이징 기능으로 리스트를 가져오는 메서드
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
