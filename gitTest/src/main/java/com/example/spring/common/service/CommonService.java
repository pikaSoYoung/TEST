package com.example.spring.common.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.common.dao.CommonDao;

@Service
public class CommonService {
	
	@Resource(name="commonDao")
	CommonDao commonDao;
	
	public List<HashMap<String,String>> popup(){
		
		List<HashMap<String,String>> popupList = commonDao.popup();
		return popupList;
	}//popup	
}//CommonService
