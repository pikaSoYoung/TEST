<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel='stylesheet' href='/spring/resources/common/design/css/style.css' type='text/css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<title>Insert title here</title>
<script>	
(function(){
	
	//문서 시작 
	$(document).ready(function(){
		events();//이벤트 등록
	});//document
	
	//이벤트 
	var events = function(){
		$("#addInput").on("click",addFileInp);
		$("#deleteInput").on("click",deleteInp);
		$("[name='submitBtn']").on("click",insertClick);
	}//events
	
	//input 추가 
	var addFileInp =  function(){
		
		var count = $(".file_wrap").length+1; //input file name cont	
		//div 생성
        $("<div class='file_wrap' name='fileWrap'></div>").insertBefore($(".submit_wrapper"));
		//체크박스 생성
        $("<input type='checkbox' name='chkbox'>").appendTo($(".file_wrap:last"));
		//파일 input 생성
        $("<input type='file'>").insertAfter($("input:checkbox:last"));
		//input name 부여
        $("input:file:last").attr("name","fileName"+count);
	}//addFileInp()	
	
	//삭제
	var deleteInp = function(){
		$("input:checked").parent(".file_wrap").remove();
	}//deleteInp()
	
	var insertClick = function(){	
		
		if(confirm("전송하시겠습니까?")){
			
			//정상적인 파일을 선택했는지 여부 if
			if($("input:checkbox").length && !$("input:checkbox:checked").next("input:file").val()){
				alert("선택한 파일이 존재하지 않습니다.");
				return false;
			}//if
			
			//체크되지 않은 input 삭제
			$("input:checkbox:not(:checked)").parent(".file_wrap").remove();
			
			//등록 ajax
			paging.ajaxFormSubmit("boardInsert.do","writeForm",function(result){
				if(result==1){
					alert("정상등록되었습니다.");
					//메인 페이지로 이동
					window.location.href = "boardMain.do" 
				}else{
					alert("실패하였습니다.");
				}//if else
			});//paging.ajaxFormSubmit
		}//if	
	}//inserClick
})();
</script>
</head>
<body>
	<div class="wrap">
    	<form class="form" method="post" name="writeForm" id="writeForm" enctype="multipart/form-data" accept-charset="UTF-8">
      		<div class="input_wrapper">
        		<div class="title_wrap">
          			<label for="title">제목</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="title" class="input_title" name="boardTitle" >
        		</div>
      		</div>
      		<div class="input_wrapper">
        		<div class="title_wrap">
            		<label for="name">작성자</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="name" name="boardWriter" >
        		</div>
      		</div>
      		<div class="cont_wrapper">
        		<div class="title_wrap">
          		<label for="content">내용</lable>
        	</div>
        	<textarea name="boardContent" rows="10" cols="100" placeholder="내용입력" title="내용입력" id="content"></textarea>
      		</div>
      		<div class="inpute_wrapper">
      			<div class="title_wrap">
      				<label for="file">파일</label>
      			</div>
      			<div class="input_wrap">
      				<button type="button" id="addInput" class="unrole_btn">추가</button>
      				<button type="button" id="deleteInput" class="unrole_btn">삭제</button>
      			</div>
      		</div>
      		<div class="submit_wrapper">
      			<input type="button" name="submitBtn" class="unrole_btn" value="확인">		
      		</div>	
    	</form>
  </div>
</body>
</html>