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

		datePickerInit(); //datePicker 초기화
		$("#addImpoartBtn").on("click",imgUpload);
	});//document
	
	var datePickerInit = function(){
		
		$("[data-toggle='datepicker']").datepicker({
			 	dateFormat: 'yy.mm.dd',
			    prevText: '이전 달',
			    nextText: '다음 달',
			    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    dayNames: ['일','월','화','수','목','금','토'],
			    dayNamesShort: ['일','월','화','수','목','금','토'],
			    dayNamesMin: ['일','월','화','수','목','금','토'],
			    showMonthAfterYear: true,
			    changeMonth: true,
			    changeYear: true,
			    yearSuffix: '년'
		});//datepicker
	}//datePickerInit

	//파일 타입 체크
	var checkFileType = function(filePath) {
	
	    var fileFormat = filePath.split(".");
	    
	    if (fileFormat.indexOf("jpg") > -1 || fileFormat.indexOf("png") > -1) {
	        return true;
	    } else {
	        return false;
	    }//if else
	
	}//checkFileType
	
	//업로드 evnet
	var imgUpload = function() {
		
	    var file = $("#imgFile").val();
	    
	    //file 존재여부 if
	    if (file == "" || file == null) {
	        alert("파일을 선택해주세요.");
	        return false;
	        
	    //img 파일 여부 else if    
	    } else if (!checkFileType(file)) {
	    	
	        alert("이미지 파일만 업로드 가능합니다.");
	        return false;
	    }//if elseif
	    
	    //적용 날짜 check
	    var $dateInp = $("[data-toggle='datepicker']");
	    
	    if($dateInp.eq(0).val()==null || $dateInp.eq(0).val()=="" ||
	    		$dateInp.eq(1).val()==null || $dateInp.eq(1).val()==""){
	    	
	    	return false;	    	
	    }//if
	    
	
	    //업로드 여부 if
	    if (confirm("업로드 하시겠습니까?")) {
	    	
	    	paging.ajaxFormSubmit("popupInsert.do","imgUploadForm",function(result){
	    		
	    		if(result==1){
	    			window.location.href = "/spring";
	    		}else{
	    			alert("다시 시도해주세요.");
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
        			<th>이미지파일</th>
        			<td><input id="imgFile" type="file" name="imgFile" /></td>
        		</tr>
        		<tr>
        			<th>적용 기간</th>
        			<td>
						<input data-toggle="datepicker" type="text"  name="startDate"> ~
						<input data-toggle="datepicker" type="text" name="endDate">
        			</td>
        		</tr>
        	</tbody>
        </table>                        
    	<div class="bottom" style="margin-top:50px">
        	<button type="button" id="addImpoartBtn" class="btn" >
        		<span>확인</span>
        	</button> 
    	</div>
	</form> 
</body>
</html>