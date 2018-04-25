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

	var $formObj; //폼 저장 변수
	var $replyWrap; //div 저장 변수
	
	$(document).ready(function(){
		
		init() //변수 초기화
		events(); //이벤트 등록	
	});//$(document).ready
	
	//변수 초기화
	var init = function(){
		
		$formObj = $("[name='hiddenForm']");	
		$replyWrap = $("div[name='replyWrap']");
	}//init
	
	//이벤트 
	var events = function(){
		
		//목록 event
		$("a[name='list']").on("click",submitClick); 
		 //수정 evet
		$("a[name='updateForm']").on("click",updateFrom); 
		//삭제 event
		$("a[name='delete']").on("click",boardDelete); 
		//댓글 수정 form evnet
		$replyWrap.on("click","a[name='replyUpdateForm']",replyUpdateForm);
		//댓글 수정 event
		$replyWrap.on("click","a[name='replyUpdate']",replyUpdate);
		//댓글 삭제 event
		$replyWrap.on("click","a[name='replyDelete']",replyDelete);
		//댓글 수정 취소 event
		$replyWrap.on("click","a[name='esc']",refresh);
		//댓글 등록 이벤트
		$("a[name='replyInsertBtn']").on("click",replyInsert);
	}//event

	//폼전송
	var submitClick = function(){
		$formObj.submit();
	}//submitClick
	
	//수정 페이지로 이동
	var updateFrom = function(){
		$formObj.attr("action","reBoardUpdateForm.do");
		submitClick();
	}//updateFrom

	//게시물 삭제
	var boardDelete = function (){
		
		var replyLength; //댓글 개수
		
		var data = {};
		data.boardNo = $("#replyForm").children("input[type='hidden']").val(); //게시물 번호 저장
		
		paging.ajaxSubmit("replyLength.do",data,function(result){
			
			//해당 게시글의 댓글 개수
			replyLength = result;
			
		},false); //paging.ajaxSubmit
	
		//댓글이 존재하지 않을 시 삭제 if
		if(replyLength<=0){
			
			//ajax form 전송
			paging.ajaxFormSubmit("reBoardDelete.do","hiddenForm",function(result){
				
				if(result==1){
					 alert("삭제되었습니다.");
					 $formObj.ajaxFormUnbind();
					 //메인페이지로 이동
					 submitClick(); 
				}else{
					 alert("다시 시도해주세요.");
				}//if else
			});//paging.ajaxFormSubmit	
		}else{
			
			alert("해당 게시글에 댓글이 존재하여 삭제하실 수 없습니다.");
		}//if else		
	}//boardDelete
	
	//리플 등록
	var replyInsert = function(){
		
		paging.ajaxFormSubmit('replyInsert.do',"replyForm",function(result){
			//정상 등록 여부 if
			if(result.result==1){
				alert("등록되었습니다.");
				
				//현재페이지로 이동
				refresh();
			}else{
				console.log(result)
				 alert("다시 시도해주세요.");
			}//if else
		});//paging.ajaxFormSubmit
		
	}//replyInsert
	
	var replyUpdateForm = function(){
		
		var $thisObj = $(this); //수정버튼
		var $thisPrntDiv = $thisObj.parent("div"); //수정버튼을 감싸는 div
		var $thisPrntLi = $thisObj.parents("li"); //해당 수정 버튼의 li
		
		//댓글 작성자
		var replyer = $thisPrntDiv.siblings(".post_title").text();
		//댓글 내용
		var replyContent = $thisPrntDiv.siblings("span").eq(1).text();
		
		//댓글 수정 input textarea 생성
		$thisPrntLi.prepend("<input type='text' name='replyer' value='"+replyer+"'/>"+
									"<textarea style='height:auto' type='text' name='replyContent'>"+replyContent+"</textarea>");
		
		//댓글 span 객체 삭제
		$thisPrntLi.children("span").remove();
		
		//취소 확인 버튼 생성
		$thisPrntDiv.prepend("<a href='#' name='esc' title='취소' class='unrole_btn'><span>취소</span></a>");
		$thisPrntDiv.prepend("<a href='#' name='replyUpdate' title='확인' class='unrole_btn'><span>확인</span></a>");
		
		//수정 삭제 버튼 display none
		$thisObj.next("a").css("display","none");
		$thisObj.css("display","none");
		
	}//replyUpdateFrom
	
	var replyUpdate = function(){
		
		var $thisObj = $(this);
		
		var data = {};
			data.replyNo = $(this).parents("li").attr('id');
			data.replyer = $(this).parents("li").children("[name='replyer']").val();
			data.replyContent = $(this).parents("li").children("[name='replyContent']").val();
		
		console.log(data);
		
		paging.ajaxSubmit("replyUpdate.do",data,function(result){
			if(result==1){
				alert("적용되었습니다.");
				
				//현재페이지로 이동
				refresh();
			}else{
				alert("다시 시도해주세요.")
			}
		},true);//paging.ajaxSubmit
	}//replyUpdate
	
	var replyUpdateEsc = function(){
		$formObj.attr("action","reBoardDetail.do");
		$formObj.submit();
	}//replyUpdateEsc
	
	var replyDelete = function(){
		
		var data = {};
		data.replyNo = $(this).parents("li").attr("id");
		
		paging.ajaxSubmit("replyDelete.do",data,function(result){
			if(result==1){
				alert("삭제되었습니다.");
				//현재페이지로 이동
				refresh();
			}else{
				alert("다시시도해주세요");
			}//if else
		},true);//paging.ajaxSubmit
		
	}//replyDelete
	
	//현재페이지로 이동
	var refresh = function(){
		$formObj.attr("action","reBoardDetail.do");
		submitClick();
	}//refresh
})();		
</script>
</head>
<body>
	<form name="hiddenForm" method="post" action="reBoardMain.do" id="hiddenForm">
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
            	<span>${reBoardMap.boardTitle}</span>
          	</li>
          	<li>
            	<span class="post_title">작성자</span>
            	<span>${reBoardMap.boardWriter}</span>
          	</li>
          	<li>
            	<span class="post_title">작성일</span>
            	<span>${reBoardMap.createDate}</span>
          	</li>
        	</ul>
    	</div>
    	<div class="board_content">
    		${fn:replace(reBoardMap.boardContent,cn,br)}  
    	</div>
    	<div class="unrole">
    		<a href="#" name="updateForm" title="수정" class="unrole_btn"><span>수정</span></a>
        	<a href="#" name="delete" title="삭제" class="unrole_btn"><span>삭제</span></a>
        	<a href="#" name="list" title="목록" class="unrole_btn"><span>목록</span></a>
    	</div>
	</div>
	<div class="wrap" style="margin-top:10px;">
    	<h3>댓글</h3>
    		<div class="reply_wrap" >
    			<div class="board_view" name="replyWrap">
    				<ul>
    					<c:forEach var="n" items="${reBoardMap.replyList}" varStatus="status">
    					<li style="width:100%" id = "${n.replyNo}">
            				<span class="post_title" style="width:10%">${n.replyer}</span>
            				<span>${n.replyContent}</span>
            				<div class="unrole" name="replyBtnWrap">
            				 	<a href="#" name="replyUpdateForm" title="수정" class="unrole_btn"><span>수정</span></a>
        						<a href="#" name="replyDelete" title="삭제" class="unrole_btn"><span>삭제</span></a>
        					</div>	
          				</li>
          				</c:forEach>        				
    				</ul>
    			</div>	
    		</div>	
    	</div>
    	<div class="wrap" style="margin-top:10px;">	
    		<h3>댓글 작성</h3>	
    		<form action="replyInsert.do" id="replyForm">
    			<div class="reply_wrap" name="replyFromWrap">
    				<div class="input_wrapper">
        				<div class="title_wrap">
            				<label for="name">작성자</lable>
        				</div>
        				<div class="input_wrap">
          					<input type="text" id="name" name="replyer" value="">
        				</div>
      				</div>
      				<div class="cont_wrapper">
        				<div class="title_wrap">
          					<label for="content">내용</lable>
        				</div>
        				<textarea name="replyContent" rows="5" cols="100" placeholder="내용입력" title="내용입력" id="content" style="height:auto"></textarea>
    				</div>
    				<div class="unrole">
    					<a href="#" name="replyInsertBtn" title="확인" class="unrole_btn"><span>등록</span></a>
    				</div>
    			</div>
    			<input type="hidden" value="${reBoardMap.boardNo}" name="boardNo">
    		</form>	
    	</div>
    	
</body>
</html>