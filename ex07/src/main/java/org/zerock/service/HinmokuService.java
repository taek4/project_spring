package org.zerock.service;

import java.util.List;

import org.zerock.domain.HinmokuVO;

/**
 * Service Interface for Hinmoku
 * 品目関連のサービスインターフェース
 * 품목 관련 서비스 인터페이스
 */
public interface HinmokuService {

    /**
     * 모든 품목 데이터를 조회
     * 全ての品目データを取得
     *
     * @return 품목 목록
     * @return 品目リスト
     */
    List<HinmokuVO> getAllHinmoku();
}
