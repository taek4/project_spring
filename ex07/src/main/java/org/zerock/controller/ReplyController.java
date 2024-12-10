package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@Setter
// Setter를 쓰거나 AllArgsConstructor를 씀
//@AllArgsConstructor
public class ReplyController {
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;

	// /replies/new 경로로 들어오는 요청은 요청 본문(body)에 json 객체를 갖고 있어야 하며 응답 형태는 단순 문자열로 지정
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {

		log.info("ReplyVO: " + vo);

		int insertCount = service.register(vo);

		log.info("Reply INSERT COUNT: " + insertCount);

		// ResponseEntity<String> : 응답을 줄 때 헤더에 서버 상태 코드, 바디에 String형 데이터를 담아서 보낸다.
		// 성공 : 헤더에 200 OK, 바디에 success 문자열 담아서 뷰에게 응답
		// 실패 : 헤더에 500 Internal Server Error, 바디는 빈 상태로 뷰에게 응답
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// /replies/pages/{bno}/{page} 경로로 들어오는 요청의 URL에서 {bno}, {page}의 값을 추출해서 사용하고
	// 요청에 대한 응답 형태는 클라이언트가 Accept 헤더로 지정하는 유형에 따라 XML 혹은 JSON을 반환
	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {

		Criteria cri = new Criteria(page, 10);

		log.info("get Reply List bno: " + bno);
		log.info("cri: " + cri);
		
		// 클릭한 게시물의 댓글 개수와 그 게시물에 달린 댓글들을 리스트를 ReplyPageDTO 객체에 담아 반환
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}

	// /replies/{rno} 경로로 들어오는 요청의 URL에서 {rno}의 값을 추출해서 사용하고
	// 요청에 대한 응답 형태는 클라이언트가 Accept 헤더로 지정하는 유형에 따라 XML 혹은 JSON을 반환
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {

		log.info("get: " + rno);

		// ResponseEntity<List<ReplyVO>> : 응답을 줄 때 헤더에 200 OK 상태 코드, 바디에 ReplyVO 객체를
		// 보낸다.
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}

	// /replies/{rno} 경로로 들어오는 요청의 URL에서 {rno}의 값을 추출해서 사용하고
	// 요청에 대한 응답 형태는 단순 문자열로 지정
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {

		log.info("remove: " + rno);

		// 삭제 성공 여부에 따라
		// 성공 : 헤더에 200 OK, 바디에 success 문자열 담아서 뷰에게 응답
		// 실패 : 헤더에 500 Internal Server Error, 바디는 빈 상태로 뷰에게 응답
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// /replies/{rno} 경로로 들어오는 PUT, PATCH 메서드를 처리
	// PUT : 리소스 전체를 수정할 때 사용
	// PATCH : 리소스를 부분 수정할 때 사용
	// 요청의 본문(body)에는 json 객체가 담겨있어야 하며
	// 요청에 대한 응답 형태는 단순 문자열로 지정
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {

		vo.setRno(rno);

		log.info("rno: " + rno);
		log.info("modify: " + vo);

		// 수정 성공 여부에 따라
		// 성공 : 헤더에 200 OK, 바디에 success 문자열 담아서 뷰에게 응답
		// 실패 : 헤더에 500 Internal Server Error, 바디는 빈 상태로 뷰에게 응답
		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
