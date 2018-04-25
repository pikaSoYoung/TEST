package com.example.spring.commons.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellReference;
 
public class ExcelCellRef {
    /**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }else {
            cellNum = cellIndex;
        }//if else
        
        return CellReference.convertNumToColString(cellNum);
    }//getName
    
    public static String getValue(Cell cell) {
        String value = "";
        
        if(cell == null) {
            value = "";
        }else {
        	
        	switch(cell.getCellTypeEnum()) {
        		case FORMULA : 
        			value = cell.getCellFormula();
        			break;
        		case NUMERIC :
        			value = cell.getNumericCellValue() + "";
        			break;
        		case STRING :
        			value = cell.getStringCellValue();
        			break;
        		case BOOLEAN :
        			value = cell.getBooleanCellValue() + "";
        			break;
        		case ERROR : 
        			value = cell.getErrorCellValue() + "";
        			break;
        		case BLANK :
        			value = "";
        			break;
        		
        		default : 
        			value = cell.getStringCellValue();	
        	}//switch
        }//if else
        
        return value;
    }//getValue
 
}
