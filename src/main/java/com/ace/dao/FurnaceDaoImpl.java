package com.ace.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FurnaceDaoImpl implements FurnaceDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void setSSS() {
		
	}

}
