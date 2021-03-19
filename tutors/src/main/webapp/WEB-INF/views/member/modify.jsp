<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">

.valid, .invalid { font-size:13px; font-weight:bold; }
.valid { color:#2a8ad4; }
.invalid { color:red; }
#isblind:hover, .fa-images{cursor: pointer;}
.fa-check{color: green;}
.fa-circle{font-size: 10px;}
#chk-id,#chk-pw,#chk-pwreg,#chk-email-circle{display: none;}
#chk-email{dispay: inline};
</style>

</head>
<body>
<br><br><br>
<h2>[ ${vo.name} ] 내 프로필 정보수정</h2>
<br><br>
<form method="post" action='update.pro' enctype="multipart/form-data">
<div class="title_image">
	<span id="preview">
		<img src="${vo.dbimgpath}" class="profile_image" style="width: 200px; height: 200px; border-radius: 100px">
	</span>
	<label>
		<input type='file' name='file' id='attach-file' accept=".jpg, .jpeg, .png, .bmp"/>
		<img src="images/gallery.png" style="width: 40px; height: 40px; margin-top: 160px;">
	</label>
	<span id='file-name'></span>
	<span id='delete-file'><i class='fas fa-times'></i></span>
</div>
<br>

<div class="title_modify">
	<div>
		<div class="updiv">아이디</div>		
	</div>
	<div>
		<label>
			<input type='text' class='upinput' name='id' id='id' value="${vo.id}" readonly='readonly'>
		</label>
	</div>
	
	<div>
		<div class="updiv">비밀번호</div>		
	</div>
	<div>
		<label>
			<input type='password' class='upinput' id='pw' name='pw' maxlength='13' style="margin-left: 24px;" />
			<span id="isblind"><i class="far fa-eye-slash"></i></span>
		<br><span id="chk-pw-circle"><i class="fas fa-circle"></i></span><span id="chk-pw"><i class="fas fa-check"></i></span> 비밀번호는 6~13자리 이하로 써주세요  
		<br><span id="chk-pwreg-circle"><i class="fas fa-circle"></i></span><span id="chk-pwreg"><i class="fas fa-check"></i></span> 비밀번호는 영어 대문자, 소문자, 특수문자가<br> 1개이상 포함되어야 합니다
		</label>
	</div>
	
	<div>
		<div class="updiv" style="margin-top: 10px;">닉네임</div>		
	</div>
	<div>
		<label>
			<input type='text' class='upinput' name='nickname' value='${vo.nickname}'/>
		</label>
	</div>
	
	<div>
		<div class="updiv">이메일</div>		
	</div>
	<div>
		<label>
			<input type='text' class='upinput' name='email' value='${vo.email}'/><br>
		<span id="chk-email-circle"><i class="fas fa-circle"></i></span><span id="chk-email"><i class="fas fa-check"></i></span> 이메일을 바르게 적어주세요!
	</label>
	</div>
</div>
<input type='hidden' name='filename' />
</form>
<!-- $("form").submit() -->
<div class='btnSet'>
<a class='btn-fill' onclick="if( emptyCheck() ){ $('[name=filename]').val( $('#file-name').text() ); go_save()}" style="font-size: 20px; width: 60px;">저장</a>
<!-- <a class='btn-fill' onclick="$('form').submit()" style="font-size: 20px; width: 60px;">저장</a> -->
<a class='btn-empty' href='profile.pro?id=${loginInfo.id}' style="font-size: 20px; width: 80px;">취소</a>
<!-- <a class='btn-empty' href='javascript:history.go(-1)'>취소</a> -->
</div>	

<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript">

function go_save(){
if( ${!empty vo.filename} ){
	$('#delete-file').css('display','inline');
}
	if($("[name=nickname]").val() == ""){
		alert("닉네임을 작성해 주세요!");
		$("[name=nickname]").focus();
		return;
	}
	if($("#chk-pw").css("display") == "none" || 
			   $("#chk-pwreg").css("display") == "none" ||
			   $("#chk-email").css("display") == "none"){
				alert("양식에 맞게 정보를 입력해 주세요!");
				return;
	}
	
	$("form").submit();
}

//input text스페이스바 막기
$("input").keydown(function(){
	preventSpacebar();
});
 
//스페이스바 막기
function preventSpacebar(){
	var keycode = event.keyCode;
	if(keycode == 32) event.returnValue = false;
}

//비밀번호 유효성 검사
$("[name=pw]").keyup(function(){
	//var reg = /^[a-z0-9~!@#$%^&*()]/g;
	var symbol = /[~!@#$%^&*()]/g, lower = /[a-z]/g, digit = /[0-9]/g, nums = /^.{6,13}/g;
	if(symbol.test($(this).val()) && lower.test($(this).val()) && digit.test($(this).val())){
		$("#chk-pwreg-circle").css("display","none");
		$("#chk-pwreg").css("display","inline");	
	}else{
		$("#chk-pwreg").css("display","none");
		$("#chk-pwreg-circle").css("display","inline");
	}

	if(nums.test($(this).val())){
		$("#chk-pw-circle").css("display","none");
		$("#chk-pw").css("display","inline");	
	}else{
		$("#chk-pw").css("display","none");
		$("#chk-pw-circle").css("display","inline");
	}
		
});

//이메일 유효성 검사
$("[name=email]").keyup(function(){
	var reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{3}$/i;

	if(reg.test($(this).val())){
 	 	$("#chk-email-circle").css("display","none");
		$("#chk-email").css("display","inline");		
	}else{
		$("#chk-email").css("display","none");
		$("#chk-email-circle").css("display","inline");
	}
	
});



//눈 모양을 클릭했을 때 이미지가 바뀌고 비밀번호가 보이게 또는 보이지 않게 변경
$("#isblind").click(function(){
	if($(this).find('.fa-eye-slash').length > 0){
		$(this).find('.fa-eye-slash').attr('class',"far fa-eye");
		$("[name=pw]").attr("type","text");
	}else{
		$(this).find('.fa-eye').attr('class',"far fa-eye-slash");
		$("[name=pw]").attr("type","password");
	}
	/* $(this).find("[data-fa-i2svg]").toggleClass("fa-eye").toggleClass("fa-eye-slash");

	if($(this).find('.fa-eye-slash').length > 0){
		$("[name=pw]").attr("type","password");
	}else{
		$("[name=pw]").attr("type","text");
	} */
});
</script>
</body>
</html>