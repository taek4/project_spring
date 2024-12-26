package org.zerock.domain;

import lombok.Data;

@Data
public class HinmokuVO {
    private String hinmokuID;         // 품목 ID
    private String zaikoKoodo;      // 재고 코드
    private String hinmokumei;      // 품목명
    private String kikaku;          // 규격
    private String zentaishuuryou; // 전체 수량
    private String soukosuuryou;   // 창고 수량
    private String suuryou;        // 수량
    private String tanka;          // 단가
    private String kyoukyuuGaku;   // 공급가액
    private String shouhizei;      // 부가세
    private String bikouID;           // 비고 ID
}
