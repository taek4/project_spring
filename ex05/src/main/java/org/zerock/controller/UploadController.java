package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		// C드라이브에 upload 폴더를 지정
		String uploadFolder = "C:\\upload";
		// 뷰로부터 받은 파일들을 반복문으로 순회
		for (MultipartFile multipartFile : uploadFile) {

			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			// end catch
		}
		// end for
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}

	// /uploadAjaxAction 경로에 들어온 요청을 처리, 응답 형태는 UTF-8로 인코딩된 JSON 형태의 데이터로 지정
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // 메서드의 반환형을 순수한 데이터 타입으로 반환
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		// 업로드된 파일 정보를 담을 리스트 생성
		List<AttachFileDTO> list = new ArrayList<>();

		// C드라이브 upload 폴더 지정
		String uploadFolder = "C:\\upload";

		// sysdate를 기준으로 년/월/일 폴더로 나누는 폴더 경로를 동적으로 생성
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		// 폴더가 존재하지 않는다면 만듦
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		// 뷰로부터 받은 파일들을 반복문으로 순회
		for (MultipartFile multipartFile : uploadFile) {

			// 파일 정보를 저장할 DTO 객체 생성
			AttachFileDTO attachDTO = new AttachFileDTO();

			log.info("---------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			// 파일의 이름을 가져옴
			String uploadFileName = multipartFile.getOriginalFilename();

			log.info(uploadFileName);

			// 구버전 IE 등에서 파일의 경로 전체가 포함되어 전달될 경우를 대비
			// 예: C:\Users\User\Documents\example.txt
			// lastIndexOf("\\")는 마지막 "\\"의 위치를 반환함
			// +1을 더해 마지막 "\\" 바로 뒤에서 시작하여 순수한 파일 이름만 추출
			// 결과: "example.txt"
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);

			// 랜덤한 UUID를 생성
			UUID uuid = UUID.randomUUID();

			// 생성한 UUID를 문자열로 바꾸고 파일 이름 앞에 붙이기
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				// 저장할 경로와 파일의 이름을 가지는 File 객체 생성
				File saveFile = new File(uploadPath, uploadFileName);

				// 지정한 경로에 지정한 파일 이름으로, 뷰로부터 받은 파일을 저장한다.
				multipartFile.transferTo(saveFile);

				// 파일 정보를 DTO에 저장
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// 이미지 파일인지 확인
				if (checkImageType(saveFile)) {
					// 이미지일 경우, 썸네일 생성
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					// 썸네일 생성 (가로 100px, 세로 100px)
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();

					// 이미지 여부를 DTO에 저장
					attachDTO.setImage(true);
				}

				// DTO를 리스트에 추가
				list.add(attachDTO);

			} catch (Exception e) {
				// 파일 저장 중 발생한 예외를 로깅
				e.printStackTrace();
			}
			// end catch
		}
		// end for

		// 리스트를 JSON 형태로 반환, 200 OK 반환
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/display")
	@ResponseBody
	// byte 배열로 응답을 줌
	public ResponseEntity<byte[]> getFile(String fileName) {

		log.info("fileName: " + fileName);

		// 서버로부터 받은 파일 이름(경로 + 파일 이름)으로 File 객체 생성
		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);

		// 응답으로 보낼 ResponseEntity 생성
		// body 부분에 byte[] 배열을 담는다.
		ResponseEntity<byte[]> result = null;

		try {
			// Http 헤더 객체 생성
			HttpHeaders header = new HttpHeaders();

			// 헤더에 Content-Type 필드를 추가하여 반환할 파일의 MIME 타입을 지정
			// 파일의 확장자를 기준으로 MIME가 결정된다.
			// .txt : text/plain
			// .JPEG : image/jpeg
			// .png : image/png
			// .pdf : application/pdf
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			// Files.probeContentType(file.toPath())) : 파일의 MIME 타입을 확인
			// file.toPath : file 객체를 nio.Path 객체로 변환
			// nio : new input output. Java에서 파일 입출력 및 네트워크 작업을 효율적으로 처리하기 위해 도입된 새로운 I/O API
			// Path 클래스 : 파일 경로를 다루는 클래스
			
			// 서버에서 클라이언트로 보낼 응답을 생성:
			// - 헤더(Header): MIME 타입(Content-Type)과 상태 코드(HttpStatus.OK)
			// - 바디(Body): 파일의 내용을 byte[]로 변환하여 포함
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			// FileCopyUtils.copyToByteArray(file) : 주어진 파일 객체를 바이트 코드로 반환
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	// http 헤더의 User-Agent 부분을 읽어들여 	클라이언트(브라우저, 앱, 또는 기타 HTTP 클라이언트)의 정보를 나타내는 요청 헤더이다.
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {

		// 뷰로부터 전달받은 파일 이름(경로 포함)을 이용해 해당 파일을 FileSystemResource로 로드
	    Resource resource = new FileSystemResource("c:\\upload\\" + fileName);

	    // 파일이 존재하지 않을 경우 NOT_FOUND 반환
	    if (resource.exists() == false) {
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    // 파일 이름만을 추출
	    String resourceName = resource.getFilename();

	    // 파일 이름에서 UUID 제거
	    String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);

	    HttpHeaders headers = new HttpHeaders();
	    try {
	        String downloadName = null;

	        // 브라우저가 인식할 수 있는 형태로 URL 인코딩
	        if (userAgent.contains("Trident")) {
	            // IE 브라우저
	            log.info("IE browser");
	            downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
	        } else if (userAgent.contains("Edge")) {
	            // Edge 브라우저
	            log.info("Edge browser");
	            downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
	        } else {
	            // Chrome 등 기타 브라우저
	            log.info("Chrome browser");
	            downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
	        }

	        log.info("downloadName: " + downloadName);

	        // 헤더에 Content-Disposition 필드를 추가하여 파일을 다운로드 할 수 있도록 한다.
	        // 다운로드되는 파일 이름은 downloadName에 따른다.
	        headers.add("Content-Disposition", "attachment; filename=" + downloadName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }

	    return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
	    log.info("deleteFile: " + fileName); // 요청된 파일 이름 로그 출력

	    File file;

	    try {
	        // 요청된 파일 이름을 디코딩하여 File 객체 생성
	        file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

	        // 파일 삭제
	        file.delete();

	        // 이미지 파일인 경우 원본 이미지도 삭제
	        if (type.equals("image")) {
	        	// File 객체(섬네일)의 절대 경로에서 s_를 떼어내서 원본 이미지 경로로 변경
	        	// 절대 경로 : 파일 시스템 상의 파일이나 디렉토리의 실제 위치를 나타내는 전체 경로
	            String largeFileName = file.getAbsolutePath().replace("s_", "");
	            log.info("largeFileName: " + largeFileName); // 원본 이미지 경로 로그 출력

	            // 원본 이미지의 File 객체 생성
	            file = new File(largeFileName);

	            // 원본 이미지 삭제
	            file.delete();
	        }
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        // 파일 삭제 실패 시 NOT_FOUND 응답 반환
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }

	    // 파일 삭제 성공 시 OK 응답 반환
	    return new ResponseEntity<>("deleted", HttpStatus.OK);
	}

	
	// sysdate를 반환하는 메서드
	// yyyy-MM-dd가 아니라 yyyy\MM\dd를 반환
	private String getFolder() {
		// 날짜 포맷 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// Date 객체(sysdate) 생성
		Date date = new Date();
		// 생성한 날짜를 문자열로 변경("yyyy-MM-dd")
		String str = sdf.format(date);
		// "-"를 File.separator로 변환(\)
		return str.replace("-", File.separator);
	}

	// 뷰로부터 받은 파일이 이미지인지 판별하는 메서드
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
