package com.example.spring.excelUpload.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.excelUpload.service.ExcelService;

@Controller
public class ExcelController {
	
	@Autowired
	private ExcelService excelService;
	private String PRE_VIEW_PATH = "excel/";
	
	//엑셀 폼 페이지 이동
	@RequestMapping(value="/excelFileForm.do")
	public ModelAndView excelFileForm() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName(PRE_VIEW_PATH+"excelFileForm");
		return mv;
	}//excelFileForm
	
	//엑셀 파일 업로드
	@RequestMapping(value = "/excelUploadAjax.do", method = RequestMethod.POST)
    public @ResponseBody String excelUploadAjax(MultipartHttpServletRequest request)  throws Exception{
        MultipartFile excelFile =request.getFile("excelFile");
        
        //exelFile 여부 if
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }//if
        
        //D 디렉토리 경로에 엑셀 파일 임시 생성
        File destFile = new File("D:\\"+excelFile.getOriginalFilename());
        
        try{
            excelFile.transferTo(destFile);
        }catch(IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }//try catch
        
        //cahch - > IllegalStateException | IOException 에서 IllegalStateException 부분 에러로 삭제( java 1.6 )
        
        excelService.excelUpload(destFile);
        
        //임시 파일 객체 삭제
        FileUtils.deleteQuietly(destFile);

        return "";
    }//excelUploadAjax
	
}//ExcelController
