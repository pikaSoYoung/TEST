package com.example.spring.popup.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("popupDao")
public class PopupDao {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "popup.";
	
	public int popupInsert(HashMap<String,Object> paramMap) {

		return this.sqlSession.update(namespace+"popupInsert",paramMap);
	}//popupInsert
}//PopupDao
