package org.zerock.controller;

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
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.MasterInfoVO;
import org.zerock.domain.OrderVO;
import org.zerock.service.MasterInfoService;
import org.zerock.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order/*")
@Log4j
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private MasterInfoService masterInfoService;

    // 주문서 목록 페이지
    @GetMapping("/list")
    public String orderList(Model model) {
        List<OrderVO> orderList = orderService.getOrderList();
        model.addAttribute("orderList", orderList);
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

        List<HinmokuVO> hinmokuList = orderService.getHinmokuList();
        model.addAttribute("hinmokuList", hinmokuList);
        return "order/list";
    }

    // 주문서 입력 페이지
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

        List<MasterInfoVO> tsuukaList = masterInfoService.getAllTsuukas();
        model.addAttribute("tsuukaList", tsuukaList);

        log.info("MasterInfo 목록이 성공적으로 조회되었습니다.");

        List<HinmokuVO> hinmokuList = orderService.getHinmokuList();
        model.addAttribute("hinmokuList", hinmokuList);

        return "order/input";
    }
    

    // 상태 페이지
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
        
        List<HinmokuVO> hinmokuList = orderService.getHinmokuList();
        model.addAttribute("hinmokuList", hinmokuList);
    	
        return "order/status";
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
        List<OrderVO> statusList = orderService.statusList(processedParams);

        // 결과 전달
        model.addAttribute("statusList", statusList);
        log.info(statusList);
        return "order/status";
    }

 // 주문서 저장
    @PostMapping("/save")
    public String saveOrder(@ModelAttribute("jumunshoVO") JumunshoVO jumunshoVO, RedirectAttributes redirectAttributes) {
    	log.info(jumunshoVO);
        try {
            // 주문서 또는 품목 데이터 검증
            if (jumunshoVO == null || jumunshoVO.getCommonHinmokuList() == null || jumunshoVO.getCommonHinmokuList().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "주문서 또는 품목 데이터가 없습니다.");
                return "redirect:/order/input";
            }

            // 품목 데이터 검증
            for (int i = 0; i < jumunshoVO.getCommonHinmokuList().size(); i++) {
                CommonHinmokuVO hinmoku = jumunshoVO.getCommonHinmokuList().get(i);

                // 필수 값 검증
                if (hinmoku.getHinmokuID() == null || hinmoku.getHinmokuID().isEmpty()) {
                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 품목 ID가 누락되었습니다.");
                    return "redirect:/order/input";
                }

                if (hinmoku.getSuuryou() == null || hinmoku.getSuuryou().isEmpty() || Integer.parseInt(hinmoku.getSuuryou()) <= 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "행 " + (i + 1) + "의 수량이 유효하지 않습니다.");
                    return "redirect:/order/input";
                }
            }

            // 주문서 저장
            orderService.saveOrder(jumunshoVO);

            // 성공 메시지 추가
            redirectAttributes.addFlashAttribute("successMessage", "주문서가 성공적으로 저장되었습니다.");
            return "redirect:/order/success";
        } catch (NumberFormatException e) {
            log.error("수량 입력 값이 유효하지 않음: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "수량 값이 올바르지 않습니다. 숫자로 입력해주세요.");
            return "redirect:/order/input";
        } catch (Exception e) {
            log.error("주문서 저장 중 오류 발생: ", e);
            redirectAttributes.addFlashAttribute("errorMessage", "주문서 저장 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/order/error";
        }
    }


    // 저장 성공 페이지
    @GetMapping("/success")
    public String successPage() {
        return "order/success";
    }

    // 에러 페이지
    @GetMapping("/error")
    public String errorPage() {
        return "order/error";
    }


    @GetMapping("/release")
    public String getReleaseList(Model model) {
        List<OrderVO> releaseList = orderService.getReleaseList();
        model.addAttribute("releaseList", releaseList);
        return "order/release"; // JSP 경로
    }
    
    @PostMapping("/release")
    @ResponseBody
    public ResponseEntity<?> processRelease(@RequestBody Map<String, Object> requestData) {
        try {
            String hinmokuMei = requestData.get("hinmokuMei").toString();
            String hitsukeNoRefertype = requestData.get("hitsukeNoRefertype").toString();
            int release = Integer.parseInt(requestData.get("release").toString());

            orderService.processRelease(hinmokuMei, hitsukeNoRefertype, release);

            // UTF-8 Content-Type 설정
            return ResponseEntity.ok()
                                 .header("Content-Type", "text/plain; charset=UTF-8")
                                 .body("출고 처리가 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                 .header("Content-Type", "text/plain; charset=UTF-8")
                                 .body("출고 처리 중 오류 발생: " + e.getMessage());
        }
    }





    // 미판매 페이지
    @GetMapping("/unsold")
    public String unsold(Model model) {
        List<OrderVO> unsoldList = orderService.unsoldList();
        model.addAttribute("unsoldList", unsoldList);
        return "order/unsold";
    }
}
