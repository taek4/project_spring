package org.zerock.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.KessaiVO;
import org.zerock.domain.SaleVO;
import org.zerock.mapper.SaleMapper;

import lombok.extern.log4j.Log4j;

//김영민
//金榮珉
@Service
@Log4j
public class SaleServiceImpl implements SaleService {
	
	@Autowired
	private SaleMapper mapper;

	@Override
	public List<SaleVO> getAllSale() {
		// 모든 판매 데이터 조회 // 全ての販売データを取得
		System.out.println("서비스");
		return mapper.getAllSale();
	}

	@Override
	public List<HinmokuVO> getHinmokuLIst() {
		// 품목 리스트 조회 // 品目リストを取得
		 return mapper.getHinmokuList();
	}
	
	@Override
	public List<SaleVO> getAllHanbaiTanka() {
		// 모든 판매 단가 데이터 조회 // 全ての販売単価データを取得
		 return mapper.getAllHanbaiTanka();
	}
	
	@Override
	public List<SaleVO> getAllGenjou() {
		// 모든 현황 데이터 조회 // 全ての現況データを取得
		return mapper.getAllGenjou();
	}
	
	@Transactional
    @Override
    public void processRelease(String hinmokumei, String hitsukeNoRefertype, int release) throws Exception {
        // 릴리스 처리 // リリース処理
        int updatedRows = mapper.release(hinmokumei, hitsukeNoRefertype, release);

        if (updatedRows == 0) {
            // 릴리스 실패 예외 처리 // リリース失敗例外処理
            throw new Exception("출고 실패: 조건에 맞는 데이터가 없습니다."); // 出庫失敗: 条件に合うデータがありません。
        }
    }
	
	@Override
	public List<KessaiVO> getAllKessai() {
		// 모든 결제 데이터 조회 // 全ての決済データを取得
		System.out.println("결제");
		return mapper.getAllKessai();
	}
	
	@Transactional
	public void saveSale(SaleVO saleVO) {
		// 판매 데이터 저장 // 販売データを保存
		if (saleVO == null || saleVO.getCommonHinmokuList() == null || saleVO.getCommonHinmokuList().isEmpty()) {
			// 유효성 검사 실패 예외 처리 // 有効性検査失敗例外処理
			throw new IllegalArgumentException("판매 또는 품목 리스트가 비어 있습니다."); // 販売または品目リストが空です。
		}

	    log.info("판매 저장 시작: {}"+ saleVO); // 販売保存開始: {}"+ saleVO

	    try {
	        // 판매 삽입 // 販売挿入
	        mapper.insertSale(saleVO);

	        // hitsukeNo 생성 // hitsukeNo生成
	        String hitsuke = saleVO.getHitsuke(); // YYYY-MM-DD
            LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
            String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식 // YYYY/MM/DD形式
            
            String hitsukeNo = formattedHitsuke + "-" + saleVO.getNo(); // hitsukeNo 포맷 // hitsukeNoフォーマット
            
	        // 각 품목 삽입 // 各品目挿入
	        for (CommonHinmokuVO hinmoku : saleVO.getCommonHinmokuList()) {
	            if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
	                // 유효하지 않은 품목 // 無効な品目
	                log.warn("유효하지 않은 품목: {}"+ hinmoku); // 無効な品目: {}"+ hinmoku
	                continue;
	            }

	            // 필요 시 숫자 변환 // 必要に応じて数値変換
	            hinmoku.setSuuryou(hinmoku.getSuuryou().trim()); // 공백 제거 // 空白削除
	            hinmoku.setHitsukeNo(hitsukeNo); // hitsukeNo 설정 // hitsukeNo設定
	            log.info("품목 삽입 시작: {}"+ hinmoku); // 品目挿入開始: {}"+ hinmoku
	            mapper.insertCommonHinmoku(hinmoku); // 개별 품목 삽입 // 個別品目挿入
	        }

	        log.info("판매 저장 완료: {}"+ saleVO); // 販売保存完了: {}"+ saleVO

	    } catch (Exception e) {
	        // 저장 중 오류 발생 // 保存中エラー発生
	        log.error("판매 저장 중 오류 발생: {}"+ e.getMessage(), e); // 販売保存中エラー発生: {}"+ e.getMessage(), e
	        throw e; // 트랜잭션 롤백 // トランザクションロールバック
	    }
	}
	
	@Transactional
	public void saveSale2(SaleVO saleVO) {
		// 판매 데이터2 저장 // 販売データ2を保存
		if (saleVO == null || saleVO.getCommonHinmokuList() == null || saleVO.getCommonHinmokuList().isEmpty()) {
			// 유효성 검사 실패 예외 처리 // 有効性検査失敗例外処理
			throw new IllegalArgumentException("판매 또는 품목 리스트가 비어 있습니다."); // 販売または品目リストが空です。
		}

	    log.info("판매 저장 시작: {}"+ saleVO); // 販売保存開始: {}"+ saleVO

	    try {
	        // 판매 삽입 // 販売挿入
	        mapper.insertSale2(saleVO);

	        // hitsukeNo 생성 // hitsukeNo生成
	        String hitsuke = saleVO.getHitsuke(); // YYYY-MM-DD
            LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
            String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식 // YYYY/MM/DD形式
            
            String hitsukeNo = formattedHitsuke + "-" + saleVO.getNo(); // hitsukeNo 포맷 // hitsukeNoフォーマット
            
	        // 각 품목 삽입 // 各品目挿入
	        for (CommonHinmokuVO hinmoku : saleVO.getCommonHinmokuList()) {
	            if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
	                // 유효하지 않은 품목 // 無効な品目
	                log.warn("유효하지 않은 품목: {}"+ hinmoku); // 無効な品目: {}"+ hinmoku
	                continue;
	            }

	            // 필요 시 숫자 변환 // 必要に応じて数値変換
	            hinmoku.setSuuryou(hinmoku.getSuuryou().trim()); // 공백 제거 // 空白削除
	            hinmoku.setHitsukeNo(hitsukeNo); // hitsukeNo 설정 // hitsukeNo設定
	            log.info("품목 삽입 시작: {}"+ hinmoku); // 品目挿入開始: {}"+ hinmoku
	            mapper.insertCommonHinmoku(hinmoku); // 개별 품목 삽입 // 個別品目挿入
	        }

	        log.info("판매 저장 완료: {}"+ saleVO); // 販売保存完了: {}"+ saleVO

	    } catch (Exception e) {
	        // 저장 중 오류 발생 // 保存中エラー発生
	        log.error("판매 저장 중 오류 발생: {}"+ e.getMessage(), e); // 販売保存中エラー発生: {}"+ e.getMessage(), e
	        throw e; // 트랜잭션 롤백 // トランザクションロールバック
	    }
	}

	private boolean isInvalidStringValue(String value) {
	    // 빈 값이나 유효하지 않은 값 확인 // 空の値または無効な値を確認
	    if (value == null || value.trim().isEmpty()) {
	        return true; // 유효하지 않은 값 // 無効な値
	    }
	    try {
	        int intValue = Integer.parseInt(value.trim());
	        return intValue <= 0; // 0 이하인 경우 유효하지 않음 // 0以下の場合無効
	    } catch (NumberFormatException e) {
	        return true; // 숫자로 변환 불가 // 数値への変換不可
	    }
	}
}
