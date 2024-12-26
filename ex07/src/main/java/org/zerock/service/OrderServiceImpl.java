package org.zerock.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.OrderVO;
import org.zerock.mapper.OrderMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    
    @Override
    public List<OrderVO> getOrderList() {
        log.info("Fetching order list...");
        return orderMapper.getOrderList();
    }
    
    @Override
    public List<OrderVO> statusList(Map<String, Object> params) {
        return orderMapper.statusList(params);
    }
    
    @Override
    public List<OrderVO> getReleaseList() {
        return orderMapper.getReleaseList();
    }
    
    @Transactional
    @Override
    public void processRelease(String hinmokuMei, String hitsukeNoRefertype, int release) throws Exception {
        int updatedRows = orderMapper.release(hinmokuMei, hitsukeNoRefertype, release);

        if (updatedRows == 0) {
            throw new Exception("출고 실패: 조건에 맞는 데이터가 없습니다.");
        }
    }


    
    @Override
    public List<OrderVO> unsoldList() {
        log.info("Fetching order list...");
        return orderMapper.unsoldList();
    }
    
    @Override
    public List<HinmokuVO> getHinmokuList() {
        return orderMapper.getHinmokuList();
    }


    @Transactional
    public void saveOrder(JumunshoVO jumunshoVO) {
        if (jumunshoVO == null || jumunshoVO.getCommonHinmokuList() == null || jumunshoVO.getCommonHinmokuList().isEmpty()) {
            throw new IllegalArgumentException("주문서 또는 품목 리스트가 비어 있습니다.");
        }

        log.info("주문서 저장 시작: {}"+ jumunshoVO);

        try {
            // 주문서 삽입
            orderMapper.insertJumunsho(jumunshoVO);

         // hitsukeNo 생성
            String hitsuke = jumunshoVO.getHitsuke(); // YYYY-MM-DD
            LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
            String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식
            
            
            String hitsukeNo = formattedHitsuke + "-" + jumunshoVO.getNo();


            // 각 품목 삽입
            for (CommonHinmokuVO hinmoku : jumunshoVO.getCommonHinmokuList()) {
                if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
                    log.warn("유효하지 않은 품목: {}"+ hinmoku);
                    continue;
                }

                // 필요 시 숫자 변환
                hinmoku.setSuuryou(hinmoku.getSuuryou().trim()); // 공백 제거
                hinmoku.setHitsukeNo(hitsukeNo);
                log.info("품목 삽입 시작: {}"+ hinmoku);
                orderMapper.insertCommonHinmoku(hinmoku); // 개별 품목 삽입
            }

            log.info("주문서 저장 완료: {}"+ jumunshoVO);

        } catch (Exception e) {
            log.error("주문서 저장 중 오류 발생: {}"+ e.getMessage(), e);
            throw e; // 트랜잭션 롤백
        }
    }

    private boolean isInvalidStringValue(String value) {
        // 빈 값이나 유효하지 않은 값 확인
        if (value == null || value.trim().isEmpty()) {
            return true; // 유효하지 않은 값
        }
        try {
            int intValue = Integer.parseInt(value.trim());
            return intValue <= 0; // 0 이하인 경우 유효하지 않음
        } catch (NumberFormatException e) {
            return true; // 숫자로 변환 불가
        }
    }

}




