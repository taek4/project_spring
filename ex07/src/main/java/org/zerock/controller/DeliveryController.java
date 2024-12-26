package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.DeliveryVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.MasterInfoVO;
import org.zerock.service.DeliveryService;
import org.zerock.service.MasterInfoService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/delivery/*")
@Log4j
public class DeliveryController {

	@Autowired
	private DeliveryService deliveryService;

	@Autowired
	private MasterInfoService masterInfoService;

	@GetMapping("/list")
	public String list(Model model) {
		List<DeliveryVO> deliveries = deliveryService.selectAllDeliveries(); // 모든 출하 정보 가져오기 / 全ての出荷情報を取得
		System.out.println("Shukka: " + deliveries); // 로그 출력 / ログ出力

		List<DeliveryVO> shukkaWithHinmokuList = deliveryService.selectShukkaWithHinmoku();
		System.out.println("ShukkaWithHinmokuList: " + shukkaWithHinmokuList);
		model.addAttribute("shukkaWithHinmokuList", shukkaWithHinmokuList);

		List<CommonHinmokuVO> commonHinmokuList = deliveryService.selectAllHinmokus();
		model.addAttribute("CommonHinmokuList", commonHinmokuList);

		List<HinmokuVO> hinmokuList = deliveryService.getHinmokuList();
		System.out.println("Deliveries: " + hinmokuList); // 로그 출력 / ログ出力

		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);

		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);

		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);

		List<MasterInfoVO> tsuukaList = masterInfoService.getAllTsuukas();
		model.addAttribute("tsuukaList", tsuukaList);

		System.out.println("CommonHinmokuList: " + commonHinmokuList);
		System.out.println("Deliveries: " + torihikisakiList); // 로그 출력 / ログ出力
		System.out.println("Soukos: " + soukoList); // 로그 출력 / ログ出力
		System.out.println("Tantoushas: " + tantoushaList); // 로그 출력 / ログ出力
		System.out.println("Projectss: " + projectList); // 로그 출력 / ログ出力
		System.out.println("Tsuukas: " + tsuukaList); // 로그 출력 / ログ出力

		model.addAttribute("deliveries", deliveries); // 모델에 추가 / モデルに追加
		model.addAttribute("hinmokuList", hinmokuList);

		return "/delivery/list"; // JSP 파일 이름 / JSPファイル名
	}

	@PostMapping("/update")
	public String updateDelivery(@ModelAttribute DeliveryVO delivery, Model model) {
		// 전달된 deliveryVO를 Service로 전달하여 업데이트 실행 / 渡されたdeliveryVOをServiceに渡して更新実行
		deliveryService.updateDelivery(delivery);

		// 모든 출하 정보 다시 가져오기 / 全ての出荷情報を再取得
		List<DeliveryVO> deliveries = deliveryService.selectAllDeliveries();
		model.addAttribute("deliveries", deliveries); // 모델에 추가 / モデルに追加

		// 수정 완료 후 리스트 페이지로 바로 이동 / 修正完了後リストページへ直接移動
		return "/update"; // JSP 파일 이름 / JSPファイル名
	}

	@GetMapping("/status")
	public String status() {
		return "/delivery/status";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseEntity<?> addItem(@RequestBody DeliveryVO delivery) {
		System.out.println("Received item: " + delivery);

		// 실제 처리 로직 (예: 데이터베이스에 저장) / 実際の処理ロジック（例：データベースに保存）
		// itemService.saveItem(item);

		return ResponseEntity.ok(delivery); // 클라이언트에게 저장된 데이터 응답 / クライアントに保存されたデータを応答
	}

	@GetMapping("/input")
	public String input(Model model) {
		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);

		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);

		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);

		List<MasterInfoVO> tsuukaList = masterInfoService.getAllTsuukas();
		model.addAttribute("tsuukaList", tsuukaList);

		log.info("MasterInfo 목록이 성공적으로 조회되었습니다."); // MasterInfo 목록 성공 조회 / MasterInfoリストの成功取得

		List<HinmokuVO> hinmokuList = deliveryService.getHinmokuList();
		model.addAttribute("hinmokuList", hinmokuList);

		return "/delivery/input";
	}

//출하서 저장 / 出荷書保存
	@PostMapping("/save")
	public String saveDelivery(@ModelAttribute("DeliveryVO") DeliveryVO delivery,
			RedirectAttributes redirectAttributes) {
		try {
			// 출하 또는 품목 데이터 검증 / 出荷または品目データの検証
			if (delivery == null || delivery.getCommonHinmokuList() == null
					|| delivery.getCommonHinmokuList().isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMessage", "출하서 또는 품목 데이터가 없습니다."); // 오류 메시지 추가 / エラーメッセージ追加
				return "redirect:/delivery/input";
			}

			// 품목 데이터 검증 / 品目データの検証
			for (int i = 0; i < delivery.getCommonHinmokuList().size(); i++) {
				CommonHinmokuVO hinmoku = delivery.getCommonHinmokuList().get(i);

				// 필수 값 검증 / 必須値の検証
				if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
					redirectAttributes.addFlashAttribute("errorMessage", "行 " + (i + 1) + "の品目IDが欠落されました。"); // 오류 메시지
																												// 추가 /
																												// エラーメッセージ追加
					return "redirect:/delivery/input";
				}

				if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty()
						|| Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
					redirectAttributes.addFlashAttribute("errorMessage", "行 " + (i + 1) + "の数量が有効でありません。"); // 오류 메시지 추가
																											// /
																											// エラーメッセージ追加
					return "redirect:/delivery/input";
				}
			}

			// 출하서 저장 / 出荷書保存
			deliveryService.saveDelivery(delivery);
			log.info(delivery);

			// 성공 메시지 추가 / 成功メッセージ追加
			redirectAttributes.addFlashAttribute("successMessage", "出荷書が成功的に保存されました。"); // 성공 메시지 추가 / 成功メッセージ追加
			return "redirect:/delivery/list";

		} catch (Exception e) {
			// 오류 메시지 추가 / エラーメッセージ追加
			redirectAttributes.addFlashAttribute("errorMessage", "出荷書保存中エラーが発生しました。"); // 오류 메시지 추가 / エラーメッセージ追加
			return "redirect:/delivery/input";
		}
	}

	@GetMapping("modal/hinmoku")
	public String hinmoku(Model model) {
		List<HinmokuVO> hinmokuList = deliveryService.getHinmokuList();
		model.addAttribute("hinmokuList", hinmokuList);
		return "modal/hinmoku";
	}

	@GetMapping("modal/torihikisaki")
	public String torihikisaki(Model model) {
		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);
		return "modal/torihikisaki";
	}

	@GetMapping("modal/souko")
	public String soukoList(Model model) {
		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		return "modal/souko";
	}

	@GetMapping("modal/tantousha")
	public String tantoushaList(Model model) {
		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);
		return "modal/tantousha";
	}

	@GetMapping("/modal/project")
	public String projectList(Model model) {
		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);
		return "modal/project";
	}

	@GetMapping("/shukka")
	public String shukka(Model model) {
	    List<DeliveryVO> deliveryList = deliveryService.getDelivery();
	    System.out.println("조회된 데이터: " + deliveryList); // 디버깅용 로그
	    model.addAttribute("getDelivery", deliveryList);
	    return "delivery/shukka";
	}


	/*
	 * @GetMapping("/example") public String example() { return "example/example"; }
	 */
}
