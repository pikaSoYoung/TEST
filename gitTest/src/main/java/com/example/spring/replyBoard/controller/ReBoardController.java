package com.example.spring.replyBoard.controller;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.replyBoard.service.ReBoardService;

@Controller
public class ReBoardController {
	
	@Autowired
	private ReBoardService reBoardService;
	private String PRE_VIEW_PATH = "replyBoard/";
	
	//댓글게시판 메인 페이지 이동
	@RequestMapping(value="/reBoardMain.do")
	public ModelAndView replyBoardMain() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"reBoardMain");
		return mv;
	}//replyBoardMain
	
	//게시물 리스트 
	@RequestMapping(value="/reBoardList.do")
	public @ResponseBody List<HashMap<String,Object>> reBoardList(@RequestParam HashMap<String,Object> paramMap){
		
		//선택 페이지가 1일 경우 if
		if(((String)paramMap.get("choicePage")).equals("1")) {
			paramMap.put("noticeCountEnd", 10);
			paramMap.put("noticeCount", 0);
		}//if

		List<HashMap<String,Object>> list = reBoardService.reBoardList(paramMap);
		return list;
	}//reBoardList
	
	//게시글 등록 페이지 이동
	@RequestMapping(value="/reBoardWrite.do")
	public ModelAndView boardWrite() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"reBoardWrite");
		return mv;
	}//boardWrite
	
	//게시물 등록
	@RequestMapping(value="/reBoardInsert.do")
	public @ResponseBody int boardInsert(@RequestParam HashMap<String,Object> paramMap) {
		
		return  reBoardService.reBoardInsert(paramMap);		
	}//boardInsert
	
	//게시물 업데이트
	@RequestMapping(value="/reBoardUpdate.do")
	public @ResponseBody HashMap<String,Object> boardUpdate(@RequestParam HashMap<String,Object> paramMap) {
	
		//게시물 & 파일 DB 업데이트 
		int result = reBoardService.reBoardUpdate(paramMap);
		
		//이전 페이지 정보 & 업데이트 결과 저장
		paramMap.put("result", result);		
		return paramMap;
	}//boardUpdate
	
	//게시물 수정 페이지 이동
	@RequestMapping(value="/reBoardUpdateForm.do")
	public ModelAndView boardUpdateForm(@RequestParam HashMap<String,Object> paramMap) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("boardMap",reBoardService.reBoardDetail(paramMap));
		
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"reBoardUpdate");
		
		return mv;	
	}//boardUpdateForm

	//댓글 등록
	@RequestMapping(value="/replyInsert.do")
	public @ResponseBody HashMap<String,Object> replyInsert(@RequestParam HashMap<String,Object> paramMap) {
		
		HashMap<String,Object> replyMap = new HashMap<String,Object>(); 
	
		replyMap.put("result",reBoardService.replyInsert(paramMap));
		replyMap.put("reply", paramMap);
		return  replyMap;	
	}//replyInsert
	
	//게시물 상세정보 
	@RequestMapping(value="/reBoardDetail.do")
	public ModelAndView boardDetail(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		
		//게시물 상세정보 저장
		mv.addObject("reBoardMap",reBoardService.reBoardDetail(paramMap));
		//이전 페이지 정보 저장
		mv.addObject("paramMap",paramMap);
		
		//조회수 증가
		mv.addObject("cntResult",reBoardService.reUpdateCnt(paramMap));
		
		mv.setViewName(PRE_VIEW_PATH+"reBoardDetail");
		return mv;	
	}//boardDetail
	
	//댓글 갯수 추출
	@RequestMapping(value="/replyLength.do")
	public @ResponseBody int replyLength(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyLength(paramMap);
	}//replyLength
	
	//게시물 삭제
	@RequestMapping(value="/reBoardDelete.do")
	public @ResponseBody int boardDelete(@RequestParam HashMap<String,Object> paramMap){

		return reBoardService.reBoardDelete(paramMap);	
	}//boardDelete
	
	//댓글 수정
	@RequestMapping(value="/replyUpdate.do")
	public @ResponseBody int replyUpdate(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyUpdate(paramMap);
	}//replyUpdate
	
	//댓글 삭제
	@RequestMapping(value="/replyDelete.do")
	public @ResponseBody int replyDelete(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyDelete(paramMap);
	}//replyDelete
	
	
	//페이징 테스트
	@RequestMapping(value="/testDataInsert.do")
	public ModelAndView testDataInsert() {

		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("index");
		mv.addObject("result", reBoardService.testDataInsert());
		
		return mv;
	}//testDataInsert

}//ReBoardController
