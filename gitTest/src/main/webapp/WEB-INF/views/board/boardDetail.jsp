<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
 <% 
 	pageContext.setAttribute("br","<br/>");
 	pageContext.setAttribute("cn","\n");
 
  %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel='stylesheet' href='/spring/resources/common/design/css/style.css' type='text/css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<script>
(function(){
	var formObj; //폼 저장 변수
	
	$(document).ready(function(){
		formObj = $("[name='hiddenForm']");		
		events(); //이벤트 등록
		
	});//$(document).ready
	
	//이벤트 
	var events = function(){
		$("a[name='list']").on("click",submitClick); //목록 event
		$("a[name='updateForm']").on("click",updateFrom); //수정 evet
		$("a[name='delete']").on("click",boardDelete); //삭제 event
	}//event
	
	//폼전송
	var submitClick = function(){
		formObj.submit();
	}//submitClick
	
	//수정 페이지로 이동
	var updateFrom = function(){
		formObj.attr("action","boardUpdateForm.do");
		submitClick();
	}//updateFrom
	
	//게시물 삭제
	var boardDelete = function (){
		
		//저장된 첨부파일 수 
		var files = $("a[name='fileDownBtn']");
		
		//게시물에 첨부파일이 존재 한다면 폼에 파일 저장
		if(files.length>0){
			if(confirm("게시물 삭제시 첨부파일도 삭제됩니다.")){
				
				files.each(function(index){
					formObj.append("<input type='hidden' name='files' value='"+$(this).attr('id')+"'>");
				});//each			
			}//if
		}else{
			formObj.append("<input type='hidden' name='files' value=''>");
		}//if else
		
		//ajax form 전송
		paging.ajaxFormSubmit("boardDelete.do","hiddenForm",function(result){
	
			if(result.result==1){
				 alert("삭제되었습니다.");
				 formObj.ajaxFormUnbind();
				 submitClick();
			}else{
				alert("다시 시도해주세요.");
			}//if else
		});//paging.ajaxFormSubmit
	}//boardDelete
})();
</script>
</head>
<body>
	<form name="hiddenForm" method="post" action="boardMain.do" id="hiddenForm">
		<input type="hidden" name="searchCnd" value="${paramMap.searchCnd}">
        <input type="hidden" name="searchWd" value="${paramMap.searchWd}">
		<input type="hidden" name="boardNo" value="${paramMap.boardNo}">
		<input type="hidden" name="choicePage" value="${paramMap.choicePage}">
	</form>
	<div class="wrap">
    	<div class="board_view">
        	<ul>
          	<li>
            	<span class="post_title">제목</span>
            	<span>${boardMap.boardTitle}</span>
          	</li>
          	<li>
            	<span class="post_title">작성자</span>
            	<span>${boardMap.boardWriter}</span>
          	</li>
          	<li>
            	<span class="post_title">작성일</span>
            	<span>${boardMap.createDate}</span>
          	</li>
        	</ul>
    	</div>
    	<div class="board_content">
        	${fn:replace(boardMap.boardContent,cn,br)}  	
    	</div>
    	<div class="file_wrap" name="fileWrap">
    		<span class="post_title">첨부파일</span>
    		<c:forEach var="n" items="${boardMap.fileList}" varStatus="status">
    			<a href="fileDownload.do?sysName=${n.sysNm}&orgName=${n.orgNm}" id="${n.sysNm}^${n.fileNo}" name="fileDownBtn"><c:out value="${n.orgNm}"></c:out></a>
    		</c:forEach>
    	</div>
    	<div class="unrole">
    		<a href="#" name="updateForm" title="수정" class="unrole_btn"><span>수정</span></a>
        	<a href="#" name="delete" title="삭제" class="unrole_btn"><span>삭제</span></a>
        	<a href="#" name="list" title="목록" class="unrole_btn"><span>목록</span></a>
    	</div>
	</div>
</body>
</html>