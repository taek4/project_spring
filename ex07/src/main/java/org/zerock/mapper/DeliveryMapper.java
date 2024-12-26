package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.DeliveryVO;
import org.zerock.domain.HinmokuVO;

@Mapper
public interface DeliveryMapper {
    // 출하 정보를 ID로 조회 / 出荷情報をIDで紹介
    DeliveryVO selectDeliveryById(Integer shukkaID);
    
    // 전체 출하 정보 조회 / 全体出荷情報紹介
    List<DeliveryVO> selectAllDeliveries();

	// 출하 정보 삽입 / 出荷情報挿入
	void insertDelivery(DeliveryVO delivery);

    // 출하 정보 수정 / 出荷情報修正
    void updateDelivery(DeliveryVO delivery);

    // 출하 정보 삭제 / 出荷情報削除
    void deleteDelivery(DeliveryVO deliveries);
    
    // 출하 ID로 날짜 번호 가져오기 / 出荷IDで日付番号取得
    String getHitsukeNoByDeliveryID(String deliveryID);
    
    // 공통 품목 데이터 삽입 / 共通品目データ挿入
    int insertCommonHinmoku(CommonHinmokuVO commonHinmokuVO);
    
    // 모든 품목 데이터 조회 / 全ての品目データ紹介
    List<HinmokuVO> selectAllHinmokus();
    
    // 출하 데이터 일괄 삽입 / 出荷データ一括挿入
    void insertDeliveries(DeliveryVO delivery);
    
    // 공통 품목 데이터 조회 / 共通品目データ紹介
    List<CommonHinmokuVO> selectCommonHinmoku();
    
    //출하 수정 품목 정보  / 出荷修正品目情報
    List<DeliveryVO> selectShukkaWithHinmoku();
    
    //출하 현황 검색 페이지
    List<DeliveryVO> getDelivery();
    
}
