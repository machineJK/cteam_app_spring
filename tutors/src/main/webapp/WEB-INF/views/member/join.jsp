<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table tr td { text-align:center; }
	.valid, .invalid{font-size: 13px; font-weight: bold;}
	.valid{color:green;}
	.invalid{color:red;}
	table, table tr td, table tr th {border:none;}
	input{border: none; border-bottom: 1px solid black; width: 400px;}
	input[name=id]{border: none; border-bottom: 1px solid black; width: 326px;}
	input[name=pw]{border: none; border-bottom: 1px solid black; width: 377px;}
	/* input:focus {outline:none;} */ /* input태그를 눌렀을 때 나오는 테두리 없애기 */
	#isblind:hover, .fa-images{cursor: pointer;}
	/* #blind{display: none;} */
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
<h3>회원가입</h3>

<form method="post" action="join" style="margin-bottom: 10px;" enctype="multipart/form-data">
<table class='w-pct50'>
<tr>
	<td><input type='text' name='name' placeholder="이름을 입력하세요" maxlength="4"/></td>
</tr>
<tr>
	<td><input type='text' name='id' class="chk" placeholder="아이디를 입력하세요" />
		<a class="btn-fill-s" id="btn-id">중복확인</a>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><input type='text' name='nickname' class="chk" placeholder="닉네임을 입력해주세요"/><br>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><input type='password' name='pw' class="chk" placeholder="비밀번호를 입력하세요"/>
		<span id="isblind"><i class="far fa-eye-slash"></i></span><!-- <span id="blind"><i class="far fa-eye"></i></span> --><br>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><label><input type='radio' name='gender' value='남' checked />남</label>
		<label><input type='radio' name='gender' value='여' />여</label>
	</td>
</tr>
<tr>
	<td><input type='text' name='email' class="chk" placeholder="이메일을 입력해주세요"/><br>
		<div class="valid"></div>
	</td>
</tr>
<!-- 참고 -->
<tr>
	<td><input type='text' name='birth' placeholder="생일을 입력해주세요" />
		<span id="delete" style="color:red; position:relative; right:25px; cursor: pointer; display:none;">
		<i class="fas fa-times"></i></span></td>
</tr>
<tr>
	<td>
		<select id="addr1" name="addr1">
			<option value="광주">광주</option>
			<option value="부산">부산</option>
			<option value="대구">대구</option>
			<option value="인천">인천</option>
			<option value="울산">울산</option>
			<option value="서울">서울</option>
			<option value="대전">대전</option>
		</select>
		<select id="addr2" name="addr2">
			<option value='동구'>동구</option>
			<option value='서구'>서구</option>
			<option value='북구'>북구</option>
			<option value='남구'>남구</option>
			<option value='광산구'>광산구</option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<span id="preview"><img src="images/blank-profile-picture.png" width="100" height="100"></span>
		<label>
			<input type='file' name='file' id='attach-file' accept=".jpg, .jpeg, .png, .bmp"/>
			<i class="fas fa-images"></i>
		</label>
		<span id='file-name'></span>
		<span id='delete-file'><i class='fas fa-times'></i></span>
		
	</td>
</tr>

</table>

</form>

<a class="btn-fill" onclick="go_join()">회원가입</a>
<a class="btn-empty" href="<c:url value='/' />">취소</a>

<!-- datepicker jQueryUI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="js/join_chk.js"></script>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript">
//눈 모양을 클릭했을 때 이미지가 바뀌고 비밀번호가 보이게 또는 보이지 않게 변경
$("#isblind, #blind").click(function(){
	/* if($(this).find('.fa-eye-slash').length > 0){
		$(this).find('.fa-eye-slash').attr('class',"far fa-eye");
		$("[name=pw]").attr("type","text");
	}else{
		$(this).find('.fa-eye').attr('class',"far fa-eye-slash");
		$("[name=pw]").attr("type","password");
	} */
	
	$(this).find("[data-fa-i2svg]").toggleClass("fa-eye").toggleClass("fa-eye-slash");

	if($(this).find('.fa-eye-slash').length > 0){
		$("[name=pw]").attr("type","password");
	}else{
		$("[name=pw]").attr("type","text");
	}
});

//광역시가 어디냐에 따라 구군이 달라짐(#addr1,#addr2)
$("#addr1").change(function(){
	if($("#addr1 option:selected").val() == "광주"){
		var option2 = "<option value='동구'>동구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='광산구'>광산구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "부산"){
		var option2 = "<option value='부산진구'>부산진구</option>"
				    + "<option value='동래구'>동래구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='강서구'>강서구</option>"
				    + "<option value='해운대구'>해운대구</option>"
				    + "<option value='사하구'>사하구</option>"
				    + "<option value='금정구'>금정구</option>"
				    + "<option value='연제구'>연제구</option>"
				    + "<option value='수영구'>수영구</option>"
				    + "<option value='사상구'>사상구</option>"
				    + "<option value='기장군'>기장군</option>"
				    + "<option value='중구'>중구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='영도구'>영도구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "대구"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='수성구'>수성구</option>"
				    + "<option value='달서구'>달서구</option>"
				    + "<option value='달성군'>달성군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "인천"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='미추홀구'>미추홀구</option>"
				    + "<option value='연수구'>연수구</option>"
				    + "<option value='남동구'>남동구</option>"
				    + "<option value='부평구'>부평구</option>"
				    + "<option value='계양구'>계양구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='강화군'>강화군</option>"
				    + "<option value='옹진군'>옹진군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "울산"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='울주군'>울주군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "서울"){
		var option2 = "<option value='종로구'>종로구</option>"
				    + "<option value='중구'>중구</option>"
				    + "<option value='용산구'>용산구</option>"
				    + "<option value='성동구'>성동구</option>"
				    + "<option value='광진구'>광진구</option>"
				    + "<option value='동대문구'>동대문구</option>"
				    + "<option value='중랑구'>중랑구</option>"
				    + "<option value='성북구'>성북구</option>"
				    + "<option value='강북구'>강북구</option>"
				    + "<option value='도봉구'>도봉구</option>"
				    + "<option value='노원구'>노원구</option>"
				    + "<option value='은평구'>은평구</option>"
				    + "<option value='서대문구'>서대문구</option>"
				    + "<option value='마포구'>마포구</option>"
				    + "<option value='양천구'>양천구</option>"
				    + "<option value='강서구'>강서구</option>"
				    + "<option value='구로구'>구로구</option>"
				    + "<option value='금천구'>금천구</option>"
				    + "<option value='영등포구'>영등포구</option>"
				    + "<option value='동작구'>동작구</option>"
				    + "<option value='관악구'>관악구</option>"
				    + "<option value='서초구'>서초구</option>"
				    + "<option value='강남구'>강남구</option>"
				    + "<option value='송파구'>송파구</option>"
				    + "<option value='강동구'>강동구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "대전"){
		var option2 = "<option value='east'>동구</option>"
				    + "<option value='west'>중구</option>"
				    + "<option value='north'>서구</option>"
				    + "<option value='south'>유성구</option>"
				    + "<option value='gwangsan'>대덕구</option>";
		$("#addr2").html(option2);
	}
});

