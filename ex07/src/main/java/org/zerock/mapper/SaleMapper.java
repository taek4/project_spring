package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.KessaiVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.SaleVO;

//김영민
//金榮珉
@Mapper
public interface SaleMapper {
    // 모든 판매 조회 // 全ての販売を取得
    List<SaleVO> getAllSale();
    
    // 모든 결제 조회 // 全ての決済を取得
    List<KessaiVO> getAllKessai();
    
    // 모든 판매 단가 조회 // 全ての販売単価を取得
    List<SaleVO> getAllHanbaiTanka();
    
    // 모든 현황 조회 // 全ての現況を取得
    List<SaleVO> getAllGenjou();
    
    int release(@Param("hinmokumei") String hinmokumei,            // 품목명 // 品目名
                @Param("hitsukeNoRefertype") String hitsukeNoRefertype, // 날짜별 참조 유형 // 日付別参照タイプ
                @Param("release") int release);                  // 릴리스 // リリース

    // 1. 판매 데이터 삽입 // 販売データを挿入
    void insertSale(SaleVO saleVO);

    // 2. 판매 데이터2 삽입 // 販売データ2を挿入
    void insertSale2(SaleVO saleVO);

    // 3. HanbaiID를 이용하여 Hitsuke_No 조회 // HanbaiIDを利用してHitsuke_Noを取得
    String getHitsukeNoBySaleID(String hanbaiID);

    // 4. 공통 품목 데이터 삽입 // 共通品目データを挿入
    int insertCommonHinmoku(CommonHinmokuVO commonHinmokuVO);

    // 품목리스트 조회 // 品目リストを取得
    List<HinmokuVO> getHinmokuList();
}