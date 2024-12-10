package org.zerock.mapper;

import java.util.List;
import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
    
    // 첨부파일 insert
    public void insert(BoardAttachVO vo);
    
    // 첨부파일 삭제
    public void delete(String uuid);
    
    // 게시물 기본키로 첨부파일 리스트 가져오기
    public List<BoardAttachVO> findByBno(Long bno);
    
    // bno에 붙어있는 모든 첨부파일을 삭제
    public void deleteAll(Long bno);
    
    public List<BoardAttachVO> getOldFiles();
}