package com.example.spring.replyBoard.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.replyBoard.dao.ReBoardDao;

@Service
public class ReBoardService {

	@Resource(name="reBoardDao")
	private ReBoardDao reBoardDao;
	
	//게시물 리스트
	public List<HashMap<String,Object>> reBoardList(HashMap<String,Object> paramMap ){
		
		List<HashMap<String,Object>> list = reBoardDao.reBoardList(paramMap);
		return list;
	}//reBoardList
	
	//게시물 등록
	public int reBoardInsert(HashMap<String,Object> paramMap) {
		
		int result =  reBoardDao.reBoardInsert(paramMap);
		return result;	
	}//reBoardInsert
	
	//댓글 등록
	public int replyInsert(HashMap<String,Object> paramMap) {
		
		int result =  reBoardDao.replyInsert(paramMap);
		return result;
	}//replyInsert
	
	//게시물 상세정보
	public HashMap<String,Object> reBoardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = reBoardDao.reBoardDetail(paramMap);
		return map;
	}//reBoardDetail
	
	//조회수 증가
	public int reUpdateCnt(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reUpdateCnt(paramMap);
	}//reUpdateCnt
	
	//게시물 업데이트
	public int reBoardUpdate(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reBoardUpdate(paramMap);
	}//boardUpdate
	
	//게시물 삭제
	public int reBoardDelete(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reBoardDelete(paramMap);
	}//reBoardDelete
	
	//댓글 수정
	public int replyUpdate(HashMap<String,Object> paramMap) {
		
		return reBoardDao.replyUpdate(paramMap);
	}//replyUpdate
	
	//댓글 삭제
	public int replyDelete(HashMap<String,Object> paramMap) {
		
		return reBoardDao.replyDelete(paramMap);
	}//replyDelete
	
	//댓글 개수 추출
	public int replyLength(HashMap<String,Object> paramMap) {
		
		return reBoardDao.replyLength(paramMap);
	}//replyLength
	
	
	//test data insert
	public int testDataInsert() {
		
		String str = "test";
		
/*		for(int i=1; i<=300; i++) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("boardTitle",str+i);
			map.put("boardWriter",str+i);
			map.put("boardContent","test 중입니다.");
			
			reBoardDao.reBoardInsert(map);
		}//for
		*/
		return 1;
	}//testDataInsert
	
}//ReBoardService
