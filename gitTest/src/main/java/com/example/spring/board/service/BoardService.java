package com.example.spring.board.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.example.spring.board.dao.BoardDao;

@Service
public class BoardService {
	
	@Resource(name="boardDao")
	private BoardDao boardDao;
	
//	�Խù� ���
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardInsert(HashMap<String,Object> paramMap,List<HashMap<String,String>> fileList) {
		
//		�Խñ� ���
		int result =  boardDao.boardInsert(paramMap);
		
//		���� ����Ʈ for	
		for(HashMap<String,String> map : fileList) {
//			���� ���	
			result = boardDao.fileInsert(map);
		}//for
			
		return result;
	}//boardInsert

//	�Խù� ����Ʈ
	public List<HashMap<String,Object>> boardList(HashMap<String,Object> paramMap ){
		
		List<HashMap<String,Object>> list = boardDao.boardList(paramMap);
		return list;
	}//boardList

//	�Խù� ������
	public HashMap<String,Object> boardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = boardDao.boardDetail(paramMap);
		return map;
	}//boardDetail
	
//	�Խù� ������Ʈ
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardUpdate(HashMap<String,Object> paramMap,List<HashMap<String,String>> fileList) {
		
//		�Խñ� ������Ʈ
		int result = boardDao.boardUpdate(paramMap);
//		�Խù� ��ȣ ����
		String boardNo =  (String)paramMap.get("boardNo"); 
	
//		���� ����Ʈ for
		for(HashMap<String,String> map : fileList) {
			map.put("boardNo",boardNo);
//			���ο� ���� DB���
			result = boardDao.fileUpdate(map);
				
		}//for
		
		return result;
	}//boardUpdate
	
//	�Խù� ����
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardDelete(HashMap<String,Object> paramMap, List<String> files){
		
//		�Խñ� ����
		int result = boardDao.boardDelete(paramMap);
		
//		���� ����Ʈ ���� �� if
		if(files != null && files.size() >0) {
			
			//���� ����Ʈ for
			for(String file : files) {
				//�ش� ���� ��ȣ ����
				String fileNo = file.substring(file.indexOf("^")+1);
				//�ش� ���� DB���� ����
				result = boardDao.fileDelete(fileNo);
			}//for
		}//if

		return result;
	}//boardDelete
	
//	���� ����
	public int fileDelete(String fileId) {
		
		//���� ��ȣ ����
		String fileNo = fileId.substring(fileId.indexOf("^")+1);
		
		return boardDao.fileDelete(fileNo);	
	}//fileDelete
	
//	��ȸ�� ����
	public int updateCnt(HashMap<String,Object> paramMap) {
		
		return boardDao.updateCnt(paramMap);
	}//updateCnt
	
//	���� ���
	public int fileInsert(List<HashMap<String,String>> fileList) {
		
		int result = 0;
		
		//���� ����Ʈ for
		for(HashMap<String,String> map : fileList ) {
			
			//�ش� ���� DB ����
			result = boardDao.fileInsert(map);
			
			if(result!=1) {
				return result;
			}//if	
		}//for
		
		return result;	
	}//fileInsert	
}//BoardService
