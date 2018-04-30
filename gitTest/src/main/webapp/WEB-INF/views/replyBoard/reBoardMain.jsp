<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel='stylesheet' href='/spring/resources/common/design/css/style.css' type='text/css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<script src="/spring/resources/common/js/pagingNav.js"></script>
<title>board main</title>
<script>
(function(){
	
	var searching =false; //검색 활성화 값 boolean
	var searchCnd; //검색 옵션
	var searchWd; //검색 text
	var choicePage;//선택페이지
	var totalNoticeNum; //총게시물 수
	var viewNoticeMaxNum = 10; //한페이지당 게시물 수
	var viewPageMaxNum = 10; //한페이지당 페이징 수
	var $searchSelect; //검색 조건 select
	var $searchInp; //검색 input
	var $tbody; // table tbody
	
	//문서시작
	$(document).ready(function(){
		
		init() //검색 초기화 	
		searchStart(choicePage); //리스트 출력
		events(); //이벤트 등록		
	});//document
	
	var init = function(){
		
		$searchSelect = $("[name='searchCnd']"); //검색 조건 select
		$searchInp = $("input[name='searchWd']"); //검색 input
		searchCnd=$("[name='searchCnd'] option:selected").val(); //검색 옵션
		searchWd=$("input[name='searchWd']").val(); //검색 text 
		choicePage=$("input[name='choicePage']").val(); //선택페이지
		$tbody = $("tbody"); // table tbody
	}//init
	
	//event
	var events = function(){
		
		//상세보기 이벤트
		$tbody.on("click","td>a",detailEvent);
		//전체보기 이벤트 
		$("a[name='mainBtn']").on("click",mainList);
		//검색관련 이벤트
		$("a[name='searchBtn']").on('click',function(){
			valiChk(); //유효성검사 함수 호출
		});//onclick
		$searchInp.on('keydown',function(e){
			if(e.keyCode==13){
				valiChk(); //유효성검사 함수 호출
			}//if
		});//keydown
		
	}//events
	
	//option 텍스트 빈값 유효성 검사
	var valiChk = function(){
		if(!$searchSelect.find("option").index($searchSelect.find("option:selected"))){
			alert("option을 선택해주세요"); 
		}else if($searchInp.val()==""){
			alert("검색내용이 없습니다");
		}else{
			searching = true;
			searchStart();
		}//유효성 검사 후 리스트 출력 함수 호출if else
	}//valiChk
	
	//리스트 전 처리 후 출력 함수 호출 
	var searchStart =function(choicePage){
		if(searching){
			searchCnd  = $searchSelect.val(); //검색 옵션
			searchWd = $searchInp.val(); //검색 text 
		}//if
		boardListPrint(searchCnd,searchWd,choicePage); //리스트 출력함수 호출
	}//searchStart
			
	//리스트 출력 함수 (검색옵션,검색text,선택페이지)
	var boardListPrint = function(searchCnd,searchWd,choicePage){
		
		if(choicePage==undefined||choicePage==''){
			choicePage = 1;
		}//선택 페이지값이 들어오지 않은 경우 if
		
		if(searchCnd==undefined){
			searchCnd = "";
		}//검색 옵션 값이 들어오지 않은 경우 if
		
		if(searchWd==undefined){
			searchWd = "";
		}//검색 text 값이 들어오지 않은 경우 if
		
		var url = "reBoardList.do"; //data를 보낼 url
		
		var data = {} 
		
		data .choicePage=choicePage; //선택페이지
		data.searchCnd=searchCnd;  //검색 옵션
		data.searchWd=searchWd;  //검색 내용
		data.noticeCount = (data.choicePage-1)*viewNoticeMaxNum; //게시물 처음 순번
		data.noticeCountEnd = data.noticeCount+viewNoticeMaxNum; //게시물 마지막 순번
		
		
		var str=""; //append 시킬 string 저장 변수
		var thisList; //게시물 리스트 저장변수
		var count; //게시물 번호
		
		//paging.ajaxSubmit 호출
		paging.ajaxSubmit(url,data,function(result){
			
			if(result.length<=0){return false;}//if
			
			thisList = result;	
		
			totalNoticeNum = thisList[0].totalNoticeNum; //총 게시물 수		
		
			count = totalNoticeNum - ((data.choicePage-1)*viewNoticeMaxNum); //게시물 번호 구하기
	
			if(thisList!=null){
				$.each(thisList,function(index,value){
					str += "<tr style='cursor:pointer'>";
					str += "<td>"+count+"</td>";
					str += "<td><a href='#' name='"+value.boardNo+"'>"+value.boardTitle;
					//댓글 존재 여부 if
					if(value.replyCnt>0){
						str+= " ["+value.replyCnt+"]"
					}//if
					str +="</td>";
					str += "<td>"+value.boardWriter+"</td>";
					str += "<td>"+value.createDate+"</td>";
					str += "<td>"+value.boardClickCnt+"</td></tr>";
					
					count--;
				});//each
				
				$tbody.children().remove(); //이전 게시물 삭제
				$tbody.append(str); //게시물 생성
				
				var obj = {};
				obj.totalNoticeNum = totalNoticeNum; // 총게시물 수
				obj.choicePage = choicePage; // 선택 페이지 
				obj.viewPageMaxNum = viewPageMaxNum; // 한페이지당 페이징 갯수 
				obj.viewNoticeMaxNum = viewNoticeMaxNum; // 한페이지당 게시물 갯수
				
				//생성될 위치.페이징 출력 함수 호출(obj,callbackFuntion)
				$("nav[name='pagingNav']").pagingNav(obj, function(target){
					searching = false;
					searchStart(target.attr("name"));
				});
			}//if
			
		});//paging.ajaxSubmit	
	};//empListPrint

	//상세보기 이벤트 
	var detailEvent = function(){
		
		//게시물 번호 저장
		$("input[name='boardNo']").val($(this).attr("name"));		
		//선택 페이지 저장
		$("input[name='choicePage']").val($("li.active>a").attr("name"));
		//검색 옵션 저장
		$searchSelect.val(searchCnd);
		//검색 text 저장
		$searchInp.val(searchWd);
		
		//폼 전송
		$("form[name='searchForm']").submit();		
	}//detailEvent
	
	//메인 초기화 		
	var mainList = function(){
		window.location.href="reBoardMain.do";
	}//mainList
})();
	
