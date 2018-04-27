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

/*
 * datepicker : jquery-ui 에서 시간까지 지원하지 않음 / mobile에서 작동 가능 여부 
 *
 */
 
(function(){
	$(document).ready(function(){

		datePickerInit(); //datePicker 초기화
		popupList(); //팝업리스트 출력
		
		//팝업 업로드
		$("#addImpoartBtn").on("click",imgUpload);
		
		//적용 일시 min max event설정
		$("[name='pStartDate']").datepicker("option","onClose",function(selectedDate){
			datePickerOpSet($("[name='pEndDate']"),"minDate",new Date(selectedDate.substring(0,10)));
		});//onclick
		
		$("[name='pEndDate']").datepicker("option","onClose",function(selectedDate){
			datePickerOpSet($("[name='pStartDate']"),"maxDate",new Date(selectedDate.substring(0,10)));
		});//onclick
	});//document
	
	//datePicker 
	var datePickerInit = function(){

		//default options
		var ops = {};
			ops.dateFormat = 'yy-mm-dd 00:00:00';
			ops.prevText = '이전 달';
			ops.nextText = '다음 달';
			ops.monthNames = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
			ops.dayNames = ['일','월','화','수','목','금','토'];
			ops.dayNamesShort = ['일','월','화','수','목','금','토'];
			ops.dayNamesMin = ['일','월','화','수','목','금','토'];
			ops.minDate = 0;
			ops.showMonthAfterYear = true;
			ops.changeMonth = true;
			ops.changeYear = true;
			ops.yearSuffix = '년';
		
		$("[data-toggle='datepicker']").datepicker(ops);//datepicker option set
		//end date datepicker option set
		datePickerOpSet($("[name='pEndDate']"),"dateFormat","yy-mm-dd 23:59:59"); 
	}//datePickerInit
	
	//datepicker opition 변경
	var datePickerOpSet = function(target,name,value){
		target.datepicker("option",name,value);
	}//datePickerOp
	
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
		
	    var file = $("[name='imgFile']").val();	    
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
	    	
	    	var str;
	    	var $dateInp;
	    	
	    	$dateInp = $("[name='pStartDate']");
	    	str = $dateInp.val().replace(/[^0-9]/g,'');
	    	
	    	$dateInp.val(str);
	    	
	    	$dateInp = $("[name='pEndDate']");
	    	str = $dateInp.val().replace(/[^0-9]/g,'');
	    	
	    	$dateInp.val(str);
	    	
	    	//팝업 등록 ajax
	    	paging.ajaxFormSubmit("popupInsert.do","imgUploadForm",function(result){
	    		
	    		if(result==1){
	    			alert("등록되었습니다.");
	    			$("form input").val("");
	    			$("[name='popupList']>tbody").children().remove();
	    			popupList();
	    		}else{
	    			alert("다시 시도해주세요.");
	    		}//if else
	    	});//paging.ajaxFormSubmit
	
	    }//if
	}//imgUpload
	
	//팝업 리스트 출력
	var popupList = function(){
		
		paging.ajaxSubmit("popupList.do","",function(result){
			var str;
			//팝업 리스트 each
			$.each(result,function(index,value){
				
				str = "<tr><td>"+value.pfileNo+"</td>"+
						  "<td>"+value.pTitle+"</td>"+
						  "<td>"+value.pIdx+"</td>"+
						  "<td>"+value.pStartDate+"</td>"+
						  "<td>"+value.pEndDate+"</td>"+
						  "<td>"+value.pCreateDate+"</td>"+
						  "<td>"+value.pDelYn+"</td></tr>";
				//팝업 리스트 append
				$("[name='popupList']>tbody").append(str);				  
			});//each	
		},true);//paging.ajaxSubmit
	}//popupList
})();
</script>

</head>
<body style="margin:100px">
	<form id="imgUploadForm" name="imgUploadForm" enctype="multipart/form-data" method="post" 
                                action= "popupInsert.do"  style="margin-bottom:50px">   
        <table>
        	
        	<tbody>
        		<tr>
        			<th>이미지파일</th>
        			<td><input type="file" name="imgFile" /></td>
        		</tr>
        		<tr>
        			<th>팝업 제목</th>
        			<td><input type="text" name="pTitle" /></td>
        		</tr>
        		<tr>
        			<th>링크</th>
        			<td><input type="text" name="pUrl" /></td>
        		</tr>
        		<tr>
        			<th>출력순서</th>
        			<td><input type="text" name="pIdx" /></td>
        		</tr>
        		<tr>
        			<th>적용 기간</th>
        			<td>
						<input data-toggle="datepicker" type="text"  name="pStartDate"> ~
						<input data-toggle="datepicker" type="text" name="pEndDate">
        			</td>
        		</tr>
        	</tbody>
        </table>                        
    	<div class="bottom" style="margin-top:20px">
        	<button type="button" id="addImpoartBtn" class="btn" >
        		<span>확인</span>
        	</button> 
    	</div>
	</form>
	<H3>팝업 리스트 </H3>
	<table name="popupList" style=" width:1024px; margin-top:10px; border:1px solid gray; text-align:center">
		<colgroup>
                <col style="width:10%">
                <col style="width:15%">
                <col style="width:10%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:15%">
                <col style="width:10%">
        </colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>출력순서</th>
				<th>시작일시</th>
				<th>종료일시</th>
				<th>생성일자</th>
				<th>삭제여부</th>
			</tr>
		</thead>
		<tbody style="background-color:#eee">
		</tbody>
	</table> 
</body>
</html>