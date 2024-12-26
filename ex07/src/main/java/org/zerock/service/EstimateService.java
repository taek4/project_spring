package org.zerock.service;

import java.util.List;

import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.MitsumorishoVO;
import org.zerock.domain.SeikyuuVO;

public interface EstimateService {

	// 견적서 목록을 가져옴
	// 見積書の一覧を取得する
	List<MitsumorishoVO> getList();

	// 품목 목록을 가져옴
	// 品目の一覧を取得する
	List<HinmokuVO> getHinmokuList();

	// 모든 공통 품목을 가져옴
	// すべての共通品目を取得する
	List<CommonHinmokuVO> getAllCommonHinmoku();

	// 견적서 상태를 업데이트함
	// 見積書のステータスを更新する
	int updateStatus(int mitsumorishoId, String status);

	// 견적서를 업데이트함
	// 見積書を更新する
	int updateEstimate(int mitsumorishoId, String date, String trader, String manager, String warehouse,
			String transactionType, String currency, String project);

	// 공통 품목을 삽입함 (Insert 메서드)
	// 共通品目を挿入する (Insert メソッド)
	void insertCommonHinmoku(CommonHinmokuVO hinmoku);

	// 견적서를 저장함 (Insert 입력 저장 메서드)
	// 見積書を保存する (Insert 入力保存メソッド)
	void saveEstimate(MitsumorishoVO mitsumorishoVO);

	// 공통 품목을 업데이트함 (Update 메서드)
	// 共通品目を更新する (Update メソッド)
	void updateCommonHinmoku(CommonHinmokuVO hinmoku);

	// 견적서 ID로 견적서를 가져옴 (정적 메서드)
	// 見積書IDで見積書を取得する (静的メソッド)
	static MitsumorishoVO getMitsumorishoById(String id) {
		return null;
	}

	// ID를 기준으로 Seikyuu 데이터를 가져옴
	// IDを基準にSeikyuuデータを取得

	// @param id 견적서 ID
	// @param id 見積書ID
	// @return Seikyuu 데이터 목록
	// return Seikyuuデータのリスト

	List<SeikyuuVO> selectAllSeikyuu(String id);

	// 미주문 견적서를 가져옴
	// 未注文の見積書を取得する
	List<MitsumorishoVO> getMijumun();

	// 모든 견적서를 가져옴
	// すべての見積書を取得する
	List<MitsumorishoVO> getMitsumorisho();

}
