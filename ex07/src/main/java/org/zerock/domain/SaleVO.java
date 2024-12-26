package org.zerock.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

//김영민
//金榮珉
@Data
public class SaleVO {
    private String hanbaiID; // 판매 ID // 販売ID
    private String hitsuke; // 날짜 // 日付
    private Integer no; // 번호 // 番号
    private String hitsuke_no; // 날짜별 번호 // 日付別番号
    private String hitsukeNoRefertype; // 날짜별 참조 유형 // 日付別参照タイプ
    private String referenceType; // 참조 유형 // 参照タイプ
    private String torihikisakiID; // 거래처 ID // 取引先ID
    private String hinmokuID; // 품목 ID // 品目ID
    private String denpyoID; // 전표 ID // 伝票ID
    private String shukkashoukoID; // 출하 증명 ID // 出荷証明ID
    private String tsukaID; // 통화 ID // 通貨ID
    private String kessaiID; // 결제 ID // 決済ID
    private String projectID; // 프로젝트 ID // プロジェクトID
    private String tantoushaID; // 담당자 ID // 担当者ID
    private String chuumonshoID; // 주문서 ID // 注文書ID
    private String soukoID; // 창고 ID // 倉庫ID
    private String seikyuuID; // 청구서 ID // 請求書ID
    private String hanbaibikou; // 판매 비고 // 販売備考
    private String zeikomikubun; // 세금 포함 구분 // 税込区分

    private String kikaku; // 규격 // 規格
    private String tanka; // 단가 // 単価
    private String tanka_sum; // 단가 합계 // 単価合計
    private String changedTanka; // 변경된 단가 // 変更された単価
    private String suuryou; // 수량 // 数量
    private String bugase; // 부가세 // 付加税
    private String kyoukyuKingaku; // 공급 금액 // 供給金額
    private String kessaikingaku; // 결제 금액 // 決済金額
    private String projectmei; // 프로젝트명 // プロジェクト名
    private String tsuukakoodo; // 통화 코드 // 通貨コード
    private String tsuukamei; // 통화명 // 通貨名
    private String tantoushamei; // 담당자명 // 担当者名
    private String soukomei; // 창고명 // 倉庫名
    private String torihikisakimei; // 거래처명 // 取引先名
    private String hinmokumei; // 품목명 // 品目名
    private String kyoukyuKingaku_sum; // 공급 금액 합계 // 供給金額合計
    private String bugase_sum; // 부가세 합계 // 付加税合計
    private String kessaikingaku_sum; // 결제 금액 합계 // 決済金額合計
    private String hanbaiKingakuGoukei; // 판매 금액 총계 // 販売金額合計
    private String otherHinmokuCount; // 기타 품목 수량 // その他品目数量
    private String status = "진행중"; // 상태 (기본값: "진행중") // 状態 (デフォルト: "進行中")

    private String memo; // 메모 // メモ

    // 공통 품목 리스트 // 共通品目リスト
    private List<CommonHinmokuVO> commonHinmokuList;

    public List<CommonHinmokuVO> getCommonHinmokuList() {
        return commonHinmokuList == null ? new ArrayList<>() : commonHinmokuList;
    }
}
