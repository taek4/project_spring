package org.zerock.mapper;

import org.zerock.domain.MasterInfoVO;

import java.util.List;

public interface MasterInfoMapper {
    List<MasterInfoVO> getAllProjects();
    List<MasterInfoVO> getAllSoukos();
    List<MasterInfoVO> getAllTantoushas();
    List<MasterInfoVO> getAllTorihikisakis();
    List<MasterInfoVO> getAllTsuukas();
    List<MasterInfoVO> getAllHinmokus();
}
