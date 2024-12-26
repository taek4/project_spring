package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.ShipmentVO;

public interface ShipmentMapper {

    // 모든 출하 지시서 목록 가져오기
    // 全ての出荷指示書リストを取得
    List<ShipmentVO> getList();
    
    // 공통 품목 목록 가져오기
    // 共通品目リストを取得
    List<CommonHinmokuVO> getAllCommonHinmoku();
    
    // 재고 품목 목록 가져오기
    // 在庫品目リストを取得
    List<HinmokuVO> getAllHinmoku();
    
    // 출하지시서 삽입
    // 出荷指示書を挿入
    int insertshipment(ShipmentVO shipment);
    
    // 출하 상태 업데이트
    // 出荷状態を更新
    int taiupdate(@Param("shukkaShiziShoukaiID") int shukkaShiziShoukaiID, 
                  @Param("shinkouZyoutai") String shinkouZyoutai);
    
    // 일자-번호(Hitsuke_No)로 출하 정보 가져오기
    // 日付-番号(Hitsuke_No)で出荷情報を取得
    List<ShipmentVO> getShipmentByHitsukeNo(@Param("hitsuke_No") String hitsuke_No);
    
    // 품목 데이터 삽입
    // 品目データを挿入
    int hinmokuinsert(CommonHinmokuVO commonHinmoku);
    
    // 품목 데이터 업데이트
    // 品目データを更新
    int hinmokuupdate(ShipmentVO shipment);
    
    // 출하지시서 업데이트
    // 出荷指示書を更新
    int shipmentupdate(ShipmentVO shipment);
    
    // 출하 정보 수정
    // 出荷情報を修正
    int shipmentcorrection(ShipmentVO shipment);
    
    // 공통 품목 삭제
    // 共通品目を削除
    int deleteCommonHinmoku(@Param("shukkaShiziShoukaiID") int shukkaShiziShoukaiID);

    List<ShipmentVO> statusList(Map<String, Object> params);
}
