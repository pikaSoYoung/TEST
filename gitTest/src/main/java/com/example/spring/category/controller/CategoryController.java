package com.example.spring.category.controller;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.category.service.CategoryService;


@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;
	private String PRE_VIEW_PATH = "category/";
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	//카테고리 메인 화면
	@RequestMapping(value="/categoryMain.do")
	public ModelAndView categoryMain() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(PRE_VIEW_PATH+"categoryMain");
		return mav;
	}//categoryMain
	
	//카테고리 리스트 출력
	@RequestMapping(value="/categoryList.do")
	public @ResponseBody List<HashMap<String,Object>> categoryList(@RequestParam HashMap<String,String> paramMap) {
		
		List<HashMap<String,Object>> list = categoryService.categoryList(paramMap);
		return list;
	}//categoryList
	
	//카테고리 등록
	@RequestMapping(value="/categoryInsert.do")
	public @ResponseBody HashMap<String,Object> categoryInsert(@RequestParam HashMap<String,String> paramMap) {
		
		HashMap<String,Object> map = categoryService.categoryInsert(paramMap);
		return map;
	}//categoryInsert
	
	//카테고리 업데이트
	@RequestMapping(value="/categoryUpdate.do")
	public @ResponseBody int categoryUpdate(@RequestParam HashMap<String,String> paramMap) {
		
		return categoryService.categoryUpdate(paramMap);
	}//categoryUpdate
	
	//카테고리 삭제
	@RequestMapping(value="/categoryDelete.do")
	public @ResponseBody int categoryDelelte(@RequestParam HashMap<String,String> paramMap) {
		
		return categoryService.categoryDelete(paramMap);
	}//categoryDelelte

}//CategoryController
