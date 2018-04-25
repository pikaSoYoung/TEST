package com.example.spring.board.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDao {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "board.";
	
//	�Խù� ���
	public int boardInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"boardInsert",paramMap);
	}//boardInsert
	
//	�Խù� ����Ʈ
	public List<HashMap<String,Object>> boardList(HashMap<String,Object> paramMap){
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(namespace+"boardList", paramMap);
		
		return list;	
	}//boardList
	
//	�Խù� ������
	public HashMap<String,Object> boardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = this.sqlSession.selectOne(namespace+"boardDetail",paramMap);	
		map.put("fileList", this.sqlSession.selectList(namespace+"fileList",paramMap));
		
		return map;
	}//boardDetail
	
//	�Խù� ������Ʈ
	public int boardUpdate(HashMap<String,Object> paramMap){
		
		return this.sqlSession.update(namespace+"boardUpdate",paramMap);
	}//boardUpdate
	
//	�Խù� ����
	public int boardDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"boardDelete",paramMap);
	}//boardDelete

//	��ȸ�� ����
	public int updateCnt(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"updateCnt",paramMap);
	}//updateCnt
	
//	���� ���
	public int fileInsert(HashMap<String,String> paramMap) {
		
		return this.sqlSession.update(namespace+"fileInsert",paramMap);		
	}//fileInsert
	
//	���� ����
	public int fileDelete(String fileNo) {
		
		return this.sqlSession.update(namespace+"fileDelete",fileNo);	
	}//fileDelete
	
//	���� ������Ʈ
	public int fileUpdate(HashMap<String,String> paramMap) { 
		
		return this.sqlSession.insert(namespace+"fileUpdate",paramMap);
	}//fileUpdate

}//BoardDao
