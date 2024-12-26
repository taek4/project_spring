package org.zerock.domain;


import java.util.List;

import lombok.Data;
@Data 
public class ShipmentVO {
	private int shukkaShiziShoukaiID; //출하지시서ID
	private String hitsuke_No_refertype;
	private String hitsuke; //일자
	private String otherHinmokuCount;
	private int no;//주문서번호
	private String hitsuke_No;//일자와 주문서 번호 결합(고유 식별자)
	private int torihikisakiID;// 거래처ID
	private int tantoushaID;//담당자ID
	private int soukoID; //창고ID
	private int projectID; //프로젝트 ID
	private int hinmokuID;//품목ID
	private String itemName;
	private String itemCode;
	private String shinkouZyoutai;//진행상태
	private String shukkaYoteibi; //출하예정일
	private int suuryouGoukei;//수량 합계
	private String kikaku;
	private int suuryou;
	private String kubun; //구분
	private String yuubinBangou;//우편번호
	private String tekiyouYoushiki;//적용양식
	private String torihikisakiMei; //거래처명
	private String tantoushaMei; //담당자명
	private String soukoMei;//창고명
	private String projectMeimei;//프로젝트명
	private String renrakusaki; //연락처
	private List<CommonHinmokuVO> commonHinmokuList;
	private List<HinmokuVO> hinmokuList;
	
	
    private String hitsukeNo;         // 일자-No (결합 필드)
    private String hitsukeNoRefertype;
    
    private String mihanbaisuuryou;
    private String mihanbaikyoukyukingaku;
    private String mihanbaibugase;
    
    private String hinmokuMei;        // 품목명
    
    private String jumunKingakuGoukei;// 주문 금액 합계
    private String status;            // 진행 상태 (예: 진행중, 확인, 완료)
    
    private String commonHinmokuID; // 공통 품목 ID
    private String referenceType; // 참조 유형
    private String tanka;         // 단가
    private String kyoukyuKingaku; // 공급 가액
    private String bugase;        // 부가세
    private String tekiyo;        // 적요
    private String noukiIchija;     // 납기일자
    
    private String goukei;

    // 통화 정보
    private String tsukaID;     // 통화 코드 (예: KRW, USD)
    private String tsuukaMeimei;    // 통화명

}

