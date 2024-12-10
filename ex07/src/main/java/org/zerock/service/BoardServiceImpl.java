package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		boardMapper.insertSelectKey(board);
		
		// 첨부 파일이 없다면 아무런 액션도 취하지 않는다.
		if(board.getAttachList()==null||board.getAttachList().size() <= 0) {
			return;
		}
		
		// 첨부파일 리스트를 순회
		board.getAttachList().forEach(attach -> {
			// 리스트 안에 있는 BoardAttachVO 객체의 bno 필드를
			// 현재 게시물인 board 객체의 bno 값으로 설정
			attach.setBno(board.getBno());
			// tbl_attach 테이블에 BoardAttachVO의 값을 insert
			attachMapper.insert(attach);
		});
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get......" + bno);
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify.........." + board);
		
		// 게시물이 업데이트 되었다면 true, 안되었다면 false
		boolean modifyResult = boardMapper.update(board) == 1;
		
		// 게시물이 업데이트 되었고 AND 첨부 파일 리스트가 Null이 아니고 AND 첨부 파일이 1개 이상 있다면 
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			// 첨부 파일 리스트를 순회
			board.getAttachList().forEach(attach -> {
				// 첨부 파일의 게시물 번호를 현재 게시물의 bno로 설정
				attach.setBno(board.getBno());
				// 첨부 파일들을 insert
				attachMapper.insert(attach);
			});
		}
		// true/false 반환
		return modifyResult;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove.........." + bno);
		
		// 게시물 삭제할 때 첨부파일들도 같이 삭제
		attachMapper.deleteAll(bno);
		
		return boardMapper.delete(bno) == 1;
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList..........");
//		return boardMapper.getList();
//	}
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		return boardMapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}
}
