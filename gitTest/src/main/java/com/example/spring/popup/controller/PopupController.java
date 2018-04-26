package com.example.spring.popup.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.spring.commons.util.UploadFileUtils;
import com.example.spring.popup.service.PopupService;

@Controller
public class PopupController {
	
	@Autowired
	private PopupService popupService;
	private String PRE_PATH_VIEW = "popup/";
	
	@RequestMapping(value="popupInsertForm.do")
	public String popupInsertForm() {
		
		return PRE_PATH_VIEW+"popupInsert";
	}//popupInsertForm
	
	@RequestMapping(value="popupInsert.do")
	public @ResponseBody int popupInsert(@RequestParam HashMap<String,Object> paramMap, 
				MultipartHttpServletRequest multi,HttpServletRequest request){
		
		try {		
			HashMap<String,String> fileMap = UploadFileUtils.uploadFile(multi.getFile("imgFile"),request);
			
			paramMap.put("pSysNm", fileMap.get("sysNm"));
			paramMap.put("pOrgNm", fileMap.get("orgNm"));
			
		}catch(Exception e) {
			e.printStackTrace();
		}//try catch

		return popupService.popupInsert(paramMap);
	}//popupInsert	
}//PopupController
