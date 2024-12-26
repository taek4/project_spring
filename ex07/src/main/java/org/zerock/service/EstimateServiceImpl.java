package org.zerock.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.MitsumorishoVO;
import org.zerock.domain.SeikyuuVO;
import org.zerock.mapper.EstimateMapper;

import lombok.extern.log4j.Log4j;

/**
 * Estimate Service Implementation - 견적서 관련 서비스 구현체 見積書関連サービスの実装クラス
 */
@Service
@Log4j
public class EstimateServiceImpl implements EstimateService {

	@Autowired
	private EstimateMapper mapper; // 의존성 주입된 EstimateMapper
	// DIされたEstimateMapper

	@Autowired
	private EstimateMapper estimatemapper;

	@Override
	public List<MitsumorishoVO> getList() {
		log.info("getList() 실행");
		// getList() 実行
		return mapper.getList();
	}

	@Override
	public int updateStatus(int mitsumorishoId, String status) {
		int result = 0;
		try {
			// Mapper를 호출하여 상태 업데이트
			// Mapperを呼び出してステータスを更新
			result = mapper.updateStatus(mitsumorishoId, status); // 반환값으로 업데이트된 행 수
			// 戻り値は更新された行数
		} catch (Exception e) {
			log.error("업데이트 중 오류 발생", e);
			// 更新中にエラーが発生
		}
		return result;
	}

	@Override
	public int updateEstimate(int mitsumorishoId, String date, String trader, String manager, String warehouse,
			String transactionType, String currency, String project) {
		// 견적서 업데이트 메서드 호출
		// 見積書の更新メソッドを呼び出し
		return mapper.updateEstimate(mitsumorishoId, date, trader, manager, warehouse, transactionType, currency,
				project);
	}

	@Autowired
	private EstimateMapper mitsumorishoMapper; // 추가된 의존성 주입
	// 追加されたDIされたMapper

	public MitsumorishoVO getMitsumorishoById(String id) {
		log.info("getMitsumorishoById() 실행: ID = " + id);
		// getMitsumorishoById() 実行: ID = " + id
		return mitsumorishoMapper.selectMitsumorishoById(id);
	}

	@Override
	public List<HinmokuVO> getHinmokuList() {
		// 품목 리스트를 가져옴
		// 品目リストを取得
		return mapper.getHinmokuList();
	}

	@Transactional
	public void saveEstimate(MitsumorishoVO mitsumorishoVO) {
		if (mitsumorishoVO == null || mitsumorishoVO.getCommonHinmokuList() == null
				|| mitsumorishoVO.getCommonHinmokuList().isEmpty()) {
			throw new IllegalArgumentException("견적서 또는 품목 리스트가 비어 있습니다.");
			// 見積書または品目リストが空です。
		}

		try {
			// 견적서 삽입
			// 見積書を挿入
			mapper.insertEstimate(mitsumorishoVO);

			// hitsukeNo 생성
			// hitsukeNo 作成
			String hitsuke = mitsumorishoVO.getHitsuke(); // YYYY-MM-DD
			LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
			String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식

			String hitsukeNo = formattedHitsuke + "-" + mitsumorishoVO.getNo();

			// 각 품목 삽입
			// 各品目を挿入
			for (CommonHinmokuVO hinmoku : mitsumorishoVO.getCommonHinmokuList()) {
				if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
					continue;
				}

				// 필요 시 숫자 변환
				// 必要に応じて数値に変換
				hinmoku.setSuuryou(hinmoku.getSuuryou().trim()); // 공백 제거
				hinmoku.setHitsukeNo(hitsukeNo);

				mapper.insertCommonHinmoku(hinmoku); // 개별 품목 삽입
				// 個別品目を挿入
			}

			log.info("견적서 저장 완료: {}" + mitsumorishoVO);
			// 見積書の保存が完了: {}" + mitsumorishoVO

		} catch (Exception e) {
			log.error("견적서 저장 중 오류 발생: {}" + e.getMessage(), e);
			// 見積書保存中にエラーが発生: {}" + e.getMessage()
			throw e; // 트랜잭션 롤백
			// トランザクションロールバック
		}
	}

	private boolean isInvalidStringValue(String value) {
		// 빈 값이나 유효하지 않은 값 확인
		// 空の値や無効な値を確認
		if (value == null || value.trim().isEmpty()) {
			return true; // 유효하지 않은 값
			// 無効な値
		}
		try {
			int intValue = Integer.parseInt(value.trim());
			return intValue <= 0; // 0 이하인 경우 유효하지 않음
			// 0以下の場合は無効
		} catch (NumberFormatException e) {
			return true; // 숫자로 변환 불가
			// 数値に変換できない
		}
	}

	@Override
	public void insertCommonHinmoku(CommonHinmokuVO hinmoku) {
		// 공통 품목을 삽입
		// 共通品目を挿入
		estimatemapper.insertCommonHinmoku(hinmoku);
	}

	@Override
	public void updateCommonHinmoku(CommonHinmokuVO hinmoku) {
		// 공통 품목을 업데이트
		// 共通品目を更新
		estimatemapper.updateCommonHinmoku(hinmoku);
	}

	@Override
	public List<CommonHinmokuVO> getAllCommonHinmoku() {
		// Mapper를 호출하여 데이터를 가져옵니다
		// Mapperを呼び出してデータを取得
		List<CommonHinmokuVO> commonHinmokuList = mapper.selectAllCommonHinmoku();

		// Null 체크 후 빈 리스트 반환
		// Nullチェック後、空リストを返す
		if (commonHinmokuList == null) {
			commonHinmokuList = new ArrayList<>();
		}

		return commonHinmokuList;
	}

	@Override
	public List<SeikyuuVO> selectAllSeikyuu(String id) {
		// SeikyuuService를 호출하여 데이터 조회
		// SeikyuuServiceを呼び出してデータを取得
		return estimatemapper.selectAllSeikyuu(id);
	}

	@Override
	public List<MitsumorishoVO> getMijumun() {
		// 미주문 데이터를 가져옴
		// 未注文データを取得
		return estimatemapper.getMijumun();
	}

	@Override
	public List<MitsumorishoVO> getMitsumorisho() {
		// 모든 견적서를 가져옴
		// すべての見積書を取得
		return estimatemapper.getMitsumorisho();
	}
}
