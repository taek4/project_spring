package org.zerock.service;

import org.zerock.domain.MasterInfoVO;

import java.util.List;

public interface MasterInfoService {
    List<MasterInfoVO> getAllProjects();
    List<MasterInfoVO> getAllSoukos();
    List<MasterInfoVO> getAllTantoushas();
    List<MasterInfoVO> getAllTorihikisakis();
    List<MasterInfoVO> getAllTsuukas();
}
