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
	
//	게시물 등록
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardInsert(HashMap<String,Object> paramMap,List<HashMap<String,String>> fileList) {
		
//		게시글 등록
		int result =  boardDao.boardInsert(paramMap);
		
//		파일 리스트 for	
		for(HashMap<String,String> map : fileList) {
//			파일 등록	
			result = boardDao.fileInsert(map);
		}//for
			
		return result;
	}//boardInsert

//	게시물 리스트
	public List<HashMap<String,Object>> boardList(HashMap<String,Object> paramMap ){
		
		List<HashMap<String,Object>> list = boardDao.boardList(paramMap);
		return list;
	}//boardList

//	게시물 상세정보
	public HashMap<String,Object> boardDetail(HashMap<String,Object> paramMap){
		
		HashMap<String,Object> map = boardDao.boardDetail(paramMap);
		return map;
	}//boardDetail
	
//	게시물 업데이트
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardUpdate(HashMap<String,Object> paramMap,List<HashMap<String,String>> fileList) {
		
//		게시글 업데이트
		int result = boardDao.boardUpdate(paramMap);
//		게시물 번호 추출
		String boardNo =  (String)paramMap.get("boardNo"); 
	
//		파일 리스트 for
		for(HashMap<String,String> map : fileList) {
			map.put("boardNo",boardNo);
//			새로운 파일 DB등록
			result = boardDao.fileUpdate(map);
				
		}//for
		
		return result;
	}//boardUpdate
	
//	게시물 삭제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class})
	public int boardDelete(HashMap<String,Object> paramMap, List<String> files){
		
//		게시글 삭제
		int result = boardDao.boardDelete(paramMap);
		
//		파일 리스트 존재 시 if
		if(files != null && files.size() >0) {
			
			//파일 리스트 for
			for(String file : files) {
				//해당 파일 번호 추출
				String fileNo = file.substring(file.indexOf("^")+1);
				//해당 파일 DB에서 삭제
				result = boardDao.fileDelete(fileNo);
			}//for
		}//if

		return result;
	}//boardDelete
	
//	파일 삭제
	public int fileDelete(String fileId) {
		
		//파일 번호 추출
		String fileNo = fileId.substring(fileId.indexOf("^")+1);
		
		return boardDao.fileDelete(fileNo);	
	}//fileDelete
	
//	조회수 증가
	public int updateCnt(HashMap<String,Object> paramMap) {
		
		return boardDao.updateCnt(paramMap);
	}//updateCnt
	
//	파일 등록
	public int fileInsert(List<HashMap<String,String>> fileList) {
		
		int result = 0;
		
		//파일 리스트 for
		for(HashMap<String,String> map : fileList ) {
			
			//해당 파일 DB 저장
			result = boardDao.fileInsert(map);
			
			if(result!=1) {
				return result;
			}//if	
		}//for
		
		return result;	
	}//fileInsert	
}//BoardService
