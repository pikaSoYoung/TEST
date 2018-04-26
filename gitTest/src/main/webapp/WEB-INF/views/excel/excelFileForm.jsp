<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>

<script>

(function(){
	
	$(document).ready(function(){
		$("#addExcelImpoartBtn").on("click",excelUpload);
	});//document

	//파일 타입 체크
	var checkFileType = function(filePath) {
		
	    var fileFormat = filePath.split(".");
	    if (fileFormat.indexOf("xlsx") > -1) {
	        return true;
	    } else {
	        return false;
	    }//if else
	
	}//checkFileType
	
	//엑셀 업로드 evnet
	var excelUpload = function() {
		
	    var file = $("#excelFile").val();
	    //file 존재여부 if
	    if (file == "" || file == null) {
	        alert("파일을 선택해주세요.");
	        return false;
	        
	    //엑셀 파일 여부 else if    
	    } else if (!checkFileType(file)) {
	        alert("엑셀 파일만 업로드 가능합니다.");
	        return false;
	    }//if elseif
	
	    //업로드 여부 if
	    if (confirm("업로드 하시겠습니까?")) {
	    	
	    	var options = {};
	    	options.success =  function(data){ alert("모든 데이터가 업로드 되었습니다."); };
	    	options.type = "POST";
	    	
	        //엑셀 업로드 전송
	        $("#excelUploadForm").ajaxSubmit(options);
	
	    }//if
	}//check
})();

/*excel 참고 출처 http://daydreamer-92.tistory.com/42 */
</script>
</head>
<body>
	<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" 
                                action= "excelUploadAjax.do">
    	<div class="contents">
        	<div>첨부파일은 한개만 등록 가능합니다.</div>
 
        	<dl class="vm_name">
                	<dt class="down w90">첨부 파일</dt>
                	<dd><input id="excelFile" type="file" name="excelFile" /></dd>
        	</dl>        
   		</div>
            
    	<div class="bottom">
        	<button type="button" id="addExcelImpoartBtn" class="btn" ><span>추가</span></button> 
    	</div>
	</form> 
</body>
</html>