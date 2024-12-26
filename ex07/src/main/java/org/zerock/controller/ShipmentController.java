package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.MasterInfoVO;
import org.zerock.domain.ShipmentVO;
import org.zerock.service.MasterInfoService;
import org.zerock.service.ShipmentService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/shipment/*")
public class ShipmentController {

	@Autowired
	private ShipmentService shipmentService;
	@Autowired
	private MasterInfoService masterInfoService;

	// 재고 리스트 조회
    // 在庫リストの取得
    @GetMapping("/hinmokuList")
    @ResponseBody
    public List<HinmokuVO> getHinmokuList() {
        return shipmentService.getAllHinmoku();
    }

    /**
     * 출하지시서 목록 조회
     * 出荷指示書の一覧を取得
     */
    @GetMapping("/list")
    public String listShipments(Model model) {
        List<ShipmentVO> getList = shipmentService.getList();
        log.info(getList);
        model.addAttribute("getList", getList); // 데이터를 View로 전달
                                             // データをViewに渡す
        return "shipment/list"; // View 이름 반환
                              // View名を返す
    }

    /**
     * 주문서 입력 페이지 표시
     * 注文書入力ページの表示
     */
    @GetMapping("/input")
    public String showOrderInputPage(Model model) {
        List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
        model.addAttribute("projectList", projectList);

        List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
        model.addAttribute("soukoList", soukoList);

        List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
        model.addAttribute("tantoushaList", tantoushaList);

        List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
        model.addAttribute("torihikisakiList", torihikisakiList);

        log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");
        // MasterInfoリストが正常に取得されました。

        List<HinmokuVO> hinmokuList = shipmentService.getAllHinmoku();
        model.addAttribute("hinmokuList", hinmokuList);
        return "shipment/input";
    }

    /**
     * 주문서 저장
     * 注文書の保存
     */
    @PostMapping("/save")
    public String saveOrder(@ModelAttribute("shipmentVO") ShipmentVO shipment, RedirectAttributes redirectAttributes) {
        try {
            // 주문서 또는 품목 데이터 검증
            // 注文書または品目データの検証
            if (shipment == null || shipment.getCommonHinmokuList() == null ||
                    shipment.getCommonHinmokuList().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "주문서 또는 품목 데이터가 없습니다.");
                // 注文書または品目データがありません。
                return "redirect:/shipment/input";
            }

            // 품목 데이터 검증
            // 品目データの検証
            for (int i = 0; i < shipment.getCommonHinmokuList().size(); i++) {
                CommonHinmokuVO hinmoku = shipment.getCommonHinmokuList().get(i);

                // 필수 값 검증
                // 必須値の検証
                if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 품목 ID가 누락되었습니다.");
                    // 行 " + (i + 1) + "の品目IDが欠落しています。
                    return "redirect:/shipment/input";
                }

                if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty() ||
                        Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 수량이 유효하지 않습니다.");
                    // 行 " + (i + 1) + "の数量が無効です。
                    return "redirect:/shipment/input";
                }
            }

            // 주문서 저장
            // 注文書の保存
            shipmentService.saveshipment(shipment);

            // 성공 메시지 추가
            // 成功メッセージの追加
            redirectAttributes.addFlashAttribute("successMessage", "주문서가 성공적으로 저장되었습니다.");
            // 注文書が正常に保存されました。
            return "redirect:/shipment/success";
        } catch (NumberFormatException e) {
            log.error("수량 입력 값이 유효하지 않음: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "수량 값이 올바르지 않습니다. 숫자로 입력해주세요.");
            // 数量値が正しくありません。数字で入力してください。
            return "redirect:/shipment/input";
        } catch (Exception e) {
            log.error("주문서 저장 중 오류 발생: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "주문서 저장 중 오류가 발생했습니다: " + e.getMessage());
            // 注文書の保存中にエラーが発生しました。
            return "redirect:/shipment/error";
        }
    }

    /**
     * 저장 성공 페이지
     * 保存成功ページ
     */
    @GetMapping("/success")
    public String successPage() {
        return "shipment/success";
    }

    /**
     * 에러 페이지
     * エラーページ
     */
    @GetMapping("/error")
    public String errorPage() {
        return "shipment/error";
    }

    /**
     * 상태 페이지
     * 状態ページ
     */
    @GetMapping("/status")
    public String status(Model model) {
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
        
        List<HinmokuVO> hinmokuList = shipmentService.getAllHinmoku();
        model.addAttribute("hinmokuList", hinmokuList);
    	
        return "shipment/status";
    }
    
    @PostMapping("/status")
    public String getStatus(@RequestParam Map<String, String> params, Model model) {
    	
    	Map<String, Object> processedParams = new HashMap<>();
    	params.forEach((key, value) -> {
            if (value == null || value.trim().isEmpty() || "null".equalsIgnoreCase(value)) {
                processedParams.put(key, null); // 빈 값 또는 "null" 문자열을 null로 처리
            } else {
                processedParams.put(key, value); // 기존 값을 유지
            }
        });

        log.info("Processed Parameters: " + processedParams);

        // MyBatis 호출
        List<ShipmentVO> statusList = shipmentService.statusList(processedParams);

        // 결과 전달
        model.addAttribute("statusList", statusList);
        log.info(statusList);
        return "shipment/status";
    }
    /**
     * 처리 과정 페이지
     * 処理過程ページ
     */
    @GetMapping("/process")
    public String process() {
        return "shipment/process";
    }

    /**
     * 미판매 페이지
     * 未販売ページ
     */
    @GetMapping("/unsold")
    public String unsold() {
        return "shipment/unsold";
    }

    /**
     * 품목 데이터 삽입
     * 品目データ挿入
     */
    @PostMapping("/hinmokuinsert")
    @ResponseBody
    public ResponseEntity<String> hinmokuinsert(@RequestBody List<CommonHinmokuVO> commonHinmokuList) {
        try {
            for (CommonHinmokuVO commonHinmoku : commonHinmokuList) {
                shipmentService.hinmokuinsert(commonHinmoku);
            }
            return ResponseEntity.ok("Insert successful");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("An error occurred: " + e.getMessage());
        }
    }


    @PostMapping(value = "/hinmokuupdate", consumes = "application/json")
    @ResponseBody
    public ResponseEntity<String> hinmokuupdate(@RequestBody List<ShipmentVO> shipments) {
        log.info("출하지시서 수정 요청: " + shipments); // 출하지시서 수정 요청 로그
        // 出荷指示書の修正リクエストログ

        try {
            for (ShipmentVO shipment : shipments) {
                shipmentService.hinmokuupdate(shipment); // 각 ShipmentVO를 업데이트
                // 各ShipmentVOを更新
            }
            return ResponseEntity.ok("수정 성공"); // HTTP 200 OK
            // HTTP 200 OK
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패: " + e.getMessage()); // HTTP 500
            // HTTP 500
        }
    }

    // 출하지시서 진행 상태 업데이트
    // 出荷指示書進行状態の更新
    @PostMapping("/taiupdate")
    public ResponseEntity<Integer> taiupdate(@RequestParam("shukkaShiziShoukaiID") int shukkaShiziShoukaiID,
            @RequestParam("shinkouZyoutai") String shinkouZyoutai) {
        log.info("Update 요청 수신: shukkaShiziShoukaiID=" + shukkaShiziShoukaiID + ", shinkouZyoutai=" + shinkouZyoutai);
        // 更新リクエスト受信: shukkaShiziShoukaiID、進行状態

        int rowsUpdated = shipmentService.taiupdate(shukkaShiziShoukaiID, shinkouZyoutai);
        log.info("업데이트 결과: " + rowsUpdated); // 업데이트 결과 로그
        // 更新結果ログ

        return ResponseEntity.ok(rowsUpdated); // 반환값을 ResponseEntity로 감싸서 반환
        // 戻り値をResponseEntityでラップして返却
    }

    // 거래처/담당자/프로젝트등의 조회 돋보기 모달창
    // 取引先/担当者/プロジェクトなどの検索用モーダルウィンドウ
    @GetMapping(value = "/shipmentdetails", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ShipmentVO getShipmentDetails(@RequestParam("hitsuke_No") String hitsuke_No) {
        ShipmentVO shipment = shipmentService.getShipmentByHitsukeNo(hitsuke_No); // hitsuke_No로 출하지시서 조회
        // hitsuke_Noで出荷指示書を検索
        return shipment;
    }

    // 출하지시서 수정
    // 出荷指示書の修正
    @PostMapping(value = "/shipmentcorrection", consumes = "application/json")
    @ResponseBody
    public ResponseEntity<String> shipmentCorrection(@RequestBody ShipmentVO shipment) {
        log.info("출하지시서 수정 요청: " + shipment.toString()); // 출하지시서 수정 요청 로그
        // 出荷指示書修正リクエストログ

        try {
            // 서비스 호출
            // サービス呼び出し
            shipmentService.shipmentcorrection(shipment);

            // HTTP 200 OK 반환
            // HTTP 200 OK返却
            return ResponseEntity.ok("수정 성공");
        } catch (Exception e) {
            // 예외 처리
            // 例外処理
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("수정 실패: " + e.getMessage());
        }
    }
}
