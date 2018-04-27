package com.example.spring.popup.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.popup.dao.PopupDao;

@Service
public class PopupService {

	@Resource(name="popupDao")
	private PopupDao popupDao;
	
	public int popupInsert(HashMap<String,Object> paramMap) {
		
		return popupDao.popupInsert(paramMap);	
	}//popupInsert
	
	public List<HashMap<String,String>> popupList(){
	
		List<HashMap<String,String>> list = popupDao.popupList();
		
		return list;
	}//popupList
}//PopupService
