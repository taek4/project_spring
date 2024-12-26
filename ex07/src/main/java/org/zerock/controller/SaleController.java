package org.zerock.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CommonHinmokuVO;
import org.zerock.domain.HinmokuVO;
import org.zerock.domain.KessaiVO;
import org.zerock.domain.MasterInfoVO;
import org.zerock.domain.SaleVO;
import org.zerock.service.MasterInfoService;
import org.zerock.service.SaleService;

import lombok.extern.log4j.Log4j;

//김영민
//金榮珉
@Controller
@RequestMapping("/sale/*")// /sale 경로로 시작하는 요청을 처리 // /saleから始まるリクエストを処理
@Log4j
public class SaleController {
	
	 @Autowired
	    private SaleService saleservice; // 판매 서비스 // 販売サービス
	    
	    @Autowired
	    private MasterInfoService masterInfoService; // 마스터 정보 서비스 // マスター情報サービス
	    
	    @GetMapping("/all")
	    public void doAll() {
	        // 모든 사용자가 접근 가능한 메서드 // 全てのユーザーがアクセス可能なメソッド
	        log.info("do all can access everybody");
	    }
	    
	    @GetMapping("/home")
	    public String home() {
	        // 홈 페이지 이동 // ホームページへの移動
	        return "home";
	    }
	    
	    @GetMapping("/example")
	    public String example() {
	        // 예제 페이지 이동 // サンプルページへの移動
	        return "example/example";
	    }
	    
	    @GetMapping("/list")
	    public String salelist(Model model) {
	        // 모든 판매 데이터를 조회하여 리스트 페이지로 전달 // 全ての販売データを取得し、リストページに渡す
	        log.info("Fetching all sale records for /list");
	        List<SaleVO> saleList = saleservice.getAllSale();
	        log.info("Sale List: {}" + saleList); // 콘솔 출력 // コンソール出力
	        model.addAttribute("saleList", saleList); // 모델에 데이터 추가 // モデルにデータ追加
	        return "sale/list";
	    }
	    
	    @GetMapping("/input")
	    public String saleinput(Model model) {
	        // 판매 입력 페이지로 이동 // 販売入力ページへの移動
	        List<MasterInfoVO> projectList = masterInfoService.getAllProjects(); // 프로젝트 리스트 조회 // プロジェクトリストを取得
	        model.addAttribute("projectList", projectList);

	        List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos(); // 창고 리스트 조회 // 倉庫リストを取得
	        model.addAttribute("soukoList", soukoList);

	        List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas(); // 담당자 리스트 조회 // 担当者リストを取得
	        model.addAttribute("tantoushaList", tantoushaList);

	        List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis(); // 거래처 리스트 조회 // 取引先リストを取得
	        model.addAttribute("torihikisakiList", torihikisakiList);

	        List<MasterInfoVO> tsuukaList = masterInfoService.getAllTsuukas(); // 통화 리스트 조회 // 通貨リストを取得
	        model.addAttribute("tsuukaList", tsuukaList);

	        List<HinmokuVO> hinmokuList = saleservice.getHinmokuLIst(); // 품목 리스트 조회 // 品目リストを取得
	        model.addAttribute("hinmokuList", hinmokuList);
	        
	        return "sale/input";
	    }
	    
	    @PostMapping("/save")
	    public String saveSale(@ModelAttribute("SaleVO") SaleVO saleVO, RedirectAttributes redirectAttributes) {
	        // 판매 데이터를 저장하고 성공/실패에 따라 리디렉션 처리 // 販売データを保存し、成功/失敗に応じてリダイレクト処理
	        try {
	            if (saleVO == null || saleVO.getCommonHinmokuList() == null || saleVO.getCommonHinmokuList().isEmpty()) {
	                redirectAttributes.addFlashAttribute("errorMessage", "품목 데이터가 없습니다."); // 품목 데이터 누락 메시지 // 品目データ欠如メッセージ
	                return "redirect:/sale/input";
	            }

	            for (int i = 0; i < saleVO.getCommonHinmokuList().size(); i++) {
	                CommonHinmokuVO hinmoku = saleVO.getCommonHinmokuList().get(i);
	                if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
	                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 품목 ID가 누락되었습니다。");
	                    return "redirect:/sale/input";
	                }
	                if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty() || Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
	                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 수량이 유효하지 않습니다。");
	                    return "redirect:/sale/input";
	                }
	            }

