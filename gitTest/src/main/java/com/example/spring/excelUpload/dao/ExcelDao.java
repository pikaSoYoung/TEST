package com.example.spring.excelUpload.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("excelDao") 
public class ExcelDao {
	
	@Autowired
	private SqlSession sqlsession;
	private String namespace = "excel.";
	
	//엑셀 파일 업로드
	public void excelUpload(List<Map<String,String>> excelContents) {
		
		this.sqlsession.insert(namespace+"excelUpload",excelContents);
	}//excelUpload
	
}//ExcelDao
