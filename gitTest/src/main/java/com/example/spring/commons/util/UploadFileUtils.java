package com.example.spring.commons.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadFileUtils {

    private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

    // 파일 업로드 처리
    public static HashMap<String,String> uploadFile(MultipartFile file, HttpServletRequest request) throws Exception {

        String originalFileName = file.getOriginalFilename(); // 파일명
        byte[] fileData = file.getBytes();  // 파일 데이터

        // 1. 파일명 중복 방지 처리
        String uuidFileName = getUuidFileName(originalFileName);

        // 2. 파일 업로드 경로 설정
        String rootPath = getRootPath(originalFileName, request); // 기본경로 추출(이미지 or 일반파일)

        // 3. 서버에 파일 저장
        File target = new File(rootPath , uuidFileName); // 파일 객체 생성
        
        int count = 1;
        
        while(target.exists()) {
        	uuidFileName +=  "_"+count;
        	count++;
        	target = new File(rootPath, uuidFileName);
        }//while
       
        FileCopyUtils.copy(fileData, target); // 파일 객체에 파일 데이터 복사
        
        HashMap<String,String> map = new HashMap<String,String>();
        
        map.put("sysNm", uuidFileName);
        map.put("orgNm", originalFileName);

        return map;
    }//uploadFile

    // 파일 삭제 처리
    public static void deleteFile(String fileName, HttpServletRequest request) {

        String rootPath = getRootPath(fileName, request); // 기본경로 추출(이미지 or 일반파일)
        
        // 파일 삭제(썸네일이미지 or 일반파일)
        new File(rootPath +"/"+ fileName).delete();
          
    }//deleteFile

    // 파일 출력을 위한 HttpHeader 설정
    public static HttpHeaders getHttpHeaders(String fileName) throws Exception {

        HttpHeaders httpHeaders = new HttpHeaders();

        fileName = fileName.substring(fileName.indexOf("_") + 1); // UUID 제거
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM); // 다운로드 MIME 타입 설정
        // 파일명 한글 인코딩처리
        httpHeaders.add("Content-Disposition",
                        "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"),
                                "ISO-8859-1")+"\"");

        return httpHeaders;
    }//getHttpHeaders

    // 기본 경로 추출
    public static String getRootPath(String fileName, HttpServletRequest request) {

        String rootPath = "/upload";
        return "C:\\temp1"+rootPath + "/files"; // 일반파일 경로
        
    }//getRootPath

    // 파일명 중복방지 처리
    private static String getUuidFileName(String originalFileName) {
  
    	String uuidFileName =UUID.randomUUID().toString()+originalFileName.substring(originalFileName.lastIndexOf("."));
        return uuidFileName;
        
    }//getUuidFileName
}//uploadFile