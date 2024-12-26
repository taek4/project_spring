package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.MitsumorishoVO;
import org.zerock.domain.SeikyuuVO;

/**
 * Mapper Interface for Mitsumorisho
 * 見積書関連のMapperインターフェース
 * 견적서 관련 Mapper 인터페이스
 */
public interface EstimateMapper {

    /**
     * Mitsumorisho 전체 목록 조회
     * Mitsumorishoの全リストを取得
     * 
     * @return MitsumorishoVO 목록
     * @return MitsumorishoVOのリスト
     */
    List<MitsumorishoVO> getList();
    
    /**
     * Mitsumorisho 견적 리스트 조회
     * Mitsumorishoの見積リストを取得
     */
    List<MitsumorishoVO> getEstimateList();

    /**
     * Mitsumorisho 상태 업데이트
     * Mitsumorishoのステータスを更新
     */
    int updateStatus(@Param("mitsumorishoId") int mitsumorishoId, @Param("status") String status);

    /**
     * Mitsumorisho 데이터를 업데이트
     * Mitsumorishoデータを更新
     */
    int updateEstimate(int mitsumorishoId, String date, String trader, String manager, 
                       String warehouse, String transactionType, String currency, String project);

    /**
     * Mitsumorisho 상세 조회
     * Mitsumorishoの詳細を取得
     * 
     * @param mitsumorishoID 조회할 Mitsumorisho의 ID
     * @param mitsumorishoID 取得するMitsumorishoのID
     * @return MitsumorishoVO 객체
     * @return MitsumorishoVOオブジェクト
     */
    MitsumorishoVO read(Long mitsumorishoID);

    /**
     * Mitsumorisho 데이터를 업데이트
     * Mitsumorishoデータを更新
     */
    int update(MitsumorishoVO mitsumorisho);

    /**
     * Mitsumorisho 데이터를 삭제
     * Mitsumorishoデータを削除
     */
    int delete(Long mitsumorishoID);

    /**
     * Mitsumorisho 상태 업데이트
     * Mitsumorishoのステータスを更新
     */
    int updateStatus(@Param("id") Long id, @Param("status") String status);

    /**
     * 창고 ID로 Mitsumorisho 조회
     * 倉庫IDでMitsumorishoを検索
     */
    List<MitsumorishoVO> findBySoukoID(@Param("soukoID") Long soukoID);

    /**
     * 거래처 ID로 Mitsumorisho 조회
     * 取引先IDでMitsumorishoを検索
     */
    List<MitsumorishoVO> findByTorihikisakiID(@Param("torihikisakiID") Long torihikisakiID);

    /**
     * 상태로 Mitsumorisho 조회
     * ステータスでMitsumorishoを検索
     */
    List<MitsumorishoVO> findByStatus(@Param("status") String status);
    
    /**
     * 견적서 데이터 삽입
     * 見積書データを挿入
     */
    void insertEstimate(MitsumorishoVO mitsumorishoVO);
    
    /**
     * MitsumorishoID를 이용하여 Hitsuke_No 조회
     * MitsumorishoIDを使用してHitsuke_Noを取得
     */
    String getHitsukeNoByMitsumorishoID(String mitsumorishoID);
    
    /**
     * 공통 품목 데이터 삽입
     * 共通品目データを挿入
     */
    int insertCommonHinmoku(CommonHinmokuVO commonHinmokuVO);

    /**
     * 품목 리스트 조회
     * 品目リストを取得
     */
    List<HinmokuVO> getHinmokuList();

    /**
     * ID를 기준으로 Mitsumorisho 상세 조회
     * IDを基準にMitsumorishoの詳細を取得
     */
    MitsumorishoVO selectMitsumorishoById(@Param("id") String id);
    
    /**
     * 공통 품목 데이터를 업데이트
     * 共通品目データを更新
     */
    void updateCommonHinmoku(CommonHinmokuVO hinmoku);
    
    /**
     * 모든 공통 품목 데이터 조회
     * 全ての共通品目データを取得
     */
    List<CommonHinmokuVO> selectAllCommonHinmoku();
    
    /**
     * 미주문 현황 데이터 조회
     * 未注文状況データを取得
     */
    List<MitsumorishoVO> getMijumun();
    
    /**
     * 모든 Mitsumorisho 데이터를 조회
     * 全てのMitsumorishoデータを取得
     */
    List<MitsumorishoVO> getMitsumorisho();

	List<SeikyuuVO> selectAllSeikyuu(String id);
}
