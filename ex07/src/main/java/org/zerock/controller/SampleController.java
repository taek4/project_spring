package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	@GetMapping("/all")
	public void doAll() {
		log.info("do all can access everybody");
	}

	@GetMapping("/member")
	public void doMember() {
		log.info("logined member");
	}

	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin only");
	}

	// POST /sample/ticket 요청 처리
	@PostMapping(value = "/ticket", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Ticket> convertTicket(@RequestBody Ticket ticket) {
		log.info("Received Ticket: " + ticket);
		// 요청 데이터 처리 후 200 OK와 함께 응답
		return new ResponseEntity<>(ticket, HttpStatus.OK);
	}
	
	@GetMapping("/home")
	public String home() {
		return "home";
	}
	
	@GetMapping("/homee")
	public String homee() {
		return "homee";
	}
}
