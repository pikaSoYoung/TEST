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
		$("#addInput").on("click", addFileInp); //파일등록 input생성
		$("#deleteInput").on("click", deleteInp); //파일등록 input 삭제 
		$("[name='submitBtn']").on("click", insertClick); //수정 
		$("button[name='deleteFileBtn']").on("click",deleteFile); //파일 삭제
		$("input[name='escBtn']").on("click",prevPage); //되돌아가기
	}//event
	
	//input 추가 
	var addFileInp = function() {
		var count = $(".file_wrap").length + 1; //input file 개수	
		
		$("<div class='file_wrap' name='fileWrap'></div>").insertBefore(
				$(".submit_wrapper"));		//파일 div 생성
		
		$("<input type='checkbox' name='chkbox'>").appendTo(
				$(".file_wrap:last"));	// 체크박스 생성
				
		$("<input type='file'>").insertAfter($("input:checkbox:last")); //파일 input 생성
		//파일 input name 값 부여
		$("input:file:last").attr("name", "fileName" + count);
	}//addFileInp()	
	
	//file input 삭제
	function deleteInp() {
		//파일 div 삭제
		$("input:checked").parent(".file_wrap").remove(); 
	}//deleteInp()
	
	//file 삭제
	var deleteFile = function(){
		
		var $thisObj = $(this);
		//파일 삭제 여부 if
		if(!confirm("파일을 삭제하시겠습니까?")){return false;}
	
		var data = {};
		data.fileId = $thisObj.prev("a").attr("id"); //파일
		
		paging.ajaxSubmit("fileDelete.do",data,function(result){
			
			if(result==1){
				alert("삭제되었습니다.");
				$thisObj.parent(".file_wrap").remove();
			}else{
				alert("파일이 정상적으로 삭제되지 않았습니다.");
			}//if else
			
		},true);//paging.ajaxSubmit	
		
	}//deleteFile
	
	//게시글 수정
	function insertClick() {
		//전송 여부 if
		if (confirm("전송하시겠습니까?")) {		
			paging.ajaxFormSubmit("boardUpdate.do","updateForm",function(result){		
				
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
    	<form method="post" id="updateForm" action="boardDetail.do" enctype="multipart/form-data">
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
      		<div class="inpute_wrapper">
      			<div class="title_wrap">
      				<label for="file">파일</label>
      			</div>	
      			<div class="input_wrap">
      				<button type="button" id="addInput" class="unrole_btn">추가</button>
      				<button type="button" id="deleteInput" class="unrole_btn">삭제</button>
      			</div>
      		
   				<c:forEach var="n" items="${boardMap.fileList}">
      				<div class="file_wrap" name="fileWrap">
      					<!-- <input type="checkbox" name="chkbox"> -->
      					<a href="fileDownload.do?sysName=${n.sysNm}&orgName=${n.orgNm}" id="${n.sysNm}^${n.fileNo}" name="fileDownBtn">${n.orgNm}</a>
      					<button type="button" name="deleteFileBtn">X</button>
      				</div> 
      			</c:forEach>

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