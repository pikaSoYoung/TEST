<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="/spring/resources/common/js/jquery.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>

<script>
	
	$(document).ready(function(){	
		popup(); //팝업 리스트 출력
		events(); //이벤트 등록
	});//document
	
	//이벤트
	var events = function(){
		$("body").on("click","[name='popupCloseBtn']",popupClose);
	}//events

	//팝업 오픈
	var popup = function(){
		
		paging.ajaxSubmit("popup.ajax","",function(result){
			
			var popupList = result; //팝업 리스트
			var fileName = ""; //경로를 제외한 파일이름 저장변수
			
			//팝업 리스트 존재여부 if
			if(popupList!=null&& popupList.length>0){
				//팝업 리스트 each
				$.each(popupList,function(index,value){
					fileName = value.pSysNm;
					
					//쿠키에 해당 파일명 존재 여부
					if(getCookie(fileName)==""||getCookie(fileName)==false){
						
						var str = 	"<div name='popupModalWrap' class='modalWrap' >"+
			  							"<button type='button' class='closeBtn' name='popupCloseBtn'>X</button>"+
			  							"<a href='"+value.pUrl+"'>"+
			  								"<img src='/spring/popupImg/"+fileName+"'>"+
			  							"</a>"+
										"<div>"+
											"<span>오늘 하루 보이지 않음</span>"+
											"<input type='checkbox' name='checkPopup' style='cursor:pointer;'>"+
										"</div>"+
									"</div>";
						//팝업 생성		
						$("body").append(str);
					}//if
				});//each
			}//if
		});//paging.ajaxSubmit
	}//popup
	
	//팝업 창 닫기
	var popupClose = function(){
		
		var $thisWrap = $(this).parent("div");
		var check = $thisWrap.find("[name='checkPopup']").prop("checked");
		var imgHref = $thisWrap.find("img").attr("src");
		
		var fileName = imgHref.substring(imgHref.lastIndexOf("/")+1);
		
		if(check==true){
			//쿠기에 해당 파일명 저장
			setCookie(fileName,true,1);	
		}//if
		
		//해당 팝업 hide()
		$thisWrap.hide();	
	}//popupClose
	
	//쿠키 설정 (name,value,유효날짜)
	var setCookie = function(cname, cvalue, exdays, fileName){
		
		var date = new Date();
		var today = date.setTime(date.getTime() + (exdays*24*60*60*1000));
		var expires = "expires="+date.toUTCString();
		
		document.cookie = cname + "=" + cvalue +"; "+ expires+";"	
	}//setCookie
	
	//쿠키 추출
	var getCookie = function(cname){
		
		 var name = cname + "=";
		 var ca = document.cookie.split(';');
		    
		 for(var i=0; i<ca.length; i++) {
		    var c = ca[i];
		    while (c.charAt(0)==' ') c = c.substring(1);
		    if (c.indexOf(name) != -1){
		    	return c.substring(name.length,c.length);
		    }//if
		 }//for
		 return "";
	}//getCookie
	
	//쿠키 삭제
	var deleteCookie =function(cname){
	
		var date = new Date();
		var yesterday = date.setTime(date.getTime() - (1*24*60*60*1000));
		var expires = "expires="+yesterday.toUTCString();
		 
		document.cookie = cname+"="+getCookie(cname)+"; " + expires + ";" 
	}//deleteCookie
</script>
</head>
<body style="margin:100px; position:relative; top:0; left:0;">
	<ul>
		<!-- <li><a href="">메뉴트리</a></li> -->
		<li><a href="categoryMain.do">카테고리</a></li>
		<li><a href="boardMain.do">게시판</a></li>
		<li><a href="reBoardMain.do">댓글게시판</a></li>
		<li><a href="excelFileForm.do">엑셀파일업로드</a></li>
		<li><a href="chartTest.do">차트</a></li>
		<!-- <li><a href="fullcalendar.do">일정 달력</a></li> -->
		<li><a href="popupInsertForm.do">POPUP 설정</a></li>
	</ul>	

</body>
</html>