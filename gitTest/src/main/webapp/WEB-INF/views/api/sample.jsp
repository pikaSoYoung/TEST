<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OPEN API 샘플 소스</title>

</head>
<body>
<form name="form" id="form" method="post">
  <input type="hidden" name="currentPage" value="1"/>				<!-- 요청 변수 설정 (현재 페이지. currentPage : n > 0) -->
  <input type="hidden" name="countPerPage" value="10"/>				<!-- 요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100) -->
  <input type="hidden" name="resultType" value="json"/> 			<!-- 요청 변수 설정 (검색결과형식 설정, json) --> 
  <input type="hidden" name="confmKey" value="U01TX0FVVEgyMDE4MDUwNDEwMDIyMzEwNzg1OTA="/>		<!-- 요청 변수 설정 (승인키) -->  
  <input type="text"   name="keyword" value=""/>					<!-- 요청 변수 설정 (키워드) -->
  <input type="button" onClick="getAddr(true);" value="주소검색하기"/>
  <div id="list"> 
  	<!-- 검색 결과 리스트 출력 영역 -->
  </div>
   	<nav name="pagingNav" class='ui_page_navigator' role='navigation' aria-label='페이지선택'>	
	</nav>
</form>
<link rel='stylesheet' href='/spring/resources/common/design/css/style.css' type='text/css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<script src="/spring/resources/common/js/pagingNav.js"></script>
<script language="javascript">
function getAddr(restart){
	 
	//재 검색의 경우 선택페이지 input 값 초기화
	if(restart==true){
		$("[name='currentPage']").val("1");
	}//if
	
	// AJAX 주소 검색 요청
	$.ajax({
		url:"addressApi.ajax"									// 고객사 API 호출할 Controller URL
		,type:"post"
		,data:$("#form").serialize() 								// 요청 변수 설정
		,dataType:"json"											// 데이터 결과 : JSON
		,success:function(jsonStr){									// jsonStr : 주소 검색 결과 JSON 데이터
			$("#list").html("");									// 결과 출력 영역 초기화
			var errCode = jsonStr.results.common.errorCode; 		// 응답코드
			var errDesc = jsonStr.results.common.errorMessage;		// 응답메시지
			if(errCode != "0"){ 									// 응답에러시 처리
				alert(errCode+"="+errDesc);
			}else{
				if(jsonStr!= null){
					makeListJson(jsonStr);							// 결과 JSON 데이터 파싱 및 출력
				}
			}
		}
		,error: function(xhr,status, error){
			alert("에러발생");										// AJAX 호출 에러
		}
	});
}//getAddr

function makeListJson(jsonStr){
	var htmlStr = "";
	htmlStr += "<table>";
	
	// jquery를 이용한 JSON 결과 데이터 파싱
	$(jsonStr.results.juso).each(function(){
		htmlStr += "<tr>";
		htmlStr += "<td>"+this.roadAddr+"</td>";
		htmlStr += "</tr>";
	});//each
	htmlStr += "</table>";
	// 결과 HTML을 FORM의 결과 출력 DIV에 삽입
	$("#list").html(htmlStr);
	
	var obj = {};
	
	obj.totalNoticeNum = jsonStr.results.common.totalCount; // 총게시물 수
	obj.choicePage = jsonStr.results.common.currentPage; // 선택 페이지 
	obj.viewPageMaxNum = 10; // 한페이지당 페이징 갯수 
	obj.viewNoticeMaxNum = jsonStr.results.common.countPerPage; // 한페이지당 게시물 갯수
	

	//생성될 위치.페이징 출력 함수 호출(obj,callbackFuntion)
	$("nav[name='pagingNav']").pagingNav(obj,function(target){
		 $("[name='currentPage']").val(target.attr("name"));
		 getAddr();
	});
	
}//makeListJson
</script>
</body>
</html>