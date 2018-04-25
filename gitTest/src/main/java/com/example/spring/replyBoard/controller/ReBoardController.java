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
	
	//��۰Խ��� ���� ������ �̵�
	@RequestMapping(value="/reBoardMain.do")
	public ModelAndView replyBoardMain() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"reBoardMain");
		return mv;
	}//replyBoardMain
	
	//�Խù� ����Ʈ 
	@RequestMapping(value="/reBoardList.do")
	public @ResponseBody List<HashMap<String,Object>> reBoardList(@RequestParam HashMap<String,Object> paramMap){
		
		//���� �������� 1�� ��� if
		if(((String)paramMap.get("choicePage")).equals("1")) {
			paramMap.put("noticeCountEnd", 10);
			paramMap.put("noticeCount", 0);
		}//if

		List<HashMap<String,Object>> list = reBoardService.reBoardList(paramMap);
		return list;
	}//reBoardList
	
	//�Խñ� ��� ������ �̵�
	@RequestMapping(value="/reBoardWrite.do")
	public ModelAndView boardWrite() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"reBoardWrite");
		return mv;
	}//boardWrite
	
	//�Խù� ���
	@RequestMapping(value="/reBoardInsert.do")
	public @ResponseBody int boardInsert(@RequestParam HashMap<String,Object> paramMap) {
		
		return  reBoardService.reBoardInsert(paramMap);		
	}//boardInsert
	
	//�Խù� ������Ʈ
	@RequestMapping(value="/reBoardUpdate.do")
	public @ResponseBody HashMap<String,Object> boardUpdate(@RequestParam HashMap<String,Object> paramMap) {
	
		//�Խù� & ���� DB ������Ʈ 
		int result = reBoardService.reBoardUpdate(paramMap);
		
		//���� ������ ���� & ������Ʈ ��� ����
		paramMap.put("result", result);		
		return paramMap;
	}//boardUpdate
	
	//�Խù� ���� ������ �̵�
	@RequestMapping(value="/reBoardUpdateForm.do")
	public ModelAndView boardUpdateForm(@RequestParam HashMap<String,Object> paramMap) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("boardMap",reBoardService.reBoardDetail(paramMap));
		
		mv.addObject("paramMap",paramMap);
		mv.setViewName(PRE_VIEW_PATH+"reBoardUpdate");
		
		return mv;	
	}//boardUpdateForm

	//��� ���
	@RequestMapping(value="/replyInsert.do")
	public @ResponseBody HashMap<String,Object> replyInsert(@RequestParam HashMap<String,Object> paramMap) {
		
		HashMap<String,Object> replyMap = new HashMap<String,Object>(); 
	
		replyMap.put("result",reBoardService.replyInsert(paramMap));
		replyMap.put("reply", paramMap);
		return  replyMap;	
	}//replyInsert
	
	//�Խù� ������ 
	@RequestMapping(value="/reBoardDetail.do")
	public ModelAndView boardDetail(@RequestParam HashMap<String,Object> paramMap) {	
		
		ModelAndView mv = new ModelAndView();
		
		//�Խù� ������ ����
		mv.addObject("reBoardMap",reBoardService.reBoardDetail(paramMap));
		//���� ������ ���� ����
		mv.addObject("paramMap",paramMap);
		
		//��ȸ�� ����
		mv.addObject("cntResult",reBoardService.reUpdateCnt(paramMap));
		
		mv.setViewName(PRE_VIEW_PATH+"reBoardDetail");
		return mv;	
	}//boardDetail
	
	//��� ���� ����
	@RequestMapping(value="/replyLength.do")
	public @ResponseBody int replyLength(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyLength(paramMap);
	}//replyLength
	
	//�Խù� ����
	@RequestMapping(value="/reBoardDelete.do")
	public @ResponseBody int boardDelete(@RequestParam HashMap<String,Object> paramMap){

		return reBoardService.reBoardDelete(paramMap);	
	}//boardDelete
	
	//��� ����
	@RequestMapping(value="/replyUpdate.do")
	public @ResponseBody int replyUpdate(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyUpdate(paramMap);
	}//replyUpdate
	
	//��� ����
	@RequestMapping(value="/replyDelete.do")
	public @ResponseBody int replyDelete(@RequestParam HashMap<String,Object> paramMap) {
		
		return reBoardService.replyDelete(paramMap);
	}//replyDelete
	
	
	//����¡ �׽�Ʈ
	@RequestMapping(value="/testDataInsert.do")
	public ModelAndView testDataInsert() {

		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("index");
		mv.addObject("result", reBoardService.testDataInsert());
		
		return mv;
	}//testDataInsert

}//ReBoardController
