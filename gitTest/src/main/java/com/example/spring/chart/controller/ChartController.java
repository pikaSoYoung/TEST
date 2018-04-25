package com.example.spring.chart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.chart.service.ChartService;

@Controller
public class ChartController {
	
	@Autowired
	private ChartService chartService;
	private String PRE_VIEW_PATH = "chart/";
	
	@RequestMapping(value="/chartTest.do")
	public ModelAndView chartTest() {
		
		ModelAndView mv = new ModelAndView ();
		mv.setViewName(PRE_VIEW_PATH+"chartTest");
		return mv;
	}//chartTest
	
}//ChartController
