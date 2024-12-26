package org.zerock.domain;

import lombok.Data;

@Data
public class MasterInfoVO {
    // 프로젝트 정보
    private String projectID;       // 프로젝트 ID
    private String projectMeimei;   // 프로젝트명
    private String ProjectCode;

    // 창고 정보
    private String soukoID;         // 창고 ID
    private String soukomei;        // 창고명
    private String SoukoCode;

    // 담당자 정보
    private String tantoushaID;     // 담당자 ID
    private String tantoushamei;    // 담당자명

    // 거래처 정보
    private String torihikisakiID;  // 거래처 ID
    private String torihikisakimei; // 거래처명
    private String toriTantousha;	// 거래처담당자

    // 통화 정보
    private String tsukaID;     // 통화 코드 (예: KRW, USD)
    private String tsuukaMeimei;    // 통화명
    

    // 담당자 정보 / 担当者情報
    private String TantoushaCode;

    // 거래처 정보 / 取引先情報
    private String torihikisakiMei; // 거래처명
    private String TorihikisakiCode;
    private String renrakusaki;     
    private String yuubinBangou;    
    private String zyuusho;         

}
     
