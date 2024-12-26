package org.zerock.service;

import java.util.List;
import org.zerock.domain.SeikyuuVO;

/**
 * Service Interface for Seikyuu
 * 請求関連のサービスインターフェース
 * 전표 관련 서비스 인터페이스
 */
public interface SeikyuuService {

    /**
     * 견적서 ID를 기준으로 생성된 전표 목록을 가져온다.
     * 見積書IDを基準に生成された請求書リストを取得する
     *
     * @param mitsumorishoID 견적서 ID
     * @param mitsumorishoID 見積書ID
     * @return 생성된 전표 목록
     * @return 生成された請求書リスト
     */
    SeikyuuVO getSeikyuuByMitsumorishoID(int mitsumorishoID);

    /**
     * 전체 전표 목록을 가져온다.
     * 全ての請求書リストを取得する
     *
     * @return 전체 전표 목록
     * @return 全ての請求書リスト
     */
    List<SeikyuuVO> getAllSeikyuu();

	static List<SeikyuuVO> selectAllSeikyuu(String id) {
		// TODO Auto-generated method stub
		return null;
	}
}
