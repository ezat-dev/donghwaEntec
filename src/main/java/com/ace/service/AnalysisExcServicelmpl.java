package com.ace.service;

import com.ace.dao.AnalysisExcDao;
import com.ace.domain.AnalysisExc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalysisExcServicelmpl implements AnalysisExcService {

    @Autowired
    private AnalysisExcDao analysisExcDao;

    @Override
    public List<AnalysisExc> getAllExcRecords() {
        return analysisExcDao.findAll();
    }
}
