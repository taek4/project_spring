package org.zerock.service;

import java.util.List;

import org.zerock.domain.HinmokuVO;
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.KessaiVO;
import org.zerock.domain.SaleVO;

//김영민
//金榮珉
public interface SaleService {
    // 모든 판매 데이터 조회 // 全ての販売データを取得
    List<SaleVO> getAllSale();
    
    // 모든 결제 데이터 조회 // 全ての決済データを取得
    List<KessaiVO> getAllKessai();
    
    // 모든 판매 단가 데이터 조회 // 全ての販売単価データを取得
    List<SaleVO> getAllHanbaiTanka();
    
    // 모든 현황 데이터 조회 // 全ての現況データを取得
    List<SaleVO> getAllGenjou();
    
    // 릴리스 처리 // リリース処理
    void processRelease(String hinmokumei,               // 품목명 // 品目名
                        String hitsukeNoRefertype,      // 날짜별 참조 유형 // 日付別参照タイプ
                        int release) throws Exception;  // 릴리스 값 // リリース値
    
    // 판매 데이터 저장 // 販売データを保存
    void saveSale(SaleVO saleVO);

    // 판매 데이터2 저장 // 販売データ2を保存
    void saveSale2(SaleVO saleVO);
    
    // 품목 리스트 조회 // 品目リストを取得
    List<HinmokuVO> getHinmokuLIst();
}