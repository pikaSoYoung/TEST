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
	
	//게시물 리스트
	public List<HashMap<String,Object>> reBoardList(HashMap<String,Object> paramMap){
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(namespace+"reBoardList", paramMap);
		return list;	
	}//reBoardList
	
	//게시물 등록
	public int reBoardInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reBoardInsert",paramMap);	
	}//reBoardInsert
	
	//댓글 긍록
	public int replyInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyInsert",paramMap);	
	}//replyInsert
	
	//게시물 상세정보
	public HashMap<String,Object> reBoardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = this.sqlSession.selectOne(namespace+"reBoardDetail",paramMap);	
		map.put("replyList", this.sqlSession.selectList(namespace+"replyDetail", paramMap));
		
		return map;
	}//reBoardDetail
	
	//조회수 증가
	public int reUpdateCnt(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reUpdateCnt",paramMap);
	}//reUpdateCnt
	
	//게시물 업데이트
	public int reBoardUpdate(HashMap<String,Object> paramMap){
		
		return this.sqlSession.update(namespace+"reBoardUpdate",paramMap);
	}//boardUpdate
	
	
	//게시물 삭제
	public int reBoardDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"reBoardDelete",paramMap);
	}//reBoardDelete
	
	//댓글 갯수 추출
	public int replyLength(HashMap<String,Object> paramMap) { 
	
		return this.sqlSession.selectOne(namespace+"replyLength",paramMap);
	}//replyLength
	
	//댓글 수정
	public int replyUpdate(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyUpdate",paramMap);
	}//replyUpdate
	
	//댓글 삭제
	public int replyDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"replyDelete",paramMap);
	}//replyDelete
	
}//ReBoardDao
