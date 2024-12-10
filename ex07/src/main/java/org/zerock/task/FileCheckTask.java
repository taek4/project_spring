package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	// BoardAttachMapper 인터페이스 의존성 주입
    @Setter(onMethod_ = { @Autowired })
    private BoardAttachMapper attachMapper;

    // 어제 날짜 구하기
    private String getFolderYesterDay() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        String str = sdf.format(cal.getTime());
        return str.replace("-", File.separator);
    }

    // 2시간마다 실행
    @Scheduled(cron = "0 0 2 * * *")
    public void checkFiles() throws Exception {
        log.warn("File Check Task run................");
        // sysdate 출력
        log.warn(new Date());

        // 어제 날짜까지의 파일 목록들을 가져옴(파일 경로가 날짜 형식)
        List<BoardAttachVO> fileList = attachMapper.getOldFiles();

        // 데이터베이스에서 가져온 파일 목록(fileList)을 순회하며
        // 각 BoardAttachVO 객체(vo)의 정보를 사용해
        // "C:\\upload\파일경로(날짜)\UUID_파일이름" 형식의 Path 객체를 생성하고,
        // 생성된 Path 객체를 저장하는 리스트 fileListPaths를 생성한다.
        List<Path> fileListPaths = fileList.stream()
            .map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
            .collect(Collectors.toList());

        // fileList의 스트림을 생성하여
        // 이미지 파일만 필터링한 뒤(vo.isFileType() == true),
        // "C:\\upload\파일경로(날짜)\s_UUID_파일이름" 형식의 썸네일 경로를 나타내는 Path 객체를 생성하고,
        // 생성된 Path 객체를 fileListPaths 리스트에 추가한다.
        fileList.stream()
            .filter(vo -> vo.isFileType() == true)
            .map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
            .forEach(p -> fileListPaths.add(p));
        
        // fileListPaths에는 일반 파일, 이미지 파일, 섬네일 이미지 파일의 경로가 저장된다.

        log.warn("=============================");
        // 데이터베이스에서 가져온 파일 목록들을 로그로 출력
        fileListPaths.forEach(p -> log.warn(p));

        // 어제 날짜의 폴더 경로("C:\\upload\yyyy\MM\dd")를 생성하고,
        // 해당 경로를 File 객체로 변환하여 targetDir에 저장한다.
        File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
        
        // targetDir 디렉터리 내의 파일 중 fileListPaths 리스트에 포함되지 않은 파일만 필터링하여
        // 삭제 대상 파일 목록을 removeFiles 배열에 저장한다.
        File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

        log.warn("=============================");
        
        // 삭제할 파일 목록을 순회하며 파일들을 삭제한다.
        for (File file : removeFiles) {
            log.warn(file.getAbsolutePath());
            file.delete();
        }
    }
}
