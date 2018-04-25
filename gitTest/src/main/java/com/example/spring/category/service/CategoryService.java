package com.example.spring.category.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.category.dao.CategoryDao;

@Service
public class CategoryService {
	
	@Resource(name="categoryDao")
	private CategoryDao categoryDao;
	
	//카테고리 리스트 출력
	public List<HashMap<String,Object>> categoryList(HashMap<String,String> paramMap){
		
		List<HashMap<String,Object>> list = categoryDao.categoryList(paramMap);
		return list;	
	}//categoryList
	
	//카테고리 등록
	public HashMap<String,Object> categoryInsert(HashMap<String,String> paramMap){
		
		HashMap<String,Object> map = categoryDao.categoryInsert(paramMap);
		return map;		
	}//categoryInsert
	
	//카테고리 수정
	public int categoryUpdate(HashMap<String,String> paramMap) {
		
		return categoryDao.categoryUpdate(paramMap);	
	}//categoryUpdate
	
	//카테고리 삭제
	public int categoryDelete(HashMap<String,String> paramMap) {
		
		return categoryDao.categoryDelete(paramMap);
	}//categoryDelete
	
}//CategoryService
