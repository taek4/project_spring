package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class JumunshoVO {
    private String jumunshoID;       // 주문서 ID
    private String hitsuke;          // 일자
    private Integer no;            // 주문서 번호
    private String torihikisakiID; // 거래처 ID
    private String tantoushaID;    // 담당자 ID
    private String soukoID;        // 창고 ID
    private String projectID;      // 프로젝트 ID
    private String tsukaID;        // 통화 ID
    private String status = "진행중";         // 진행 상태
    private String naiGai;         // 내자/외자 구분
    private String zeikomikubun;   // 부가세 포함 여부
    private String memo;           // 비고
    private String sakuseibi;        // 생성일
    private String noukiIchija;      // 납기일자
    private String jumunKingakuGoukei; // 주문 금액 합계
    
 // 공통 품목 리스트
    private List<CommonHinmokuVO> commonHinmokuList;
}