//회원가입
function go_join(){
	//이름이 입력되지 않았을경우
	if($("[name=name]").val() == ""){
		alert("이름을 입력하세요!!!");
		$("[name=name]").focus();
		return;
	}
	
	//아이디 중복확인 한 경우 : chked 클래스가 있음
	if($("[name=id]").hasClass("chked")){
		if($("[name=id]").siblings("div").hasClass("invalid")){	//아이디 중복체크는 했는데 아이디가 중복일 경우
			alert("회원가입 불가!\n" + join.id.unusable.desc);
			$("[name=id]").focus();
			return;
		}
		
	}else{	//아이디 중복체크를 하지 않았을경우
		if(!item_check($("[name=id]"))) return;
		else{
			alert(join.id.valid.desc);
			$("[name=id]").focus();
			return;
		}
	}
	
	
	//아이디 중복확인 하지 않은 경우
	if(!item_check($("[name=pw]"))) return;
	if(!item_check($("[name=email]"))) return;
	if($("#attach-file").val() == ""){
		alert("프로필 사진을 반드시 넣어주세요!");
		return;
	}
	
	$("form").submit();
}

//정규식을 이용해 전달한 값이 정규식과 맞는지 판단 후 true나 false return
function item_check(tag){
	var result = join.tag_status(tag);
	if(result.code == "invalid"){
		alert("회원가입 불가!\n" + result.desc);
		tag.focus();
		return false;
	}else{
		return true;
	}
}


//datepicker
$(function(){
	var today = new Date();
	//var endDay = new Date( today.getFullYear()-15, today.getMonth(), today.getDate());
	//console.log(endDay);
	
	$("[name=birth]").datepicker({
		dayNamesMin: ["일","월","화","수","목","금","토"],
		dateFormat : "yy.mm.dd",
		changeYear : true,
		changeMonth : true,
		showMonthAfterYear: true,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		//beforeShowDay:after
		//maxDate: endDay
		yearRange: "" + (today.getFullYear()-60) +":" + (today.getFullYear()-7),
		maxDate: today.getFullYear()-7
	});
});

//아이디 중복확인
function id_check(){
	//먼저 아이디가 규칙에 맞게 작성되어 있는지 확인
	var $id = $('[name=id]');
	var data = join.tag_status($id);
	if(data.code == "invalid"){
		alert("규칙에 맞게 아이디를 먼저 작성해 주세요!" + data.desc);
		$id.focus();
		return;
	}
	
	$.ajax({
		type : "post",
		url : "id_check",
		data : {id : $id.val() },
		success : function(response){
			response = join.id_usable(response);
			
			$id.siblings("div").text(response.desc);
			$id.siblings("div").removeClass();
			$id.siblings("div").addClass(response.code);	
			$id.addClass("chked");
		},
		error : function(req,text){
			alert(text + " : " + req.status);
		}
		
	});
	
	
}

//중복확인 버튼 클릭시 중복확인 메소드 실행
$("#btn-id").on("click",function(){
	id_check();
});


//id,pw 등등 실시간으로 체크(규칙에 맞는지)
$(".chk").on('keyup', function(){
	validate($(this));
});

function validate(tag){
	var data = join.tag_status(tag);
	tag.siblings("div").text(data.desc);
	tag.siblings("div").removeClass();
	tag.siblings("div").addClass(data.code);
}

//name=id 일경우 엔터키를 눌렀을 때 submit이 아닌 중복확인버튼이 눌리게 바꾸기
$(".chk").on("keyup",function(e){
	if($(this).attr("name")=="id"){
		if(e.keyCode==13){
			id_check();
			return;
		}else{
			$(this).removeClass("chked");
		}
	}
	validate($(this));
});


//name=birth에 change가 일어날 경우 X자 버튼 나오게 하기
$("[name=birth]").change(function(){
	$("#delete").css("display","inline");
});

//X자 버튼 클릭하면 사라지게 만들고 name=birth의 val을 빈공간으로 변경
$("#delete").click(function(){
	$("[name=birth]").val('');
	$("#delete").css("display","none");
});

//datepicker
/* function after(date){
	if(date > new Date()){
		return [false];
	}else{
		return [true];
	}
} */


</script>


</body>




</html>