package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class SeikyuuVO {

	private String seikyuuID; // 전표 ID (請求ID)
	private String mitsumorishoID; // 견적서 ID (外部キー, 見積書ID)
	private String jumunshoID; // 주문서 ID (外部キー, 注文書ID)
	private String hanbaiID; // 판매 ID (外部キー, 販売ID)
	private String shukkaShiziShoukaiID; // 출하지시서 ID (外部キー, 出荷指示紹介ID)
	private String shukkaID; // 출하 ID (外部キー, 出荷ID)
	private String seikyuuBi; // 전표 생성 날짜 (請求日)
	private String sakuseisha; // 작성자 (作成者)
	private String gokeiGaku; // 총 금액 (合計額)
	private String hinmokumei; // 품목명 (品目名)
	private String kikaku; // 규격 (規格)
	private String suryou; // 수량 (数量)
	private String zanryou; // 잔량 (残量)

	private List<HinmokuVO> commonHinmokuList; // 품목 리스트  // 品目リスト
}
