package org.zerock.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.DeliveryVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.mapper.DeliveryMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	private DeliveryMapper deliveryMapper;

	@Override
	public List<HinmokuVO> getHinmokuList() {
		// TODO Auto-generated method stub
		return deliveryMapper.selectAllHinmokus();
	}

	@Override
	public List<DeliveryVO> selectShukkaWithHinmoku() {
		// TODO Auto-generated method stub
		return deliveryMapper.selectShukkaWithHinmoku();
	}

	@Transactional
	public void saveDelivery(DeliveryVO delivery) {
		// TODO Auto-generated method stub
		if (delivery == null || delivery.getCommonHinmokuList() == null || delivery.getCommonHinmokuList().isEmpty()) {
			throw new IllegalArgumentException("出荷書または品目リストが空欄の状態です。");
		}

		log.info("出荷書保存初め:{}" + delivery);

		try {
			// 出荷書挿入 / 출하서 삽입
			deliveryMapper.insertDelivery(delivery);

			// hitsukeNo生成 / 생성
			String hitsuke = delivery.getHitsuke(); // YYYY-MM-DD
			LocalDate localDate = LocalDate.parse(hitsuke); // String -> LocalDate
			String formattedHitsuke = localDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); // YYYY/MM/DD 형식

			String hitsukeNo = formattedHitsuke + "-" + delivery.getNo();

			// 각 품목 삽입
			for (CommonHinmokuVO hinmoku : delivery.getCommonHinmokuList()) {
				if (hinmoku == null || isInvalidStringValue(hinmoku.getSuuryou())) {
					log.info("有効でない品目:{}" + hinmoku);
					continue;
				}

				// 必要時に数字返還 / 필요시 숫자 변환
				hinmoku.setSuuryou(hinmoku.getSuuryou().trim());
				hinmoku.setHitsuke_No(hitsukeNo);
				log.info("品目挿入開始:{}" + hinmoku);
				deliveryMapper.insertCommonHinmoku(hinmoku);
			}

			log.info("出荷書保存完了:{}" + delivery);

		} catch (Exception e) {
			log.error("出荷書保存中エラー発生:{}" + e.getMessage(), e);
			throw e;
		}
	}

	@Override
	public List<CommonHinmokuVO> selectAllHinmokus() {
		// TODO Auto-generated method stub
		return deliveryMapper.selectCommonHinmoku();
	}

	private boolean isInvalidStringValue(String value) {
		if (value == null || value.trim().isEmpty()) {
			return true;
		}
		try {
			int intValue = Integer.parseInt(value.trim());
			return intValue <= 0;
		} catch (NumberFormatException e) {
			return true;
		}
	}

	@Override
	public void addDelivery(DeliveryVO delivery) {
		log.info("Adding delivery: " + delivery);
		deliveryMapper.insertDelivery(delivery);
	}

	@Override
	public DeliveryVO getDelivery(Integer shukkaID) {
		log.info("Fetching delivery with ID: " + shukkaID);
		return deliveryMapper.selectDeliveryById(shukkaID);
	}

	public DeliveryServiceImpl(DeliveryMapper deliveryMapper) {
		this.deliveryMapper = deliveryMapper;
	}

	@Override
	public void updateDelivery(DeliveryVO delivery) {
		// TODO Auto-generated method stub
		deliveryMapper.updateDelivery(delivery);
	}

	@Override
	public void deleteDelivery(DeliveryVO deliveries) {
		// TODO Auto-generated method stub
		deliveryMapper.deleteDelivery(deliveries);
	}

	@Override
	public List<DeliveryVO> selectAllDeliveries() {
		// TODO Auto-generated method stub
		return deliveryMapper.selectAllDeliveries();
	}

	@Override
	public void insertDeliveries(DeliveryVO delivery) {
		// TODO Auto-generated method stub
		deliveryMapper.insertDeliveries(delivery);

	}

	@Override
	public List<DeliveryVO> getDelivery() {
		// 모든 견적서를 가져옴
		// すべての見積書を取得
		return deliveryMapper.getDelivery();
	}

}
