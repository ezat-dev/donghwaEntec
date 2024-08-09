package com.ace.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ace.dao.FurnaceDao;

@Service
public class FurnaceServiceImpl implements FurnaceService{

	@Autowired
	private FurnaceDao furnaceDao;
	
	@Override
	public void setSSS() {
		furnaceDao.setSSS();
	}

}
