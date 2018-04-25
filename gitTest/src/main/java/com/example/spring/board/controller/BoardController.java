package com.example.spring.board.controller;


import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.board.service.BoardService;
import com.example.spring.commons.util.UploadFileUtils;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	private String PRE_VIEW_PATH = "board/"; 
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
//	게시판 메인 페이지 이동
	@RequestMapping(value="/boardMain.do")
	public ModelAndView boardMain(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"boardMain");
		return mv;
	}//boardMain
	
//	게시판 글 등록 페이지 이동
	@RequestMapping(value="/boardWrite.do")
	public ModelAndView boardWrite() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"boardWrite");
		return mv;
	}//boardWrite

//	게시글 등록 
	@RequestMapping(value="/boardInsert.do")
	public @ResponseBody int boardInsert(@RequestParam HashMap<String,Object> paramMap,
			MultipartHttpServletRequest multi,HttpServletRequest request) {
		
		logger.info("paramMap : "+paramMap);
		
//		파일 리스트 저장 list
		List<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
		
		try {
			
//			파일 이름 리스트
			Iterator<String> files = multi.getFileNames();
			
	        while(files.hasNext()){
	        	
	            String uploadFile = files.next();              
	            MultipartFile mFile = multi.getFile(uploadFile); 
	            
//	            file 이름 변경 & 디렉토리에 저장
	            HashMap<String,String> fileMap = UploadFileUtils.uploadFile(mFile, request);
	            
//	            해당 파일 리스트에 추가
	            fileList.add(fileMap);
	           
	        }//while

		}catch(Exception e){
			e.printStackTrace();	
		}//try catch
		
		//게시물 & 파일 DB 저장 
		return  boardService.boardInsert(paramMap,fileList);		
	}//boardInsert
	
//	게시판 리스트 
	@RequestMapping(value="/boardList.do")
	public @ResponseBody List<HashMap<String,Object>> boardList(@RequestParam HashMap<String,Object> paramMap){
		
//		선택페이지가 1일 경우 
		if(((String)paramMap.get("choicePage")).equals("1")) {
			paramMap.put("noticeCountEnd", 10);
			paramMap.put("noticeCount", 0);
		}//if

//		게시물 리스트 저장
		List<HashMap<String,Object>> list = boardService.boardList(paramMap);	
		return list;
	}//boardList
	
//	게시물 상세정보 
	@RequestMapping(value="/boardDetail.do")
	public ModelAndView boardDetail(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		
//		게시물 상세정보 저장
		mv.addObject("boardMap",boardService.boardDetail(paramMap));
//		이전 페이지 정보 저장
		mv.addObject("paramMap",paramMap);
		
//		조회수증가
		mv.addObject("cntResult",boardService.updateCnt(paramMap));
		mv.setViewName(PRE_VIEW_PATH+"boardDetail");
		
		return mv;
	}//boardDetail
	
//	게시물 수정 페이지 이동
	@RequestMapping(value="/boardUpdateForm.do")
	public ModelAndView boardUpdateForm(@RequestParam HashMap<String,Object> paramMap) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("boardMap",boardService.boardDetail(paramMap));
		
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"boardUpdate");
		
		return mv;	
	}//boardUpdateForm
	
//	게시물 업데이트
	@RequestMapping(value="/boardUpdate.do")
	public @ResponseBody HashMap<String,Object> boardUpdate(@RequestParam HashMap<String,Object> paramMap,
			MultipartHttpServletRequest multi,HttpServletRequest request) {
		
//		파일 리스트 저장 list
		List<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
		
		try {
//			파일 이름 저장
			Iterator<String> files = multi.getFileNames();
			
	        while(files.hasNext()){
	        	
	            String uploadFile = files.next();            
	            MultipartFile mFile = multi.getFile(uploadFile);   
	            
//	            파일이름 변경 & 디렉토리에 파일 저장
	            HashMap<String,String> fileMap = UploadFileUtils.uploadFile(mFile, request);
	            
//	            해당 파일 리스트에 추가
	            fileList.add(fileMap);   
	        }//while    

		}catch(Exception e){
			e.printStackTrace();
		}//try catch
		
//		게시물 & 파일 DB 업데이트 
		int result = boardService.boardUpdate(paramMap,fileList);
		
//		이전 페이지 정보 & 업데이트 결과 저장
		paramMap.put("result", result);		
		return paramMap;
	}//boardUpdate
	
//	게시물 삭제
	@RequestMapping(value="/boardDelete.do")
	public @ResponseBody HashMap<String,Object> boardDelete(@RequestParam HashMap<String,Object> paramMap,
					@RequestParam(value="files") List<String> files, HttpServletRequest request ){
		
//		게시물 & 파일 DB 삭제
		int result = boardService.boardDelete(paramMap,files);
		
//      파일 리스트 존재하고 디비 삭제 성공시 if
		if(result==1 && files!=null && files.size()!=0) {
//			파일 리스트 for
			for(String file : files) {
					
				String fileName = file.substring(0,file.indexOf("^"));
					
				//디렉토리에서 파일 삭제
				UploadFileUtils.deleteFile(fileName, request);				
			}//for	
		}//if
		
//		삭제 결과 저장
		paramMap.put("result", result);
		return paramMap;	
	}//boardDelete
	
//	파일 삭제
	@RequestMapping(value="/fileDelete.do")
	public @ResponseBody int boardDelete(@RequestParam String fileId, HttpServletRequest request ){
		
		int result = boardService.fileDelete(fileId);
		
		//DB에서 삭제 성공시
		if(result==1) {
//			파일 이름 추출
			String fileName = fileId.substring(0,fileId.indexOf("^"));
//			디렉토리에서 해당 파일 삭제
			UploadFileUtils.deleteFile(fileName, request);
		}//if
		
//		해당 파일 DB에서 삭제
		return result;
	
	}//boardDelete	

//	파일 다운로드
	@RequestMapping(value="/fileDownload.do")
	public ResponseEntity<byte[]> fileDownload(@RequestParam HashMap<String,String> paramMap
			,HttpServletRequest request
			,HttpServletResponse response) {
		
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			HttpHeaders headers = new HttpHeaders();
			
		//파일 다운로드 try	
		try {
			
			in = new FileInputStream(UploadFileUtils.getRootPath(paramMap.get("sysName"), request)+"\\"+paramMap.get("sysName"));

			 headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			 headers.add("Content-Disposition", "attachment; fileName=\""
					 			+new String(paramMap.get("orgName").getBytes("UTF-8"),"ISO-8859-1")+"\"");
			 response.setHeader("Content-Transfer-Encoding", "binary");
			
			 entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				in.close();
			}catch(Exception e){
				e.printStackTrace();
			}			
		}//try catch finally
		
		return entity;	
	}//fileDownload
	
}//BoardController
