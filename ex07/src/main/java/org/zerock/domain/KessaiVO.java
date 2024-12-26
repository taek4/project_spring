package org.zerock.domain;

import java.util.Date;

import lombok.Data;

//김영민
//金榮珉
@Data
public class KessaiVO {

    private String kessaiID;              // 결제 ID // 決済ID
    private String kessaiyouseishaID;     // 결제 요청자 ID // 決済要請者ID
    private String kessaiyouseibi;        // 결제 요청일 // 決済要請日
    private String torihikisakiID;        // 거래처 ID // 取引先ID
    private String hinmokuID;             // 품목 ID // 品目ID
    private String kessaikingaku;         // 결제 금액 // 決済金額
    private String kessaihouhou;          // 결제 방법 // 決済方法
    private String kessaizyoutai;         // 결제 상태 // 決済状態
    private String shouninbangou;         // 승인 번호 // 承認番号
    private String zaikodenpyo;           // 재고 전표 // 在庫伝票
    private String jyotaibetsushorikinou; // 상태별 처리 기능 // 状態別処理機能
    private String kaikeidenpyo;          // 회계 전표 // 会計伝票
    private String uchiwake;              // 내역 // 内訳

    private String hinmokumei;            // 품목명 // 品目名
    private String torihikisakimei;       // 거래처명 // 取引先名
}
