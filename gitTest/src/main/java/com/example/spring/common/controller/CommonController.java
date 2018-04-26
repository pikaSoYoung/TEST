package com.example.spring.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.spring.common.service.CommonService;

@Controller
public class CommonController {

	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "index";
	}//home
	
	@RequestMapping(value="/popup.ajax")
	public @ResponseBody List<HashMap<String,String>> popup() {
		
		List<HashMap<String,String>> popupList = commonService.popup();
		
		return popupList;
	}//popup
}//CommonController
