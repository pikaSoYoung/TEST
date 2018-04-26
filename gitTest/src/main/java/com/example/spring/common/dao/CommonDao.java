package com.example.spring.common.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("commonDao")
public class CommonDao {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "common.";
	
	public List<HashMap<String,String>> popup() {
		
		List<HashMap<String,String>> popupList = this.sqlSession.selectList(namespace+"popup");
		return popupList;
	}//popup
}//CommonDao
