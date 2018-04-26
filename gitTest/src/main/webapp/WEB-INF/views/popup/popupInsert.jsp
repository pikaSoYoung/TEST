<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="/spring/resources/common/js/jquery.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<script src="/spring/resources/common/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/spring/resources/common/design/css/jquery-ui.min.css" type="text/css"/>
<style>
	tr{
		padding:20px;
	}
</style>
<script>

(function(){
	$(document).ready(function(){

		datePickerInit(); //datePicker �ʱ�ȭ
		$("#addImpoartBtn").on("click",imgUpload);
	});//document
	
	var datePickerInit = function(){
		
		$("[data-toggle='datepicker']").datepicker({
			 	dateFormat: 'yy.mm.dd',
			    prevText: '���� ��',
			    nextText: '���� ��',
			    monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
			    monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
			    dayNames: ['��','��','ȭ','��','��','��','��'],
			    dayNamesShort: ['��','��','ȭ','��','��','��','��'],
			    dayNamesMin: ['��','��','ȭ','��','��','��','��'],
			    showMonthAfterYear: true,
			    changeMonth: true,
			    changeYear: true,
			    yearSuffix: '��'
		});//datepicker
	}//datePickerInit

	//���� Ÿ�� üũ
	var checkFileType = function(filePath) {
	
	    var fileFormat = filePath.split(".");
	    
	    if (fileFormat.indexOf("jpg") > -1 || fileFormat.indexOf("png") > -1) {
	        return true;
	    } else {
	        return false;
	    }//if else
	
	}//checkFileType
	
	//���ε� evnet
	var imgUpload = function() {
		
	    var file = $("#imgFile").val();
	    
	    //file ���翩�� if
	    if (file == "" || file == null) {
	        alert("������ �������ּ���.");
	        return false;
	        
	    //img ���� ���� else if    
	    } else if (!checkFileType(file)) {
	    	
	        alert("�̹��� ���ϸ� ���ε� �����մϴ�.");
	        return false;
	    }//if elseif
	    
	    //���� ��¥ check
	    var $dateInp = $("[data-toggle='datepicker']");
	    
	    if($dateInp.eq(0).val()==null || $dateInp.eq(0).val()=="" ||
	    		$dateInp.eq(1).val()==null || $dateInp.eq(1).val()==""){
	    	
	    	return false;	    	
	    }//if
	    
	
	    //���ε� ���� if
	    if (confirm("���ε� �Ͻðڽ��ϱ�?")) {
	    	
	    	paging.ajaxFormSubmit("popupInsert.do","imgUploadForm",function(result){
	    		
	    		if(result==1){
	    			window.location.href = "/spring";
	    		}else{
	    			alert("�ٽ� �õ����ּ���.");
	    		}//if else
	    	});//paging.ajaxFormSubmit
	
	    }//if
	}//check
})();
</script>

</head>
<body style="margin:100px">
	<form id="imgUploadForm" name="imgUploadForm" enctype="multipart/form-data" method="post" 
                                action= "popupInsert.do">   
        <table>
        	
        	<tbody>
        		<tr>
        			<th>�̹�������</th>
        			<td><input id="imgFile" type="file" name="imgFile" /></td>
        		</tr>
        		<tr>
        			<th>���� �Ⱓ</th>
        			<td>
						<input data-toggle="datepicker" type="text"  name="startDate"> ~
						<input data-toggle="datepicker" type="text" name="endDate">
        			</td>
        		</tr>
        	</tbody>
        </table>                        
    	<div class="bottom" style="margin-top:50px">
        	<button type="button" id="addImpoartBtn" class="btn" >
        		<span>Ȯ��</span>
        	</button> 
    	</div>
	</form> 
</body>
</html>