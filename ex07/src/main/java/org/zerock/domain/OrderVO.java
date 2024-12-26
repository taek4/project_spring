package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderVO {
    private String jumunshoID;           // 주문서 ID
    private String hitsuke;             // 일자
    private String no;               // 주문서 번호
    private String hitsukeNo;         // 일자-No (결합 필드)
    private String hitsukeNoRefertype;
    
    private String mihanbaisuuryou;
    private String mihanbaikyoukyukingaku;
    private String mihanbaibugase;
    
    private String hinmokuMei;        // 품목명
    private int otherHinmokuCount;      // 첫 번째 품목 외 나머지 개수
    
    private String jumunKingakuGoukei;// 주문 금액 합계
    private String status;            // 진행 상태 (예: 진행중, 확인, 완료)
    
    private String commonHinmokuID; // 공통 품목 ID
    private String referenceType; // 참조 유형
    private String itemCode;	//품목코드
    private String kikaku;	//규격
    
    private String suuryou;      // 수량
    private String tanka;         // 단가
    private String kyoukyuKingaku; // 공급 가액
    private String bugase;        // 부가세
    private String tekiyo;        // 적요
    private String noukiIchija;     // 납기일자
    
    private String goukei;
    
    private String projectID;       // 프로젝트 ID
    private String projectMeimei;   // 프로젝트명

    // 창고 정보
    private String soukoID;         // 창고 ID
    private String soukoMei;        // 창고명

    // 담당자 정보
    private String tantoushaID;     // 담당자 ID
    private String tantoushaMei;    // 담당자명

    // 거래처 정보
    private String torihikisakiID;  // 거래처 ID
    private String torihikisakiMei; // 거래처명

    // 통화 정보
    private String tsukaID;     // 통화 코드 (예: KRW, USD)
    private String tsuukaMeimei;    // 통화명
    
    // 추가: 품목 리스트
    private List<CommonHinmokuVO> items;

    public List<CommonHinmokuVO> getItems() {
        return items;
    }
}
