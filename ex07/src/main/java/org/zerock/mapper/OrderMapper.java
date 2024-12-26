package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.OrderVO;

public interface OrderMapper {
	// 주문서 목록 조회
    List<OrderVO> getOrderList();
    
    //미판매 목록 조회
    List<OrderVO> unsoldList();
    
    List<OrderVO> getReleaseList(); // 주문서출고처리 리스트 조회
    
    int release(@Param("hinmokuMei") String hinmokuMei,
            @Param("hitsukeNoRefertype") String hitsukeNoRefertype,
            @Param("release") int release);

    List<OrderVO> statusList(Map<String, Object> params);
    
 // 1. 주문서 데이터 삽입
    void insertJumunsho(JumunshoVO jumunshoVO);

    // 2. JumunshoID를 이용하여 Hitsuke_No 조회
    String getHitsukeNoByJumunshoID(String jumunshoID);

    // 3. 공통 품목 데이터 삽입
    int insertCommonHinmoku(CommonHinmokuVO commonHinmokuVO);
    
    List<HinmokuVO> getHinmokuList();  // 품목 리스트 조회


}

