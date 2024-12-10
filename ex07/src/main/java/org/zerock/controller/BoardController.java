package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	// Get 요청 처리
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list");
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new PageDTO(cri, 123));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void register() {

	}

	// Post 요청 처리
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("============================");
		log.info("register : " + board);

		// 첨부파일 리스트가 null이 아닌 경우 로그 출력
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}

		log.info("============================");

		// 서비스 호출 및 등록 처리
		service.register(board);

		// 리다이렉트 시 플래시 속성 추가 (게시물 번호 결과)
		// 기본 키를 전달하지만 한 번만 접근이 가능하며 페이지를 이동하거나 새로고침하면 사라진다.
		// rttr.addFlashAttribute("result", board.getBno());

		// 게시물 목록 페이지로 리다이렉트
		return "redirect:/board/list";
	}

	// 배열을 이용하여 여러개의 URL을 하나의 메서드로 처리
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("!!!!!!!!!!!!!!");
		log.info("게시물 클릭");
		log.info("!!!!!!!!!!!!!!");
		log.info("/get or modify");
		log.info(cri.getPageNum());
		log.info(cri.getAmount());

		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify : " + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list" + cri.getListLink();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove....." + bno);
		
		// 첨부 파일 리스트 받아옴
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			// 첨부 파일들 삭제
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list" + cri.getListLink();
	}

	// /getAttachList 경로로 들어오는 GET 요청을 처리, 응답을 UTF-8 JSON 데이터로 설정
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {

		log.info("getAttachList " + bno);

		// 게시물(bno)에 달린 첨부파일 리스트들과 200 OK 상태코드를 전송
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

	// 첨부 파일 리스트를 순회하며 첨부 파일들을 삭제하는 메서드
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("delete attach files....................");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error: " + e.getMessage());
			}
		});
	}

}
