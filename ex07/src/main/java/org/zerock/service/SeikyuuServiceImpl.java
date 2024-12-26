package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.SeikyuuVO;
import org.zerock.mapper.SeikyuuMapper;

import lombok.RequiredArgsConstructor;

/**
 * Service Implementation for Seikyuu
 * 請求関連のサービス実装クラス
 * 전표 관련 서비스 구현 클래스
 */
@Service
@RequiredArgsConstructor
public class SeikyuuServiceImpl implements SeikyuuService {

    private final SeikyuuMapper seikyuuMapper; // SeikyuuMapper 의존성 주입
    // SeikyuuMapperの依存性注入

    /**
     * 견적서 ID를 기준으로 생성된 전표 목록을 가져온다.
     * 見積書IDを基準に生成された請求書リストを取得する
     *
     * @param mitsumorishoID 견적서 ID
     * @param mitsumorishoID 見積書ID
     * @return 생성된 전표 목록
     * @return 生成された請求書リスト
     */
    @Override
    public SeikyuuVO getSeikyuuByMitsumorishoID(int mitsumorishoID) {
        return seikyuuMapper.selectSeikyuuByMitsumorishoID(mitsumorishoID); // Mapper 호출
        // Mapperを呼び出し
    }

    /**
     * 전체 전표 목록을 가져온다.
     * 全ての請求書リストを取得する
     *
     * @return 전체 전표 목록
     * @return 全ての請求書リスト
     */
    @Override
    public List<SeikyuuVO> getAllSeikyuu() {
        return seikyuuMapper.selectAllSeikyuu(); // Mapper 호출
        // Mapperを呼び出し
    }
}
