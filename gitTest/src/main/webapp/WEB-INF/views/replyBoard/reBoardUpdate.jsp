<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel='stylesheet' href='/spring/resources/common/design/css/style.css' type='text/css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<title>Insert title here</title>

<script>
(function(){
	
	var $formObj; //수정 폼 객체
	
	//문서 시작
	$(document).ready(function() {
		events()//이벤트 등록
	});//$(document).ready
	
	var init = function(){		
		
		$formObj = $("#updateForm");
	}//init
	
	//이벤트
	var events = function(){
		$("[name='submitBtn']").on("click", insertClick); //수정 
		$("input[name='escBtn']").on("click",prevPage); //되돌아가기
	}//event

	//게시글 수정
	function insertClick() {
		//전송 여부 if
		if (confirm("전송하시겠습니까?")) {		
			paging.ajaxFormSubmit("reBoardUpdate.do","updateForm",function(result){		
				
				if(result.result==1){				
					alert("수정되었습니다.");
					//이번 페이지로 이동
					prevPage();
					
				}else{
					alert("다시 시도해주세요.");			
				}//if else
			});//paging.ajaxFormSubmit
			
		}//if
	}//insertClcik()	
	
	//이전 페이지로 이동
	var prevPage = function(){
		$formObj.ajaxFormUnbind();
		$formObj.submit();
	}//prevPage
})();
</script>
</head>
<body>
	<div class="wrap">
    	<form method="post" id="updateForm" action="reBoardDetail.do">
    		<input type="hidden" name="boardNo" value="${paramMap.boardNo}">
    		<input type="hidden" name="searchCnd" value="${paramMap.searchCnd}">
        	<input type="hidden" name="searchWd" value="${paramMap.searchWd}">
    		<input type="hidden" name="choicePage" value="${paramMap.choicePage}">
      		<div class="input_wrapper">
        		<div class="title_wrap">
          			<label for="title">제목</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="title" class="input_title" name="boardTitle" value="${boardMap.boardTitle}">
        		</div>
      		</div>
      		<div class="input_wrapper">
        		<div class="title_wrap">
            		<label for="name">작성자</lable>
        		</div>
        		<div class="input_wrap">
          			<input type="text" id="name" name="boardWriter" value="${boardMap.boardWriter}">
        		</div>
      		</div>
      		<div class="cont_wrapper">
        		<div class="title_wrap">
          		<label for="content">내용</lable>
        	</div>
        		<textarea name="boardContent" rows="10" cols="100" placeholder="내용입력" title="내용입력" id="content">${boardMap.boardContent}</textarea>
      		</div>
      		<div class="submit_wrapper">
	      		<input type="button" name="submitBtn" class="unrole_btn" value="수정">
	      		<input type="button" name="escBtn" class="unrole_btn" value="취소">		
	      	</div>	
    		</form>
      	</div>
      		
  </div>
</body>
</html>