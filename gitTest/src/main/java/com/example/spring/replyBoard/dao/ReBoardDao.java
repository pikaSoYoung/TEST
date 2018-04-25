package com.example.spring.replyBoard.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("reBoardDao")
public class ReBoardDao {
	
	@Autowired
	private SqlSession sqlSession;
	String namespace = "reBoard.";
	
	//�Խù� ����Ʈ
	public List<HashMap<String,Object>> reBoardList(HashMap<String,Object> paramMap){
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(namespace+"reBoardList", paramMap);
		return list;	
	}//reBoardList
	
	//�Խù� ���
	public int reBoardInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reBoardInsert",paramMap);	
	}//reBoardInsert
	
	//��� ���
	public int replyInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyInsert",paramMap);	
	}//replyInsert
	
	//�Խù� ������
	public HashMap<String,Object> reBoardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = this.sqlSession.selectOne(namespace+"reBoardDetail",paramMap);	
		map.put("replyList", this.sqlSession.selectList(namespace+"replyDetail", paramMap));
		
		return map;
	}//reBoardDetail
	
	//��ȸ�� ����
	public int reUpdateCnt(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reUpdateCnt",paramMap);
	}//reUpdateCnt
	
	//�Խù� ������Ʈ
	public int reBoardUpdate(HashMap<String,Object> paramMap){
		
		return this.sqlSession.update(namespace+"reBoardUpdate",paramMap);
	}//boardUpdate
	
	
	//�Խù� ����
	public int reBoardDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reBoardDelete",paramMap);
	}//reBoardDelete
	
	//��� ���� ����
	public int replyLength(HashMap<String,Object> paramMap) { 
	
		return this.sqlSession.selectOne(namespace+"replyLength",paramMap);
	}//replyLength
	
	//��� ����
	public int replyUpdate(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyUpdate",paramMap);
	}//replyUpdate
	
	//��� ����
	public int replyDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyDelete",paramMap);
	}//replyDelete
	
}//ReBoardDao
