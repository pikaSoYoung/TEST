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
        
        //����Ʈ�� �о�� �� ����
        List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
        
        //����Ʈ���� ��Ͻ�ų data set ���� for
        for(Map<String, String> article: excelContent){
        	
        	//�ش� ����� data set ��� 
            excelDao.excelUpload(article);    
        }//for
        
	}//excelUpload   
}//ExcelService
