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
	
//	게시물 등록
	public int boardInsert(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"boardInsert",paramMap);
	}//boardInsert
	
//	게시물 리스트
	public List<HashMap<String,Object>> boardList(HashMap<String,Object> paramMap){
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(namespace+"boardList", paramMap);
		
		return list;	
	}//boardList
	
//	게시물 상세정보
	public HashMap<String,Object> boardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = this.sqlSession.selectOne(namespace+"boardDetail",paramMap);	
		map.put("fileList", this.sqlSession.selectList(namespace+"fileList",paramMap));
		
		return map;
	}//boardDetail
	
//	게시물 업데이트
	public int boardUpdate(HashMap<String,Object> paramMap){
		
		return this.sqlSession.update(namespace+"boardUpdate",paramMap);
	}//boardUpdate
	
//	게시물 삭제
	public int boardDelete(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"boardDelete",paramMap);
	}//boardDelete

//	조회수 증가
	public int updateCnt(HashMap<String,Object> paramMap) {
		
		return this.sqlSession.update(namespace+"updateCnt",paramMap);
	}//updateCnt
	
//	파일 등록
	public int fileInsert(HashMap<String,String> paramMap) {
		
		return this.sqlSession.update(namespace+"fileInsert",paramMap);		
	}//fileInsert
	
//	파일 삭제
	public int fileDelete(String fileNo) {
		
		return this.sqlSession.update(namespace+"fileDelete",fileNo);	
	}//fileDelete
	
//	파일 업데이트
	public int fileUpdate(HashMap<String,String> paramMap) { 
		
		return this.sqlSession.insert(namespace+"fileUpdate",paramMap);
	}//fileUpdate

}//BoardDao
