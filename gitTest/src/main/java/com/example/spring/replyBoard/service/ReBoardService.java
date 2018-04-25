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
	
	//�Խù� ����Ʈ
	public List<HashMap<String,Object>> reBoardList(HashMap<String,Object> paramMap ){
		
		List<HashMap<String,Object>> list = reBoardDao.reBoardList(paramMap);
		return list;
	}//reBoardList
	
	//�Խù� ���
	public int reBoardInsert(HashMap<String,Object> paramMap) {
		
		int result =  reBoardDao.reBoardInsert(paramMap);
		return result;	
	}//reBoardInsert
	
	//��� ���
	public int replyInsert(HashMap<String,Object> paramMap) {
		
		int result =  reBoardDao.replyInsert(paramMap);
		return result;
	}//replyInsert
	
	//�Խù� ������
	public HashMap<String,Object> reBoardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = reBoardDao.reBoardDetail(paramMap);
		return map;
	}//reBoardDetail
	
	//��ȸ�� ����
	public int reUpdateCnt(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reUpdateCnt(paramMap);
	}//reUpdateCnt
	
	//�Խù� ������Ʈ
	public int reBoardUpdate(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reBoardUpdate(paramMap);
	}//boardUpdate
	
	//�Խù� ����
	public int reBoardDelete(HashMap<String,Object> paramMap) {
		
		return reBoardDao.reBoardDelete(paramMap);
	}//reBoardDelete
	
	//��� ����
	public int replyUpdate(HashMap<String,Object> paramMap) {
		
		return reBoardDao.replyUpdate(paramMap);
	}//replyUpdate
	
	//��� ����
	public int replyDelete(HashMap<String,Object> paramMap) {
		
		return reBoardDao.replyDelete(paramMap);
	}//replyDelete
	
	//��� ���� ����
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
			map.put("boardContent","test ���Դϴ�.");
			
			reBoardDao.reBoardInsert(map);
		}//for
		*/
		return 1;
	}//testDataInsert
	
}//ReBoardService
