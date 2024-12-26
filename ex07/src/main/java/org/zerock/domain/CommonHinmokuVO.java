package org.zerock.domain;

import lombok.Data;

@Data
public class CommonHinmokuVO {
	private String hinmokuID;       // 재고 테이블 품목 ID
	private String mitsumorishoID; // 견적서 ID  // 見積書ID
	private String hitsukeNoRefertype; // 일자-No
	private String jumunshoID;      // 주문서 ID
	
    private String commonHinmokuID; // 공통 품목 ID
    private String referenceType; // 참조 유형
    private String hitsukeNo;     // 주문서 hitsukeNo
    private String hitsuke_No;
    private String itemCode;	//품목코드
    private String itemName;		//품목명
    private String kikaku;	//규격
    
    private String suuryou;      // 수량
    private String tanka;         // 단가
    private String kyoukyuKingaku; // 공급 가액
    private String bugase;        // 부가세
    private String tekiyo;        // 적요
    private String noukiIchija;     // 납기일자
    
    private String mijumunSuuryou; // 미주문 수량  // 迷走文水量
	private String mijumunKyoukyuKingaku; // 미주문 공급가액  // 迷走文供給価額
	private String mijumunBugase; // 미주문 부가세  // 米州文付加税
    //CommonHinmokuID, ReferenceType, Hitsuke_No, ItemCode, ItemName, Specification, 
    //Suuryou, Tanka, KyoukyuKingaku, Bugase, Tekiyo
	
	private String hanbaiID;
	private int shukkaShiziShoukaiID;
	private String shukkaID;
	private String gaikaKingaku;
	private String genkaKingaku;
	private String hitsuke_No_referType;
	private String suuryouGoukei;
	private String zyuusho;
    
	private String FirstItemName;
	private String OtherCount;
	private String ShukkaSuuryouGoukei;
	
	
}
