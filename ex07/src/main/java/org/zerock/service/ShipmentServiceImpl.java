package org.zerock.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.OrderVO;
import org.zerock.domain.ShipmentVO;
import org.zerock.mapper.ShipmentMapper;

import lombok.extern.log4j.Log4j;

/**
 * ShipmentServiceImpl 클래스
 * ShipmentService 인터페이스를 구현하여 출하지시서 및 품목 관련 비즈니스 로직을 처리
 * ShipmentServiceインターフェースを実装して、出荷指示書および品目に関するビジネスロジックを処理
 */
@Service
@Log4j
public class ShipmentServiceImpl implements ShipmentService {

    @Autowired
    private ShipmentMapper shipmentMapper;

    /**
     * 모든 출하지시서를 조회합니다.
     * 全ての出荷指示書を照会します。
     * @return List<ShipmentVO> 출하지시서 목록
     *                          出荷指示書リスト
     */
    @Override
    public List<ShipmentVO> getList() {
        log.info("전체 출하지시서 조회 요청");
        log.info("全ての出荷指示書の照会リクエスト");
        return shipmentMapper.getList();
    }

    /**
     * 품목 테이블(Hinmoku)의 모든 데이터를 조회합니다.
     * 品目テーブル(Hinmoku)の全てのデータを照会します。
     * @return List<HinmokuVO> 품목 목록
     *                          品目リスト
     */
    @Override
    public List<HinmokuVO> getAllHinmoku() {
        log.info("전체 품목 조회 요청");
        log.info("全ての品目照会リクエスト");
        return shipmentMapper.getAllHinmoku();
    }

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
    @Override
    public int taiupdate(int shukkaShiziShoukaiID, String shinkouZyoutai) {
        log.info("출하지시서 상태 업데이트 요청: ID=" + shukkaShiziShoukaiID + ", 상태=" + shinkouZyoutai);
        log.info("出荷指示書状態更新リクエスト: ID=" + shukkaShiziShoukaiID + ", 状態=" + shinkouZyoutai);
        return shipmentMapper.taiupdate(shukkaShiziShoukaiID, shinkouZyoutai);
    }

    /**
     * 특정 hitsuke_No로 출하지시서를 조회합니다.
     * 特定のhitsuke_Noで出荷指示書を照会します。
     * @param hitsuke_No 조회할 일자-주문번호(hitsuke_No)
     *                   照会する日付-注文番号(hitsuke_No)
     * @return ShipmentVO 조회된 출하지시서 데이터
     *                    照会された出荷指示書データ
     */
    @Override
    public ShipmentVO getShipmentByHitsukeNo(String hitsuke_No) {
        List<ShipmentVO> shipments = shipmentMapper.getShipmentByHitsukeNo(hitsuke_No);
        if (shipments.isEmpty()) {
            return null; // 데이터가 없는 경우
                        // データが存在しない場合
        }
        return shipments.get(0); // 첫 번째 결과만 반환
                                // 最初の結果のみを返却
    }

    /**
     * 출하지시서를 수정합니다.
     * 出荷指示書を修正します。
     * @param shipment 수정할 출하지시서 데이터
     *                 修正する出荷指示書データ
     * @return int 성공 시 1 반환
     *             成功時1を返却
     */
    @Override
    public int shipmentcorrection(ShipmentVO shipment) {
        log.info("출하지시서 수정 요청: " + shipment);
        log.info("出荷指示書修正リクエスト: " + shipment);

        // 1. 출하지시서 기본 정보 업데이트
        // 1. 出荷指示書基本情報を更新
        int result = shipmentMapper.shipmentcorrection(shipment);

        // 2. 기존 품목 데이터 삭제 후 새로운 품목 데이터 삽입
        // 2. 既存の品目データを削除し、新しい品目データを挿入
        if (shipment.getCommonHinmokuList() != null && !shipment.getCommonHinmokuList().isEmpty()) {
            for (CommonHinmokuVO commonHinmoku : shipment.getCommonHinmokuList()) {
                commonHinmoku.setShukkaShiziShoukaiID(shipment.getShukkaShiziShoukaiID());
                shipmentMapper.hinmokuinsert(commonHinmoku);
            }
        }

        return result;
    }

