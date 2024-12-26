package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.ShipmentVO;

/**
 * ShipmentService 인터페이스
 * 출하지시서 및 관련 데이터를 처리하는 서비스 레이어의 인터페이스 정의
 * 出荷指示書および関連データを処理するサービス層のインターフェース定義
 */
public interface ShipmentService {

    /**
     * 모든 출하지시서를 조회합니다.
     * 全ての出荷指示書を照会します。
     * @return List<ShipmentVO> 출하지시서 목록
     *                          出荷指示書リスト
     */
    List<ShipmentVO> getList();

    /**
     * 품목(Hinmoku) 테이블의 모든 데이터를 조회합니다.
     * 品目(Hinmoku)テーブルの全てのデータを照会します。
     * @return List<HinmokuVO> 품목 목록
     *                          品目リスト
     */
    List<HinmokuVO> getAllHinmoku();

    /**
     * 새로운 출하지시서를 추가합니다.
     * 新しい出荷指示書を追加します。
     * @param shipment 추가할 출하지시서 데이터
     *                 追加する出荷指示書データ
     */
    void saveshipment(ShipmentVO shipment);

    /**
     * 출하지시서의 진행 상태를 업데이트합니다.
     * 出荷指示書の進行状態を更新します。
     * @param shukkaShiziShoukaiID 업데이트할 출하지시서 ID
     *                             更新する出荷指示書ID
     * @param shinkouZyoutai 새로운 진행 상태
     *                      新しい進行状態
     * @return int 업데이트된 행의 수
     *             更新された行の数
     */
    int taiupdate(int shukkaShiziShoukaiID, String shinkouZyoutai);

    /**
     * 출하지시서를 수정합니다.
     * 出荷指示書を修正します。
     * @param shipment 수정할 출하지시서 데이터
     *                 修正する出荷指示書データ
     * @return int 성공 시 1 반환
     *             成功時1を返却
     */
    int shipmentcorrection(ShipmentVO shipment); 

    /**
     * 출하지시서 데이터를 업데이트합니다.
     * 出荷指示書データを更新します。
     * @param shipment 업데이트할 출하지시서 데이터
     *                 更新する出荷指示書データ
     * @return int 성공 시 1 반환
     *             成功時1を返却
     */
    int hinmokuupdate(ShipmentVO shipment);

    /**
     * 특정 hitsuke_No에 해당하는 출하지시서를 조회합니다.
     * 特定のhitsuke_Noに該当する出荷指示書を照会します。
     * @param hitsuke_No 조회할 일자-주문번호(hitsuke_No)
     *                   照会する日付-注文番号(hitsuke_No)
     * @return ShipmentVO 조회된 출하지시서 데이터
     *                    照会された出荷指示書データ
     */
    ShipmentVO getShipmentByHitsukeNo(String hitsuke_No);

    /**
     * 품목 데이터를 삽입합니다.
     * 品目データを挿入します。
     * @param commonhinmokuVO 삽입할 품목 데이터
     *                        挿入する品目データ
     * @return int 성공 시 1 반환
     *             成功時1を返却
     */
    int hinmokuinsert(CommonHinmokuVO commonhinmokuVO);
    
    List<ShipmentVO> statusList(Map<String, Object> params);

}
