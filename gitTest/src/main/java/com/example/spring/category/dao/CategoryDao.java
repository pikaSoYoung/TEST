package com.example.spring.category.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("categoryDao")
public class CategoryDao {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "category.";
	
	//카테고리 리스트 
	public List<HashMap<String,Object>> categoryList(HashMap<String,String> paramMap){
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(namespace+"categoryList",paramMap);
		return list;
	}//categoryList
	
	//카테고리 등록
	public HashMap<String,Object> categoryInsert(HashMap<String,String> paramMap){
			
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("resultVal",this.sqlSession.update(namespace+"categoryInsert",paramMap));
		map.put("opNo",paramMap.get("opNo"));
		return map;	
	}//categoryInsert
	
	//카테고리 업데이트
	public int categoryUpdate(HashMap<String,String> paramMap) {
		
		return this.sqlSession.update(namespace+"categoryUpdate",paramMap);		
	}//categoryUpdate
	
	//카테고리 삭제
	public int categoryDelete(HashMap<String,String> paramMap) {
		
		return this.sqlSession.update(namespace+"categoryDelete",paramMap);
	}//categoryDelete
	
}//CategoryDao
