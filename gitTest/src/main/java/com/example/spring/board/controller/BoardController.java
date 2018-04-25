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
	
//	�Խ��� ���� ������ �̵�
	@RequestMapping(value="/boardMain.do")
	public ModelAndView boardMain(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"boardMain");
		return mv;
	}//boardMain
	
//	�Խ��� �� ��� ������ �̵�
	@RequestMapping(value="/boardWrite.do")
	public ModelAndView boardWrite() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"boardWrite");
		return mv;
	}//boardWrite

//	�Խñ� ��� 
	@RequestMapping(value="/boardInsert.do")
	public @ResponseBody int boardInsert(@RequestParam HashMap<String,Object> paramMap,
			MultipartHttpServletRequest multi,HttpServletRequest request) {
		
		logger.info("paramMap : "+paramMap);
		
//		���� ����Ʈ ���� list
		List<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
		
		try {
			
//			���� �̸� ����Ʈ
			Iterator<String> files = multi.getFileNames();
			
	        while(files.hasNext()){
	        	
	            String uploadFile = files.next();              
	            MultipartFile mFile = multi.getFile(uploadFile); 
	            
//	            file �̸� ���� & ���丮�� ����
	            HashMap<String,String> fileMap = UploadFileUtils.uploadFile(mFile, request);
	            
//	            �ش� ���� ����Ʈ�� �߰�
	            fileList.add(fileMap);
	           
	        }//while

		}catch(Exception e){
			e.printStackTrace();	
		}//try catch
		
		//�Խù� & ���� DB ���� 
		return  boardService.boardInsert(paramMap,fileList);		
	}//boardInsert
	
//	�Խ��� ����Ʈ 
	@RequestMapping(value="/boardList.do")
	public @ResponseBody List<HashMap<String,Object>> boardList(@RequestParam HashMap<String,Object> paramMap){
		
//		������������ 1�� ��� 
		if(((String)paramMap.get("choicePage")).equals("1")) {
			paramMap.put("noticeCountEnd", 10);
			paramMap.put("noticeCount", 0);
		}//if

//		�Խù� ����Ʈ ����
		List<HashMap<String,Object>> list = boardService.boardList(paramMap);	
		return list;
	}//boardList
	
//	�Խù� ������ 
	@RequestMapping(value="/boardDetail.do")
	public ModelAndView boardDetail(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		
//		�Խù� ������ ����
		mv.addObject("boardMap",boardService.boardDetail(paramMap));
//		���� ������ ���� ����
		mv.addObject("paramMap",paramMap);
		
//		��ȸ������
		mv.addObject("cntResult",boardService.updateCnt(paramMap));
		mv.setViewName(PRE_VIEW_PATH+"boardDetail");
		
		return mv;
	}//boardDetail
	
//	�Խù� ���� ������ �̵�
	@RequestMapping(value="/boardUpdateForm.do")
	public ModelAndView boardUpdateForm(@RequestParam HashMap<String,Object> paramMap) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("boardMap",boardService.boardDetail(paramMap));
		
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"boardUpdate");
		
		return mv;	
	}//boardUpdateForm
	
//	�Խù� ������Ʈ
	@RequestMapping(value="/boardUpdate.do")
	public @ResponseBody HashMap<String,Object> boardUpdate(@RequestParam HashMap<String,Object> paramMap,
			MultipartHttpServletRequest multi,HttpServletRequest request) {
		
//		���� ����Ʈ ���� list
		List<HashMap<String,String>> fileList = new ArrayList<HashMap<String,String>>();
		
		try {
//			���� �̸� ����
			Iterator<String> files = multi.getFileNames();
			
	        while(files.hasNext()){
	        	
	            String uploadFile = files.next();            
	            MultipartFile mFile = multi.getFile(uploadFile);   
	            
//	            �����̸� ���� & ���丮�� ���� ����
	            HashMap<String,String> fileMap = UploadFileUtils.uploadFile(mFile, request);
	            
//	            �ش� ���� ����Ʈ�� �߰�
	            fileList.add(fileMap);   
	        }//while    

		}catch(Exception e){
			e.printStackTrace();
		}//try catch
		
//		�Խù� & ���� DB ������Ʈ 
		int result = boardService.boardUpdate(paramMap,fileList);
		
//		���� ������ ���� & ������Ʈ ��� ����
		paramMap.put("result", result);		
		return paramMap;
	}//boardUpdate
	
//	�Խù� ����
	@RequestMapping(value="/boardDelete.do")
	public @ResponseBody HashMap<String,Object> boardDelete(@RequestParam HashMap<String,Object> paramMap,
					@RequestParam(value="files") List<String> files, HttpServletRequest request ){
		
//		�Խù� & ���� DB ����
		int result = boardService.boardDelete(paramMap,files);
		
//      ���� ����Ʈ �����ϰ� ��� ���� ������ if
		if(result==1 && files!=null && files.size()!=0) {
//			���� ����Ʈ for
			for(String file : files) {
					
				String fileName = file.substring(0,file.indexOf("^"));
					
				//���丮���� ���� ����
				UploadFileUtils.deleteFile(fileName, request);				
			}//for	
		}//if
		
//		���� ��� ����
		paramMap.put("result", result);
		return paramMap;	
	}//boardDelete
	
//	���� ����
	@RequestMapping(value="/fileDelete.do")
	public @ResponseBody int boardDelete(@RequestParam String fileId, HttpServletRequest request ){
		
		int result = boardService.fileDelete(fileId);
		
		//DB���� ���� ������
		if(result==1) {
//			���� �̸� ����
			String fileName = fileId.substring(0,fileId.indexOf("^"));
//			���丮���� �ش� ���� ����
			UploadFileUtils.deleteFile(fileName, request);
		}//if
		
//		�ش� ���� DB���� ����
		return result;
	
	}//boardDelete	

//	���� �ٿ�ε�
	@RequestMapping(value="/fileDownload.do")
	public ResponseEntity<byte[]> fileDownload(@RequestParam HashMap<String,String> paramMap
			,HttpServletRequest request
			,HttpServletResponse response) {
		
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			HttpHeaders headers = new HttpHeaders();
			
		//���� �ٿ�ε� try	
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
