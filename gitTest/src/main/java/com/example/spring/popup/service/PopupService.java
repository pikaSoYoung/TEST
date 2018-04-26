package com.example.spring.popup.service;

import java.util.HashMap;

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
}