</script>
</head>
<body>
	<div class='wrap'>
		<h2>게시판</h2>
    	<fieldset>
        	<form class="search_form" action="reBoardDetail.do" name="searchForm" method="post">
            	<legend class="a11y_hidden">게시판 목록 검색</legend>
            	<select title="분류선택" required="required" name="searchCnd">
            		<option value="all">선택</option>
                	<option value="boardTitle" <c:out value="${param.searchCnd eq 'boardTitle' ? 'selected' : ''}"/>>제목</option>
                	<option value="boardWriter" <c:out value="${param.searchCnd eq 'boardWriter' ? 'selected' : ''}"/>>작성자</option>
                	<option value="boardContent" <c:out value="${param.searchCnd eq 'boardContent' ? 'selected' : ''}"/>>내용</option>
            	</select>
            	<input id="search_word" name="searchWd" class="inp_type" title="검색어 입력" value="${param.searchWd}" type="text" required>
            	<input type="hidden" name="boardNo" value="${param.boardNo}"> 
            	<input type="hidden" name="choicePage" value="${param.choicePage}"/>
            	<a href="#" class="inp_btn" name="searchBtn"><span>검색하기</span></a>
        	</form>
    	</fieldset>
  		<table>
        	<caption class="a11y_hidden">게시판으로 번호 제목 작성자 작성일 조회수를 나타내는 표</caption>
        	<colgroup>
                <col style="width:10%">
                <col>
                <col style="width:15%">
                <col style="width:12%">
                <col style="width:9%">
                <col style="width:9%">
        	</colgroup>
        	<thead>
            	<tr>
                	<th scope="col">번호</th>
                	<th scope="col">제목</th>
                	<th scope="col">글쓴이</th>
                	<th scope="col">작성일</th>
                	<th scope="col">조회수</th>
            	</tr>
        	</thead>
        	<tbody>
				
			</tbody>
		</table>
		<nav name="pagingNav" class='ui_page_navigator' role='navigation' aria-label='페이지선택'>	
		</nav>
		<div class="unrole">
			<a href="#" title="전체보기" class="unrole_btn" name="mainBtn"><span>전체보기</span></a>
        	<a href="reBoardWrite.do" title="글등록" class="unrole_btn"><span>등록</span></a>
    	</div>	
	</div>
</body>
</html>