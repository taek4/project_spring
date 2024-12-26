package org.zerock.domain;

import java.util.List;

import lombok.Data;

/**
 * MitsumorishoVO - 견적서 정보를 담은 VO 클래스
 * MitsumorishoVO - 見積書情報を保持するVOクラス
 */
@Data
public class MitsumorishoVO {

	private String mitsumorishoID; // 견적서 ID
	// 見積書ID

	private String hitsuke; // 작성일 필드
	// 作成日フィールド

	private String no; // 번호
	// 番号

	private String hitsukeNo; // 일자 + 번호
	// 日付 + 番号

	private String hitsukeNoRefertype; // 참조 유형
	// 参照タイプ

	private String gokeiKingaku; // 총 금액
	// 総金額

	private String status; // 상태
	// 状態

	private String zeikomikubun; // 세금 포함 여부
	// 税込み区分

	private String memo; // 메모
	// メモ

	private String sakuseisha; // 작성자
	// 作成者

	private String tsukaID; // 통화 ID
	// 通貨ID

	private String noukiIchija; // 납기 위치
	// 納期位置

	private String suuryou; // 수량
	// 数量

	private String tanka; // 단가
	// 単価

	private String tekiyo; // 적요
	// 摘要

	private String hinmokuMei; // 품목명
	// 品目名

	private String kikaku; // 규격
	// 規格

	private int kyoukyuKingaku; // 공급가액
	// 供給額

	private String mijumunsuuryou; // 미주문 수량
	// 未注文数量

	private String mijumunkyokyukingaku; // 미주문 공급가액
	// 未注文供給額

	private String mijumunbugase; // 미주문 부가세
	// 未注文付加税

	private int otherHinmokuCount; // 첫 번째 품목 외 나머지 개수
	// 最初の品目以外の残りの数量

	private List<CommonHinmokuVO> items; // 품목 리스트
	// 品目リスト

	private String torihikisakiID; // 거래처 ID, null 방지
	// 取引先ID、null防止

	private String torihikisakiMei; // 거래처명
	// 取引先名

	private String tantoushaID; // 담당자 ID
	// 担当者ID

	private String tantoushaMei; // 담당자명
	// 担当者名

	private String soukoID; // 창고 ID
	// 倉庫ID

	private String soukoMei; // 창고명
	// 倉庫名

	private String projectID; // 프로젝트 ID
	// プロジェクトID

	private String projectMeimei; // 프로젝트명
	// プロジェクト名

	private String mitsumorishoRirekiID; // 견적서 이력 ID
	// 見積書履歴ID

	private String seikyuuID; // 청구서 ID
	// 請求書ID

	private String sakuseibi; // 작성일 필드
	// 作成日フィールド

	private String gokeiGaku; // 총 금액
	// 総額

	private List<CommonHinmokuVO> commonHinmokuList; // 공통 품목 리스트
	// 共通品目リスト
}
