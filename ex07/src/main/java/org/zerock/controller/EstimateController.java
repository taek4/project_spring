package org.zerock.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
import org.zerock.domain.MitsumorishoVO;
import org.zerock.domain.SeikyuuVO;
import org.zerock.service.EstimateService;
import org.zerock.service.HinmokuService;
import org.zerock.service.MasterInfoService;
import org.zerock.service.SeikyuuService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/estimate/*")
@Log4j
public class EstimateController {

	@Autowired
	private EstimateService estimateService;

	@Autowired
	private SeikyuuService seikyuuService;

	@Autowired
	private HinmokuService hinmokuService;

	@Autowired
	private MasterInfoService masterInfoService;

	private static final Logger log = LoggerFactory.getLogger(EstimateController.class); // Logger 선언
	
	public EstimateController(SeikyuuService seikyuuService) {
        this.seikyuuService = seikyuuService;
    }

	/**
	 * 견적서 리스트를 조회
	 * 見積書リストを照会
	 */
	@GetMapping("/list")
	public String list(Model model) {
		List<MitsumorishoVO> getlist = estimateService.getList();
		model.addAttribute("getlist", getlist);

		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);

		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);

		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);

		log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");

		// 재고 테이블(Hinmoku)에서 품목 목록 조회
		List<HinmokuVO> hinmokuList = hinmokuService.getAllHinmoku();
		// Model 객체에 추가하여 JSP로 전달
		model.addAttribute("hinmokuList", hinmokuList);

		return "estimate/list";
	}

	/**
	 * 견적서 상태를 업데이트
	 * 見積書のステータスを更新
	 */
	@PostMapping("/update")
	public ResponseEntity<Integer> update(@RequestParam("mitsumorishoId") int mitsumorishoId,
			@RequestParam("status") String status) {
		log.info("Update 요청 수신: mitsumorishoId=" + mitsumorishoId + ", status=" + status);

		// Service를 호출하여 업데이트 처리
		int rowsUpdated = estimateService.updateStatus(mitsumorishoId, status);
		log.info("업데이트 결과: " + rowsUpdated);

		return ResponseEntity.ok(rowsUpdated); // 업데이트된 행 수 반환
	}

	@PostMapping("/updateEstimate")
	public ResponseEntity<Integer> update(@RequestParam("mitsumorishoId") int mitsumorishoId,
			@RequestParam("date") String date, @RequestParam("trader") String trader,
			@RequestParam("manager") String manager, @RequestParam("warehouse") String warehouse,
			@RequestParam("transactionType") String transactionType, @RequestParam("currency") String currency,
			@RequestParam("project") String project) {

		log.info("견적서 업데이트 요청 수신: mitsumorishoId=" + mitsumorishoId);

		int rowsUpdated = estimateService.updateEstimate(mitsumorishoId, date, trader, manager, warehouse,
				transactionType, currency, project);

		log.info("업데이트 결과: " + rowsUpdated);

		return ResponseEntity.ok(rowsUpdated);
	}

	/**
	 * 특정 견적서 데이터를 JSP로 렌더링
	 * 特定見積書データをJSPにレンダリング
	 */
	@GetMapping("/detail")
	public String getMitsumorishoDetail(@RequestParam("id") String id, Model model) {
	    List<SeikyuuVO> seikyuuList = SeikyuuService.selectAllSeikyuu(id);

	    if (seikyuuList == null || seikyuuList.isEmpty()) {
	        model.addAttribute("errorMessage", "해당 ID에 대한 견적서를 찾을 수 없습니다.");
	    } else {
	        model.addAttribute("seikyuuList", seikyuuList); // JSP에 전달할 데이터
	    }

	    return "estimate/detail"; // detail.jsp 파일 반환
	}
	
	/**
	 * 견적서 입력 페이지를 호출
	 * 見積書入力ページを呼び出す
	 */
	@GetMapping("/input")
	public String showEstimateInputPage(Model model) {

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

		log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");

		// 재고 테이블(Hinmoku)에서 품목 목록 조회
		List<HinmokuVO> hinmokuList = estimateService.getHinmokuList();
		// Model 객체에 추가하여 JSP로 전달
		model.addAttribute("hinmokuList", hinmokuList);

		return "estimate/input"; // 견적서 입력 페이지 JSP 경로
	}

	// 저장 성공 페이지
	// 保存成功ページ
	@GetMapping("/success")
	public String successPage() {
		return "estimate/success";
	}

	// 에러 페이지
	// エラー·ページ
	@GetMapping("/error")
	public String errorPage() {
		return "estimate/error";
	}

	// 처리 과정 페이지
	// プロセスページ
	@GetMapping("/process")
	public String process() {
		return "estimate/process";
	}

	// 견적서 저장
	// 見積書保存
	@PostMapping("/save")
	public String saveEstimate(@ModelAttribute("mitsumorishoVO") MitsumorishoVO mitsumorishoVO, RedirectAttributes redirectAttributes) {
		try {
			// 견적서 또는 품목 데이터 검증
			// 見積書または品目データの検証
			if (mitsumorishoVO == null || mitsumorishoVO.getCommonHinmokuList() == null
					|| mitsumorishoVO.getCommonHinmokuList().isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMessage", "견적서 또는 품목 데이터가 없습니다.");
				return "redirect:/estimate/input";
			}

			// 품목 데이터 검증
			// 品目データ検証
			for (int i = 0; i < mitsumorishoVO.getCommonHinmokuList().size(); i++) {
				CommonHinmokuVO hinmoku = mitsumorishoVO.getCommonHinmokuList().get(i);
				log.info("품목 삽입 데이터: {}" + hinmoku);
				// 필수 값 검증
				// 必須値検証
				if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
					redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 품목 ID가 누락되었습니다.");
					return "redirect:/estimate/input";
				}

				if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty()
						|| Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
					redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 수량이 유효하지 않습니다.");
					return "redirect:/estimate/input";
				}
			}

			// 견적서 저장
			// 見積書保存
			estimateService.saveEstimate(mitsumorishoVO);

			// 성공 메시지 추가
			// 成功メッセージ追加
			redirectAttributes.addFlashAttribute("successMessage", "견적서가 성공적으로 저장되었습니다.");
			return "redirect:/estimate/success";
		} catch (NumberFormatException e) {
			log.error("수량 입력 값이 유효하지 않음: ", e);
			redirectAttributes.addFlashAttribute("errorMessage", "수량 값이 올바르지 않습니다. 숫자로 입력해주세요.");
			return "redirect:/estimate/input";
		} catch (Exception e) {
			log.error("견적서 저장 중 오류 발생: ", e);
			redirectAttributes.addFlashAttribute("errorMessage", "견적서 저장 중 오류가 발생했습니다: " + e.getMessage());
			return "redirect:/estimate/error";
		}
	}
	
	@PostMapping("/modalsave")
    public ResponseEntity<String> saveOrUpdateEstimate(@RequestBody MitsumorishoVO mitsumorishoVO) {
        try {
            // 데이터 유효성 검사
        	// データ検証
            if (mitsumorishoVO == null || mitsumorishoVO.getCommonHinmokuList() == null || mitsumorishoVO.getCommonHinmokuList().isEmpty()) {
                return ResponseEntity.badRequest().body("품목 데이터가 없습니다.");
            }

            // Insert 및 Update 로직 처리
            for (CommonHinmokuVO hinmoku : mitsumorishoVO.getCommonHinmokuList()) {
                if (hinmoku.getCommonHinmokuID() == null) {
                    // Insert 로직
                    estimateService.insertCommonHinmoku(hinmoku);
                } else {
                    // Update 로직
                    estimateService.updateCommonHinmoku(hinmoku);
                }
            }

            return ResponseEntity.ok("데이터가 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("데이터 저장 중 오류가 발생했습니다.");
        }
    }

	/**
	 * 견적서 현황 페이지를 호출
	 * 見積書現況ページを呼び出し
	 */
	@GetMapping("/status")
	public String status(Model model) {
		model.addAttribute("status", estimateService.getList());
		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);

		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);

		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);

		log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");

		// 재고 테이블(Hinmoku)에서 품목 목록 조회
		List<HinmokuVO> hinmokuList = hinmokuService.getAllHinmoku();
		// Model 객체에 추가하여 JSP로 전달
		model.addAttribute("hinmokuList", hinmokuList);

		return "estimate/status";
	}

	/**
	 * 미주문 현황 페이지를 호출
	 * 迷走文の現況ページを呼び出し
	 */
	@GetMapping("/unordered")
	public String unordered(Model model) {
		model.addAttribute("unordered", estimateService.getList());
		List<MasterInfoVO> projectList = masterInfoService.getAllProjects();
		model.addAttribute("projectList", projectList);

		List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
		model.addAttribute("soukoList", soukoList);

		List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas();
		model.addAttribute("tantoushaList", tantoushaList);

		List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();
		model.addAttribute("torihikisakiList", torihikisakiList);

		log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");

		// 재고 테이블(Hinmoku)에서 품목 목록 조회
		List<HinmokuVO> hinmokuList = hinmokuService.getAllHinmoku();
		// Model 객체에 추가하여 JSP로 전달
		model.addAttribute("hinmokuList", hinmokuList);

		return "estimate/unordered";
	}

	/**
	 * 생성한 전표 데이터를 조회
	 * 生成した伝票データを照会
	 */
	@GetMapping(value = "/getDetail", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<?> getDetail(@RequestParam(value = "id", required = false) Long id) {
		if (id == null) {
			List<SeikyuuVO> seikyuuList = seikyuuService.getAllSeikyuu();
			System.out.println("전체 Seikyuu 데이터: " + seikyuuList);
			return new ResponseEntity<>(seikyuuList, HttpStatus.OK); // JSON으로 전체 데이터 반환
		}
		SeikyuuVO seikyuu = seikyuuService.getSeikyuuByMitsumorishoID(id.intValue());
		System.out.println("특정 Seikyuu 데이터: " + seikyuu);
		return new ResponseEntity<>(seikyuu, HttpStatus.OK); // 특정 데이터 반환
	}

	
	@GetMapping(value = "/commonHinmoku", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<CommonHinmokuVO>> getAllCommonHinmoku() {
		List<CommonHinmokuVO> commonHinmokuList = estimateService.getAllCommonHinmoku();
		System.out.println("commonHinmokuList: " + commonHinmokuList);
		return new ResponseEntity<>(commonHinmokuList, HttpStatus.OK);
	}

	// 창고 리스트 가져오기
	// 倉庫リストの取得
	@GetMapping("/souko/list")
	@ResponseBody
	public List<MasterInfoVO> getSoukoList() {
	    List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos();
	    log.info("창고 리스트 데이터: {}", soukoList); // 로그 출력
	    return soukoList;
	}

	// 거래처 리스트 가져오기
	// 取引先リストの取得
	@GetMapping("/torihikisaki")
	@ResponseBody
	public List<MasterInfoVO> getTorihikisakiList() {
		// 거래처 목록을 전체 반환
		// 取引先リストを全部返却
		return masterInfoService.getAllTorihikisakis();
	}

	// 담당자 리스트 가져오기
	// 担当者リストの取得
	@GetMapping("/tantousha/list")
	@ResponseBody
	public List<MasterInfoVO> getTantoushaList() {
		// 담당자 목록을 전체 반환
		// 担当者リストをすべて返却
		return masterInfoService.getAllTantoushas();
	}

	// 프로젝트 리스트 가져오기
	// プロジェクトリスト取得
	@GetMapping("/project/list")
	@ResponseBody
	public List<MasterInfoVO> getProjectList() {
		return masterInfoService.getAllProjects(); // 프로젝트 목록 반환 // プロジェクトリスト返還
	}
	
	@GetMapping("/mijumun")
	public String mijumun(Model model) {
	    List<MitsumorishoVO> getMijumun = estimateService.getMijumun();
	    log.info("미주문 데이터: {}", getMijumun); // 데이터 로그 출력  // データログ出力
	    model.addAttribute("getMijumun", getMijumun);
	    return "estimate/mijumun";
	}
	
	@GetMapping("/mitsumorisho")
	public String mitsumorisho(Model model) {
	    List<MitsumorishoVO> getMitsumorisho = estimateService.getMitsumorisho();
	    log.info("견적서 데이터: {}", getMitsumorisho); // 데이터 로그 출력  // データログ出力
	    model.addAttribute("getMitsumorisho", getMitsumorisho);
	    return "estimate/mitsumorisho";
	}


}
