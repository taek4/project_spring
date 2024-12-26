package org.zerock.mapper;

import java.util.List;
import org.zerock.domain.SeikyuuVO;

/**
 * Mapper Interface for Seikyuu
 * 請求関連のMapperインターフェース
 * 전표 관련 Mapper 인터페이스
 */
public interface SeikyuuMapper {

    /**
     * 견적서 ID로 전표 데이터를 조회한다.
     * 見積書IDで請求データを取得する
     *
     * @param mitsumorishoID 견적서 ID
     * @param mitsumorishoID 見積書ID
     * @return 전표 목록
     * @return 請求リスト
     */
    SeikyuuVO selectSeikyuuByMitsumorishoID(int mitsumorishoID);

    /**
     * 전체 전표 데이터를 조회한다.
     * 全ての請求データを取得する
     *
     * @return 전체 전표 목록
     * @return 全ての請求リスト
     */
    List<SeikyuuVO> selectAllSeikyuu();
}
