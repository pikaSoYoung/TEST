package com.example.spring.common.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApiController {
	
	@RequestMapping(value="apiSample.do")
	public String apiSample() {
		
		return "api/sample";
	}

	@RequestMapping(value="addressApi.ajax")
	public void  getAddrApi(HttpServletRequest req,
			 HttpServletResponse response) throws Exception{
		
		 String currentPage = req.getParameter("currentPage");
		 String countPerPage = req.getParameter("countPerPage");
		 String resultType = req.getParameter("resultType");
		 String confmKey = req.getParameter("confmKey");
		 String keyword = req.getParameter("keyword");
		 
		
		 String apiUrl = "http://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage="+currentPage+
		 "&countPerPage="+countPerPage+
		 "&keyword="+URLEncoder.encode(keyword,"UTF-8")+
		 "&confmKey="+confmKey+"&resultType="+resultType;
		 
		 URL url = new URL(apiUrl);
		 
		 BufferedReader br = new BufferedReader(
		 new InputStreamReader(url.openStream(),"UTF-8"));
		 
		 StringBuffer sb = new StringBuffer();
		 String tempStr = null;
		 
		 while(true){
			 tempStr = br.readLine();
			 if(tempStr == null) break;
			 sb.append(tempStr); // 결과 JSON
		 }//while
		 
		 br.close();
		 response.setCharacterEncoding("UTF-8");
		 response.setContentType("text/xml");
		 response.getWriter().write(sb.toString()); //결과 반홖
	}
	
}
