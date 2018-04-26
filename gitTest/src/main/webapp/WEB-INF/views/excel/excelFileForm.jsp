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

	//���� Ÿ�� üũ
	var checkFileType = function(filePath) {
		
	    var fileFormat = filePath.split(".");
	    if (fileFormat.indexOf("xlsx") > -1) {
	        return true;
	    } else {
	        return false;
	    }//if else
	
	}//checkFileType
	
	//���� ���ε� evnet
	var excelUpload = function() {
		
	    var file = $("#excelFile").val();
	    //file ���翩�� if
	    if (file == "" || file == null) {
	        alert("������ �������ּ���.");
	        return false;
	        
	    //���� ���� ���� else if    
	    } else if (!checkFileType(file)) {
	        alert("���� ���ϸ� ���ε� �����մϴ�.");
	        return false;
	    }//if elseif
	
	    //���ε� ���� if
	    if (confirm("���ε� �Ͻðڽ��ϱ�?")) {
	    	
	    	var options = {};
	    	options.success =  function(data){ alert("��� �����Ͱ� ���ε� �Ǿ����ϴ�."); };
	    	options.type = "POST";
	    	
	        //���� ���ε� ����
	        $("#excelUploadForm").ajaxSubmit(options);
	
	    }//if
	}//check
})();

/*excel ���� ��ó http://daydreamer-92.tistory.com/42 */
</script>
</head>
<body>
	<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" 
                                action= "excelUploadAjax.do">
    	<div class="contents">
        	<div>÷�������� �Ѱ��� ��� �����մϴ�.</div>
 
        	<dl class="vm_name">
                	<dt class="down w90">÷�� ����</dt>
                	<dd><input id="excelFile" type="file" name="excelFile" /></dd>
        	</dl>        
   		</div>
            
    	<div class="bottom">
        	<button type="button" id="addExcelImpoartBtn" class="btn" ><span>�߰�</span></button> 
    	</div>
	</form> 
</body>
</html>