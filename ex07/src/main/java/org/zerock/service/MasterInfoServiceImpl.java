package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.MasterInfoVO;
import org.zerock.mapper.MasterInfoMapper;
import org.zerock.mapper.OrderMapper;

import java.util.List;

@Service
public class MasterInfoServiceImpl implements MasterInfoService {

    @Autowired
    private MasterInfoMapper mapper;
    
    @Override
    public List<MasterInfoVO> getAllProjects() {
        return mapper.getAllProjects();
    }

    @Override
    public List<MasterInfoVO> getAllSoukos() {
        return mapper.getAllSoukos();
    }

    @Override
    public List<MasterInfoVO> getAllTantoushas() {
        return mapper.getAllTantoushas();
    }

    @Override
    public List<MasterInfoVO> getAllTorihikisakis() {
        return mapper.getAllTorihikisakis();
    }

    @Override
    public List<MasterInfoVO> getAllTsuukas() {
        return mapper.getAllTsuukas();
    }
}
