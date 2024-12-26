package org.zerock.service;

import java.util.List;

import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.DeliveryVO;
import org.zerock.domain.HinmokuVO;

public interface DeliveryService {
	// 출하 정보 증가 / 出荷情報追加
	void addDelivery(DeliveryVO delivery);

	// 출하 정보 조회 / 出荷情報照会
	DeliveryVO getDelivery(Integer shukkaID);

	// 출하 정보 수정 / 出荷情報修正
	void updateDelivery(DeliveryVO delivery);

	// 출하 정보 삭제 出荷情報削除
	void deleteDelivery(DeliveryVO deliveries);

	// 전체 출하 정보 조회 / 全体出荷情報照会
	public List<DeliveryVO> selectAllDeliveries();

	void saveDelivery(DeliveryVO delivery);

	public List<HinmokuVO> getHinmokuList();

	void insertDeliveries(DeliveryVO delivery);

	public List<CommonHinmokuVO> selectAllHinmokus();

	// 출하 수정 품목 정보 / 出荷修正品目情報
	public List<DeliveryVO> selectShukkaWithHinmoku();

	// 출하 현황 검색 페이지

	List<DeliveryVO> getDelivery();
}
