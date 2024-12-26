package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.HinmokuVO;
import org.zerock.mapper.HinmokuMapper;

/**
 * Service Implementation for Hinmoku
 * 品目関連のサービス実装クラス
 * 품목 관련 서비스 구현 클래스
 */
@Service
public class HinmokuServiceImpl implements HinmokuService {

    @Autowired
    private HinmokuMapper hinmokuMapper; // HinmokuMapper 의존성 주입
    // HinmokuMapperの依存性注入

    /**
     * 모든 품목 데이터를 조회
     * 全ての品目データを取得
     *
     * @return 품목 목록
     * @return 品目リスト
     */
    @Override
    public List<HinmokuVO> getAllHinmoku() {
        return hinmokuMapper.selectAllHinmoku(); // Mapper를 호출하여 데이터 조회
        // Mapperを呼び出してデータを取得
    }
}
