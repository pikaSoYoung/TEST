package com.example.spring.commons.util;

import java.util.ArrayList;
import java.util.List;
 
public class ExcelReadOption {
    /**
     * 엑셀파일의 경로
     */
    private String filePath;
    
    /**
     * 추출할 컬럼 명
     */
    private List<String> outputColumns;
    
    /**
     * 추출을 시작할 행 번호
     */
    private int startRow;
    
    public String getFilePath() {
        return filePath;
    }//getFilePath
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }//setFilePath
    
    public List<String> getOutputColumns() {
        
        List<String> temp = new ArrayList<String>();
        temp.addAll(outputColumns);
        
        return temp;
    }//getOutputColumns
    
    public void setOutputColumns(List<String> outputColumns) {
        
        List<String> temp = new ArrayList<String>();
        temp.addAll(outputColumns);
        
        this.outputColumns = temp;
    }//setOutputColumns
    
    public void setOutputColumns(String ... outputColumns) {
        
        if(this.outputColumns == null) {
            this.outputColumns = new ArrayList<String>();
        }//if
        
        for(String ouputColumn : outputColumns) {
            this.outputColumns.add(ouputColumn);
        }//for
    }//setOutputColumns
    
    public int getStartRow() {
        return startRow;
    }//getStartRow
    
    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }//setStartRow
}//ExcelReadOption