	            saleservice.saveSale(saleVO); // 판매 데이터 저장 호출 // 販売データ保存を呼び出し
	            redirectAttributes.addFlashAttribute("successMessage", "판매가 성공적으로 저장되었습니다."); // 성공 메시지 추가 // 成功メッセージ追加
	            return "redirect:/sale/success";
	        } catch (NumberFormatException e) {
	            log.error("수량 입력 값이 유효하지 않음: ", e); // 수량 형식 오류 // 数量形式エラー
	            redirectAttributes.addFlashAttribute("errorMessage", "수량 값이 올바르지 않습니다. 숫자로 입력해주세요。");
	            return "redirect:/sale/input";
	        } catch (Exception e) {
	            log.error("판매 저장 중 오류 발생: ", e); // 저장 중 오류 발생 // 保存中エラー発生
	            redirectAttributes.addFlashAttribute("errorMessage", "판매저장 중 오류가 발생했습니다: " + e.getMessage());
	            return "redirect:/sale/error";
	        }
	    }
	    
	    @GetMapping("/success")
	    public String successPage() {
	        // 저장 성공 페이지로 이동 // 保存成功ページへの移動
	        return "sale/success";
	    }

	    @GetMapping("/error")
	    public String errorPage() {
	        // 오류 페이지로 이동 // エラーページへの移動
	        return "sale/error";
	    }
	    
		@GetMapping("/input2")
		public String input2(Model model) {
			 // 판매 입력2 페이지로 이동 // 販売入力2ページへの移動
	        List<MasterInfoVO> projectList = masterInfoService.getAllProjects(); // 프로젝트 리스트 조회 // プロジェクトリストを取得
	        log.info("Project List: {}" + projectList);
	        model.addAttribute("projectList", projectList);
	
	        List<MasterInfoVO> soukoList = masterInfoService.getAllSoukos(); // 창고 리스트 조회 // 倉庫リストを取得
	        log.info("souko List: {}" + soukoList);
	        model.addAttribute("soukoList", soukoList);
	
	        List<MasterInfoVO> tantoushaList = masterInfoService.getAllTantoushas(); // 담당자 리스트 조회 // 担当者リストを取得
	        log.info("tantousha List: {}" + tantoushaList);
	        model.addAttribute("tantoushaList", tantoushaList);
	
	        List<MasterInfoVO> torihikisakiList = masterInfoService.getAllTorihikisakis();// 거래처 리스트 조회 // 取引先リストを取得
	        log.info("torihikisaki List: {}" + torihikisakiList);
	        model.addAttribute("torihikisakiList", torihikisakiList);
	
	        List<MasterInfoVO> tsuukaList = masterInfoService.getAllTsuukas();// 통화 리스트 조회 // 通貨リストを取得
	        log.info("tsuuka List: {}" + tsuukaList);
	        model.addAttribute("tsuukaList", tsuukaList);
	
	        List<HinmokuVO> hinmokuList = saleservice.getHinmokuLIst(); // 품목 리스트 조회 // 品目リストを取得
	        log.info("hinmoku List: {}" + hinmokuList);
	        model.addAttribute("hinmokuList", hinmokuList);
	        log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");
	        
			return "sale/input2";
		}
		
		 @PostMapping("/save2")
		    public String saveSale2(@ModelAttribute("saleVO") SaleVO saleVO, RedirectAttributes redirectAttributes) {
			// 판매 데이터를 저장하고 성공/실패에 따라 리디렉션 처리 // 販売データを保存し、成功/失敗に応じてリダイレクト処理
		        try {
		            if (saleVO == null || saleVO.getCommonHinmokuList() == null || saleVO.getCommonHinmokuList().isEmpty()) {
		                redirectAttributes.addFlashAttribute("errorMessage", "품목 데이터가 없습니다."); // 품목 데이터 누락 메시지 // 品目データ欠如メッセージ
		                return "redirect:/sale/input2";
		            }
	
		            for (int i = 0; i < saleVO.getCommonHinmokuList().size(); i++) {
		                CommonHinmokuVO hinmoku = saleVO.getCommonHinmokuList().get(i);
	
		                if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
		                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 품목 ID가 누락되었습니다.");
		                    return "redirect:/sale/input2";
		                }
	
		                if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty() || Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
		                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 수량이 유효하지 않습니다.");
		                    return "redirect:/sale/input2";
		                }
		            }
	
		            saleservice.saveSale2(saleVO);// 판매 데이터 저장 호출 // 販売データ保存を呼び出し
		            redirectAttributes.addFlashAttribute("successMessage", "판매가 성공적으로 저장되었습니다."); // 성공 메시지 추가 // 成功メッセージ追加
		            return "redirect:/sale/success";
		        } catch (NumberFormatException e) {
		            log.error("수량 입력 값이 유효하지 않음: ", e); // 수량 형식 오류 // 数量形式エラー
		            redirectAttributes.addFlashAttribute("errorMessage", "수량 값이 올바르지 않습니다. 숫자로 입력해주세요.");
		            return "redirect:/sale/input2";
		        } catch (Exception e) {
		            log.error("판매 저장 중 오류 발생: ", e); // 저장 중 오류 발생 // 保存中エラー発生
		            redirectAttributes.addFlashAttribute("errorMessage", "판매저장 중 오류가 발생했습니다: " + e.getMessage());
		            return "redirect:/sale/error";
		        }
		    }
		 
		 @GetMapping("/price")
		 public String price() {
		     // 단가 페이지로 이동 // 単価ページへの移動
		     return "sale/price";
		 }

		 @GetMapping("/tanka")
		 public String tanka(Model model) {
		     // 모든 판매 단가 데이터를 조회하여 tanka 페이지로 전달 // 全ての販売単価データを取得し、tankaページに渡す
		     log.info("Fetching all sale records for /tanka");
		     List<SaleVO> saleList = saleservice.getAllHanbaiTanka();
		     log.info("Tanka List: {}" + saleList); // 콘솔 출력 // コンソール出力
		     model.addAttribute("saleList", saleList); // 모델에 데이터 추가 // モデルにデータ追加
		     return "sale/tanka";
		 }

		 @PostMapping("/tanka")
		 @ResponseBody
		 public ResponseEntity<?> processRelease(@RequestBody Map<String, Object> requestData) {
		     // 단가 변경 요청 처리 // 単価変更リクエストを処理
		     try {
		         String hinmokumei = requestData.get("hinmokumei").toString(); // 품목명 // 品目名
		         String hitsukeNoRefertype = requestData.get("hitsukeNoRefertype").toString(); // 날짜별 참조 유형 // 日付別参照タイプ
		         int release = Integer.parseInt(requestData.get("release").toString()); // 릴리스 값 // リリース値

		         saleservice.processRelease(hinmokumei, hitsukeNoRefertype, release); // 서비스 호출 // サービス呼び出し

		         log.info("hinmokumei: " + hinmokumei);
		         log.info("hitsukeNoRefertype: " + hitsukeNoRefertype);
		         log.info("release: " + release);

		         // UTF-8 Content-Type 설정 및 성공 메시지 반환 // UTF-8 Content-Type設定および成功メッセージ返却
		         return ResponseEntity.ok()
		                              .header("Content-Type", "text/plain; charset=UTF-8")
		                              .body("단가 변경이 완료되었습니다."); // 単価変更が完了しました。
		     } catch (Exception e) {
		         e.printStackTrace();
		         // 오류 발생 시 BAD_REQUEST 상태와 오류 메시지 반환 // エラー発生時BAD_REQUEST状態とエラーメッセージを返却
		         return ResponseEntity.status(HttpStatus.BAD_REQUEST)
		                              .header("Content-Type", "text/plain; charset=UTF-8")
		                              .body("단가 변경중 오류 발생: " + e.getMessage()); // 単価変更中エラー発生: " + e.getMessage());
		     }
		 }

		 @GetMapping("/status")
		 public String status() {
		     // 상태 페이지로 이동 // 状態ページへの移動
		     return "sale/status";
		 }

		 @GetMapping("/genjou")
		 public String genjou(Model model) {
		     // 모든 현황 데이터를 조회하여 genjou 페이지로 전달 // 全ての現況データを取得し、genjouページに渡す
		     log.info("Fetching all sale records for /genjou");
		     List<SaleVO> saleList = saleservice.getAllGenjou();
		     log.info("Genjou List: {}" + saleList); // 콘솔 출력 // コンソール出力
		     model.addAttribute("saleList", saleList); // 모델에 데이터 추가 // モデルにデータ追加
		     return "sale/genjou";
		 }

		 @GetMapping("/payment_query")
		 public String payment_query(Model model) {
		     // 모든 결제 데이터를 조회하여 payment_query 페이지로 전달 // 全ての決済データを取得し、payment_queryページに渡す
		     log.info("Fetching all sale records for /payment_query");
		     List<KessaiVO> kessaiList = saleservice.getAllKessai();
		     log.info("Sale List: {}" + kessaiList); // 콘솔 출력 // コンソール出力
		     model.addAttribute("saleList", kessaiList); // 모델에 데이터 추가 // モデルにデータ追加
		     return "sale/payment_query";
		 }

		 @GetMapping("/payment_compare")
		 public String payment_compare() {
		     // 결제 비교 페이지로 이동 // 決済比較ページへの移動
		     return "sale/payment_compare";
		 }
}