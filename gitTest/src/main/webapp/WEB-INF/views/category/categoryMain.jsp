<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script> 
<script src="/spring/resources/common/js/paging.js"></script>
<style>
	
	button{
		margin-right:5px;
	}

</style>
</head>
<body style="padding:100px">
	<select name="category" id="first">
		<option value="0">전체선택</option>
	</select>
	<select name="category" id="second">
		<option value="0">전체선택</option>
	</select>
	<select name="category" id="third">
		<option value="0">전체선택</option>
	</select>
	<select name="category" id="fourth">
		<option value="0">전체선택</option>
	</select>
	<select name="category" id="fifth">
		<option value="0">전체선택</option>
	</select>
		<div name="categoryInpWrap" style="margin-top:80px">
			<p>1단계 : </p><input type="text" />
		</div>
		<div name="categoryInpWrap">
			<p>2단계 : </p><input type="text" />
		</div>
		<div name="categoryInpWrap">
			<p>3단계 : </p><input type="text" />
		</div>
		<div name="categoryInpWrap">
			<p>4단계 : </p><input type="text" />
		</div>
		<div name="categoryInpWrap">
			<p>5단계 : </p><input type="text" />
		</div>
	
	<script>
	(function(){

        var dataObj; //전송보낼 data 저장 변수
        var $thisObj; //$(this) 저장 변수
        var $select; //select 저장 변수
        var $divWrap; //input을 감싸는 div 저장 변수
        var insertBtn; //등록버튼
        var updateBtn; //업데이트버튼
        var deleteBtn; //삭제버튼
        var submitBtn; //전송버튼
        var escBtn; //취소버튼

        //문서 시작
        $(document).ready(function(){
            init();
        });//document ready

        //초기화
        var init = function(){

            $select = $("select[name='category']"); //select 저장
            $divWrap = $("div[name='categoryInpWrap']");//input을 감싸는 div 저장

            //Btn string 생성
            insertBtn = "<button type='button' name='insertBtn'>등록</button>";
            updateBtn = "<button type='button' name='updateBtn'>수정</button>";
            deleteBtn = "<button type='button' name='deleteBtn'>삭제</button>";
            submitBtn = "<button type='button' name='submitBtn'>전송</button>";
            escBtn = "<button type='button' name='escBtn'>취소</button>";

            //카테고리 리스트 출력
            categoryList(0,0,$select);
            //등록 버튼 생성
            $divWrap.eq(0).append(insertBtn);

            //이벤트 등록 변수
            var events = function(){
                $select.on("change",changeEvent);
                $divWrap.on("click","button[name='insertBtn']",insertEvent);
                $divWrap.on("click","button[name='updateBtn']",updateEvent);
                $divWrap.on("click","button[name='deleteBtn']",deleteEvent);
            }//events

            //이벤트 등록
            events();

        }//init

        //select option 초기화 (초기화대상)
        var optionInit = function(target){
            target.each(function(index){
                $(this).find("option:eq(0)").siblings().remove();
            });//each
        }//optionInit

        //카테고리 리스트 출력 저장 변수(부모코드,생성될option의select순번,초기화대상,카테고리등록시 등록된opNo)
        var categoryList = function(opPrntNo,idx,target,opNo){
            //option 초기화
            optionInit(target);

            dataObj ={};
            dataObj.opPrntNo = opPrntNo;

            //ajaxSubmit start
            paging.ajaxSubmit("categoryList.do",dataObj,function(result){

                //옵션 생성 each
                $.each(result,function(index,value){
                    $select.eq(idx).append("<option value='"+value.opNo+"'>"+value.opName+"</option>");
                });//each

                //새로 등록한 경우 등록된 option 선택
                if(opNo){
                    $select.eq(idx).val(opNo).trigger('change');
                }//if

            },true);//ajaxSubmit

        }//categoryList

        //select change event
        var changeEvent = function(){

            $thisObj = $(this);
            //change event 대상 index
            var idx = $select.index($thisObj);
            //선택된 option의 text
            var opName = $thisObj.children(":selected").text();
            var obj // disabled option object

            //input disabled (대상idx,수정 삭제버튼 생성 대상)
            var inputDisabled = function(idx,target,obj){

                //대상+nextAll disabled
                $divWrap.eq(idx).children("input").val(obj.val).attr("name",obj.name).prop("disabled",obj.disabled);
                $divWrap.eq(idx).nextAll().children("input").val("").attr("name","").prop("disabled",false);
                //수정 삭제버튼 생성
                target.append(updateBtn+deleteBtn);
            }//inputDisabled

            //insert 버튼 (등록버튼 생성 대상)
            var insertBtnAppend = function(target){
                target.append(insertBtn);
            }//insertBtnAppend

            //모든 버튼 삭제
            $divWrap.children("button").remove();

            //전체선택이 아닐 경우 if 시작
            if($thisObj.val()!=0){
                obj = {};
                obj.val = opName; //input value값 지정
                obj.name = $thisObj.val(); //input name값을 opNo로 지정
                obj.disabled = true; //disabled
                //input disabled
                inputDisabled(idx,$divWrap.eq(idx),obj);

                //등록버튼 생성
                insertBtnAppend($divWrap.eq(idx).next());
                //다음 select 카테고리 리스트 출력
                categoryList(obj.name,idx+1,$("select[name='category']").eq(idx).nextAll());

            }else{
                //option초기화 (현재select의nextAll)
                optionInit($select.eq(idx).nextAll());

                //전체선택 && 첫번째 select가 아닐경우
                if(idx!=0){
                    obj = {};
                    obj.val = ""; //value값 삭제
                    obj.name = ""; //name값 삭제
                    obj.disabled = false; //input 활성화

                    //input disabled
                    inputDisabled(idx,$divWrap.eq(idx).prev(),obj);

                }else{
                    //모든 input value값 삭제 및 활성화
                    $divWrap.children("input").val("").prop("disabled",false);
                }//if eles

                //등록버튼 생성
                insertBtnAppend($divWrap.eq(idx));

            }//if else

        }//changeEvent

        //카테고리 등록
        var insertEvent = function(){

            $thisObj = $(this);
             //등록 대상의 부모 div의 index
            var idx = eventTargetIdx();
            var opPrntNo = 0; //부모코드 저장 변수
            var opPrntIdx = 0; //부모 index 저장 변수
            var opName = $thisObj.siblings("input").val();

            //빈 문자 check
            if(!validate(opName)){
                alert("문자를 입력해주세요.");
                return false;
            }//if

            //index 가 0이 아니라면
            if(idx!=0){
                //부모 코드 저장
                opPrntNo = $select.eq(idx).prev().val();
            }//if

            dataObj ={};
            dataObj.opPrntNo = opPrntNo;
            dataObj.opName = opName;

            //ajaxSubmit start
            paging.ajaxSubmit("categoryInsert.do",dataObj,function(result){
                if(result.resultVal=1){

                   alert("정상처리되었습니다.");
                   var target =  $select; //모든 select 대상

                   //등록대상 select index가 0이 아니라면 다음 옵션 초기화
                   if(idx!=0){target = $select.eq(idx).nextAll();}

                   //카테고리 리스트 출력(부모코드,해당인덱스,초기화대상,등록옵션)
                   categoryList(opPrntNo,idx,target,result.opNo);

                }else{
                     alert("다시 시도해주세요.");
                }//if else
            },true);//ajaxSubmit end

        }//insertEvent

        //수정 버튼 클릭 시
        var updateEvent = function(){

            $thisObj = $(this);
            //등록 대상의 부모 div의 index
            var idx = eventTargetIdx();
            //현재 option text값 저장
            var opName = $thisObj.siblings("input").val();

            //비활성화 된 개체 활성화
            var activation = function(){
                $select.prop("disabled",false);
                $thisObj.parent("div[name='categoryInpWrap']").nextAll().children().prop("disabled",false);
                $thisObj.prop("disabled",false);
                $thisObj.next("button").prop("disabled",false);

                //전송 취소 버튼 삭제
                $("button[name='submitBtn']").remove();
                $("button[name='escBtn']").remove();

                //text 수정
                $thisObj.siblings("p").text((idx+1)+"단계 : ");
            }//activation

            //모든 select disabled
            $select.prop("disabled",true);
            //수정 대상 제외한 모든 div 개체 disabled
            $thisObj.parent("div[name='categoryInpWrap']").siblings("div").children().prop("disabled",true);

            //수정전 text append
            $thisObj.siblings("p").append(opName);
            //수정 input 활성화
            $thisObj.siblings("input").val("").prop("disabled",false);

            //수정버튼 disabled
            $thisObj.prop("disabled",true);
            //삭제버튼 disabled
            $thisObj.next().prop("disabled",true);

            //전송 취소 버튼 생성
            $thisObj.before(submitBtn+escBtn);

            //전송 이벤트
            var updateSubmit = function(){
                dataObj = {};
                dataObj.opNo = $thisObj.siblings("input").attr("name"); //수정될 opNo
                dataObj.opName = $thisObj.siblings("input").val(); //수정 text

                //빈문자 check
                if(!validate(dataObj.opName)){
                    alert("문자를 입력해주세요.");
                    return false;
                }//if

                //ajaxSubmit start
                paging.ajaxSubmit("categoryUpdate.do",dataObj,function(result){
                    //update 성공 시
                    if(result>0){
                        alert("정상 등록되었습니다.");

                        //수정 input disabled
                        $thisObj.siblings("input").prop("disabled",true);
                        //disabled 개체 활성화 & 전송 취소 버튼 삭제 & text 수정
                        activation();

                        //수정된 option text 변환
                        $select.eq(idx).find("option[value='"+$thisObj.siblings("input").attr("name")+"']").text(dataObj.opName);

                    }else{
                        alert("다시 등록해주세요.");
                    }//if else
                },true);//ajaxSubmit end

            }//updateSubmit

            //취소버튼 클릭시
            var escAct = function(){
                // 이전 상태로 되돌림
                $thisObj.siblings("input").prop("disabled",true).val(opName);

                //disabled 개체 활성화 & 전송 취소 버튼 삭제 & text 수정
                activation();
            }//escAct

            //전송 이벤트
            $("button[name='submitBtn']").on("click",function(){
                updateSubmit();
            });//click
            //취소 이벤트
            $("button[name='escBtn']").on("click",function(){
                escAct();
            });//click

        }//updateEvent

        //deleteEvent
        var deleteEvent = function(){

            $thisObj = $(this);
            var idx = eventTargetIdx();

            //option의 하위 option들이 존재시
            if($select.eq(idx).next().children("option").length>1){
                alert("해당 카테고리의 하위 카테고리를 삭제 후 진행해주세요.");
                return false;
            }//if

            dataObj = {};
            dataObj.opNo = $thisObj.siblings("input").attr("name");

            //ajaxSubmit start
            paging.ajaxSubmit("categoryDelete.do",dataObj,function(result){
                //삭제 성공시 if
                if(result>0){
                    alert("삭제되었습니다.");
                    //삭제한 category가 0이 아닐시 if
                    if(idx!=0) {
                        //해당 카테고리 리스트 출력 (부모코드,index,초기화대상)
                        categoryList($select.eq(idx).prev().val(),idx,$("select[name='category']").eq(idx-1).nextAll());
                        //전체선택으로 옵션 변경
                        $select.eq(idx).val("0").trigger('change');
                    }else if (idx==0) {
                        //삭제한 category가 0일시 초기화
                        init();
                    }//else if
                }else{
                    alert("다시 진행해주세요");
                }//if else
            },true);//ajaxSubmit end

        }//deleteEvent

        //유효성 검사
        var validate = function(opName){
            if(opName == '' || opName.length == 0 || opName == undefined || opName == null) {
                return false;
            }else{
                return true;
            }//if else
        }//validate

        //이벤트 대상의 순번 리턴
        var eventTargetIdx = function(){
            return $divWrap.index($thisObj.parent("div[name='categoryInpWrap']"));
        }//eventTargetIdx
    })();

	</script>
</body>
</html>