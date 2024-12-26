package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.HinmokuVO;

/**
 * Mapper Interface for Hinmoku
 * 品目関連のMapperインターフェース
 * 품목 관련 Mapper 인터페이스
 */
public interface HinmokuMapper {

    /**
     * 모든 품목 데이터를 조회
     * 全ての品目データを取得
     * 
     * @return HinmokuVO 목록
     * @return HinmokuVOのリスト
     */
    List<HinmokuVO> selectAllHinmoku();
}