    @Transactional
    public void saveshipment(ShipmentVO shipment) {
        if (shipment == null || shipment.getCommonHinmokuList() == null || shipment.getCommonHinmokuList().isEmpty()) {
            throw new IllegalArgumentException("指示書または品目リストが空です。"); //품목리스트가 비어있습니다.
        }

        log.info("지시서 저장 시작: {}" + shipment);
        log.info("指示書保存開始: {}" + shipment);

        try {
            // 지시서 삽입
            // 指示書挿入
            shipmentMapper.insertshipment(shipment);

            // hitsukeNo 생성
            // hitsukeNo生成
            String hitsuke = shipment.getHitsuke(); // YYYY-MM-DD
            LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
            String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식
            
            String hitsuke_No = formattedHitsuke + "-" + shipment.getNo();

            // 각 품목 삽입
            // 各品目を挿入
            for (CommonHinmokuVO hinmoku : shipment.getCommonHinmokuList()) {
                if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
                    log.warn("유효하지 않은 품목: {}" + hinmoku);
                    log.warn("無効な品目: {}" + hinmoku);
                    continue;
                }

                hinmoku.setSuuryou(hinmoku.getSuuryou().trim()); // 공백 제거
                hinmoku.setHitsuke_No(hitsuke_No);
                log.info("품목 삽입 시작: {}" + hinmoku);
                log.info("品目挿入開始: {}" + hinmoku);
                shipmentMapper.hinmokuinsert(hinmoku); // 개별 품목 삽입
                                                       // 個別品目挿入
            }

            log.info("지시서 저장 완료: {}" + shipment);
            log.info("指示書保存完了: {}" + shipment);

        } catch (Exception e) {
            log.error("지시서 저장 중 오류 발생: {}" + e.getMessage(), e);
            log.error("指示書保存中にエラー発生: {}" + e.getMessage(), e);
            throw e; // 트랜잭션 롤백
                     // トランザクションロールバック
        }
    }
    private boolean isInvalidStringValue(String value) {
        // 빈 값이나 유효하지 않은 값 확인
        // 空の値または無効な値を確認
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
            // 数値への変換不可
        }
    }
    
    @Override
    public int hinmokuinsert(CommonHinmokuVO commonHinmoku) {
        try {
            // Mapper를 사용하여 데이터베이스에 삽입 실행
            // Mapperを使用してデータベースに挿入実行
            return shipmentMapper.hinmokuinsert(commonHinmoku);
        } catch (Exception e) {
            // 오류 발생 시 로깅 및 예외 처리
            // エラー発生時のログと例外処理
            e.printStackTrace();
            throw new RuntimeException("Failed to insert Hinmoku", e);
        }
    }
    
    @Transactional
    @Override
    public int hinmokuupdate(ShipmentVO shipment) {
        log.info("출하지시서 수정 요청: " + shipment);
        // 出荷指示書の修正リクエスト: " + shipment);

        // 1. 출하지시서 기본 정보 업데이트
        // 1. 出荷指示書の基本情報を更新
        int result = shipmentMapper.shipmentupdate(shipment);
        
        // 2. 두 번째 테이블 업데이트
        // 2. 2番目のテーブルを更新
        int result2 = shipmentMapper.hinmokuupdate(shipment);

        // 두 업데이트가 모두 성공했는지 확인
        // 両方の更新が成功したかを確認
        if (result > 0 && result2 > 0) {
            return 1; // 성공 시 1 반환
            // 成功の場合は1を返す
        } else {
            throw new RuntimeException("업데이트 실패: 하나 이상의 업데이트 작업이 실패했습니다.");
            // 更新失敗: 1つ以上の更新作業が失敗しました。
        }
    }
    
    @Override
    public List<ShipmentVO> statusList(Map<String, Object> params) {
        return shipmentMapper.statusList(params);
    }
}
