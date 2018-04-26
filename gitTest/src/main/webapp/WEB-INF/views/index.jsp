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
	
	var events = function(){
		$("body").on("click","[name='popupCloseBtn']",popupClose);
	}//events

	var popup = function(){
		var cookiedata = document.cookie;
		
		paging.ajaxSubmit("popup.ajax","",function(result){
			var popupList = result;
			var fileName = "";
			
			if(popupList!=null&& popupList.length>0){
				$.each(popupList,function(index,value){
					fileName = value.pSysNm;
					console.log(fileName+" : ",cookiedata+" : ",cookiedata.indexOf(fileName));
		
					if(cookiedata.indexOf(fileName)==-1){
						
						var str = 	"<div name='popupModalWrap' class='modalWrap' >"+
							  		"<button type='button' class='closeBtn' name='popupCloseBtn'>X</button>"+
							  		"<img src='/spring/popupImg/"+fileName+"'>"+
									"<div>"+
										"<span>오늘 하루 보이지 않음</span>"+
										"<input type='checkbox' name='checkPopup' style='cursor:pointer;'>"+
									"</div>"+
								"</div>";
								
						$("body").append(str);
					}//if
				});//each
			}//if
		});//paging.ajaxSubmit
	}//popup
	
	var popupClose = function(){
		var $thisWrap = $(this).parent("div");
		var check = $thisWrap.find("[name='checkPopup']").prop("checked");
		var imgHref = $thisWrap.find("img").attr("src");
		console.log("imgHref"+imgHref);
		var fileName = imgHref.substring(imgHref.lastIndexOf("/")+1);
		
		if(check==true){
			setCookie("fileName",fileName,1);	
		}//if
		
		$thisWrap.hide();
		
	}//popupClose
	
	var setCookie = function(cname, cvalue, exdays, fileName){
		var d = new Date();
		d.setTime(d.getTime() + (exdays*24*60*60*1000));
		var expires = "expires="+d.toUTCString();
		document.cookie += cname + "=" + cvalue + "; "+ expires ;
		console.log(document.cookie);
	}//setCookie
	
	var getCookie = function(cname){
		 var name = cname + "=";
		 var ca = document.cookie.split(';');
		    
		 for(var i=0; i<ca.length; i++) {
		    var c = ca[i];
		    while (c.charAt(0)==' ') c = c.substring(1);
		    if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
		 }
		 return "";
	}//getCookie
	
	/* 팝업 cookie 설정 출처 http://slreference.tistory.com/47 */

/*아래 소스 참고 cookie 설정 다시 하기*/	
	
/*Cookie 제거
function clearCookie( name ){

    var today = new Date();
    var expire_date = new Date(today.getTime() - 60*60*24*1000);
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString();
}

Cookie 체크 
function getCookie( name ){

	var dc = document.cookie;

	var prefix = name + "="

	var begin = dc.indexOf("; " + prefix);

	if ( begin == -1 ){

		begin = dc.indexOf(prefix);
		if (begin != 0) return null;
	}
	else begin += 2

	var end = document.cookie.indexOf(";", begin);

	if (end == -1) end = dc.length;

	return unescape(dc.substring(begin + prefix.length, end));
}

Cookie 컨트롤
function controlCookie( name, elemnt ){

	if ( elemnt.checked ){

	    var today = new Date()
	    var expire_date = new Date(today.getTime() + 60*60*6*1000)

		setCookie( name=name, value='true', expires=expire_date, path='/' );
		if (_ID(name) == null) setTimeout( "self.close()" );
		else setTimeout( "_ID('" + name + "').style.display='none'" );
	}
	else clearCookie( name );

	return
}
*/
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