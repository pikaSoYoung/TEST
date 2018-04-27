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
 * datepicker : jquery-ui ���� �ð����� �������� ���� / mobile���� �۵� ���� ���� 
 *
 */
 
(function(){
	$(document).ready(function(){

		datePickerInit(); //datePicker �ʱ�ȭ
		popupList(); //�˾�����Ʈ ���
		
		//�˾� ���ε�
		$("#addImpoartBtn").on("click",imgUpload);
		
		//���� �Ͻ� min max event����
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
			ops.prevText = '���� ��';
			ops.nextText = '���� ��';
			ops.monthNames = ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'];
			ops.dayNames = ['��','��','ȭ','��','��','��','��'];
			ops.dayNamesShort = ['��','��','ȭ','��','��','��','��'];
			ops.dayNamesMin = ['��','��','ȭ','��','��','��','��'];
			ops.minDate = 0;
			ops.showMonthAfterYear = true;
			ops.changeMonth = true;
			ops.changeYear = true;
			ops.yearSuffix = '��';
		
		$("[data-toggle='datepicker']").datepicker(ops);//datepicker option set
		//end date datepicker option set
		datePickerOpSet($("[name='pEndDate']"),"dateFormat","yy-mm-dd 23:59:59"); 
	}//datePickerInit
	
	//datepicker opition ����
	var datePickerOpSet = function(target,name,value){
		target.datepicker("option",name,value);
	}//datePickerOp
	
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
		
	    var file = $("[name='imgFile']").val();	    
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
	    	
	    	var str;
	    	var $dateInp;
	    	
	    	$dateInp = $("[name='pStartDate']");
	    	str = $dateInp.val().replace(/[^0-9]/g,'');
	    	
	    	$dateInp.val(str);
	    	
	    	$dateInp = $("[name='pEndDate']");
	    	str = $dateInp.val().replace(/[^0-9]/g,'');
	    	
	    	$dateInp.val(str);
	    	
	    	//�˾� ��� ajax
	    	paging.ajaxFormSubmit("popupInsert.do","imgUploadForm",function(result){
	    		
	    		if(result==1){
	    			alert("��ϵǾ����ϴ�.");
	    			$("form input[type='text']").val("");
	    			$("[name='popupList']>tbody").children().remove();
	    			popupList();
	    		}else{
	    			alert("�ٽ� �õ����ּ���.");
	    		}//if else
	    	});//paging.ajaxFormSubmit
	
	    }//if
	}//imgUpload
	
	//�˾� ����Ʈ ���
	var popupList = function(){
		
		paging.ajaxSubmit("popupList.do","",function(result){
			var str;
			//�˾� ����Ʈ each
			$.each(result,function(index,value){
				
				str = "<tr><td>"+value.pfileNo+"</td>"+
						  "<td>"+value.pTitle+"</td>"+
						  "<td>"+value.pIdx+"</td>"+
						  "<td>"+value.pStartDate+"</td>"+
						  "<td>"+value.pEndDate+"</td>"+
						  "<td>"+value.pCreateDate+"</td>"+
						  "<td>"+value.pDelYn+"</td></tr>";
				//�˾� ����Ʈ append
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
        			<th>�̹�������</th>
        			<td><input type="file" name="imgFile" /></td>
        		</tr>
        		<tr>
        			<th>�˾� ����</th>
        			<td><input type="text" name="pTitle" /></td>
        		</tr>
        		<tr>
        			<th>��ũ</th>
        			<td><input type="text" name="pUrl" /></td>
        		</tr>
        		<tr>
        			<th>��¼���</th>
        			<td><input type="text" name="pIdx" /></td>
        		</tr>
        		<tr>
        			<th>���� �Ⱓ</th>
        			<td>
						<input data-toggle="datepicker" type="text"  name="pStartDate"> ~
						<input data-toggle="datepicker" type="text" name="pEndDate">
        			</td>
        		</tr>
        	</tbody>
        </table>                        
    	<div class="bottom" style="margin-top:20px">
        	<button type="button" id="addImpoartBtn" class="btn" >
        		<span>Ȯ��</span>
        	</button> 
    	</div>
	</form>
	<H3>�˾� ����Ʈ </H3>
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
				<th>��ȣ</th>
				<th>����</th>
				<th>��¼���</th>
				<th>�����Ͻ�</th>
				<th>�����Ͻ�</th>
				<th>��������</th>
				<th>��������</th>
			</tr>
		</thead>
		<tbody style="background-color:#eee">
		</tbody>
	</table> 
</body>
</html>