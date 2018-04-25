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
		$("[name='submitBtn']").on("click",insertClick);
	});//event
	
	//게시글 등록
	var insertClick = function(){	
		
		if(confirm("전송하시겠습니까?")){
			
			paging.ajaxFormSubmit("reBoardInsert.do","writeForm",function(result){
				if(result==1){
					alert("정상등록되었습니다.");
					window.location.href = "reBoardMain.do" 
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
    	<form class="form" method="post" name="writeForm" id="writeForm" enctype="multipart/form-data">
    		<input type="hidden" name="cmd" value="insertData">
      		<div class="input_wrapper">
        		<div class="title_wrap">
          			<label for="title">제목</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="title" class="input_title" name="boardTitle" value="${requestScope.boardMap.boardTitle}">
        		</div>
      		</div>
      		<div class="input_wrapper">
        		<div class="title_wrap">
            		<label for="name">작성자</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="name" name="boardWriter" value="${requestScope.boardMap.boardWriter}">
        		</div>
      		</div>
      		<div class="cont_wrapper">
        		<div class="title_wrap">
          		<label for="content">내용</lable>
        	</div>
        	<textarea name="boardContent" rows="10" cols="100" placeholder="내용입력" title="내용입력" id="content">${requestScope.boardMap.boardContent}</textarea>
      		</div>
      		<div class="submit_wrapper">
      			<input type="button" name="submitBtn" class="unrole_btn" value="확인">		
      		</div>	
    	</form>
  </div>
</body>
</html>