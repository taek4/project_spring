package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.HinmokuVO;
import org.zerock.domain.JumunshoVO;
import org.zerock.domain.OrderVO;

public interface OrderService {
    List<OrderVO> getOrderList();
    
    List<OrderVO> getReleaseList();
    
    void processRelease(String hinmokuMei, String hitsukeNoRefertype, int release) throws Exception;
    
    List<OrderVO> statusList(Map<String, Object> params);
    
    List<OrderVO> unsoldList();

    void saveOrder(JumunshoVO jumunshoVO);
    
    List<HinmokuVO> getHinmokuList();

}
