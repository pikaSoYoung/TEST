package com.example.spring.excelUpload.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.commons.util.ExcelRead;
import com.example.spring.commons.util.ExcelReadOption;
import com.example.spring.excelUpload.dao.ExcelDao;

@Service
public class ExcelService {
	
	@Resource (name="excelDao")
	private ExcelDao excelDao;
	
	public void excelUpload(File destFile) throws Exception{
        ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("A","B","C","D","E");
        excelReadOption.setStartRow(2);
        
        //리스트에 읽어온 값 저장
        List<Map<String, String>>excelContents =ExcelRead.read(excelReadOption);
        
        excelDao.excelUpload(excelContents);   
        
        
       /*  mapper 에서 해당 list를 받아서 한번에 저장하는 방식으로 바꿈 2018_04_26
        //리스트에서 등록시킬 data set 추출 for
        for(Map<String, String> article: excelContent){
        	
        	//해당 추출된 data set 등록 
            excelDao.excelUpload(article);    
        }//for
        */
        
	}//excelUpload   
}//ExcelService
