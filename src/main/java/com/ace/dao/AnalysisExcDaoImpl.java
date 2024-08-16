package com.ace.dao;

import com.ace.domain.AnalysisExc;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AnalysisExcDaoImpl implements AnalysisExcDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<AnalysisExc> findAll() {
        return sqlSession.selectList("com.ace.dao.AnalysisExcDao.findAll");
    }
}
