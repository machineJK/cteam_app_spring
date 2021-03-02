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

table tr td { text-align:left; }
.valid, .invalid { font-size:13px; font-weight:bold; }
.valid { color:green; }
.invalid { color:red; }
</style>
</head>
<body>
<h3>[ ${vo.name} ] 내 프로필 정보수정</h3>


<form method="post" action='update.pro'>
<table class='w-pct40'>

<tr><th>아이디</th>
	<td><input type='text' name='id' id='id' value="${vo.id}" readonly='readonly'>
	</td>
</tr>
<tr><th>비밀번호</th>
	<td><input type='password' id='pw' name='pw' class='chk' />
	<div class='valid'>비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div>
	</td>
	<!-- <br>
	<div class='valid'>　</div></td> -->
</tr>
<tr><th>비밀번호 확인</th>
	<td><input type='password' id='pw_ck' name='pw_ck' class='chk' />
	<div class='valid'>비밀번호를 다시 입력하세요</div></td>
	<!-- <br>
	<div class='valid'>　</div></td> -->
	
</tr>
<tr><th>닉네임</th>
	<td><input type='text' class='chk' name='nickname' value='${vo.nickname}'/>
	
</tr>
<tr><th>이메일</th>
	<td><input type='text' class='chk' name='email' value='${vo.email}'/><br>
	<div class='valid'>　</div></td>
	
</tr>
</table>
</form>
<!-- $("form").submit() -->
<div class='btnSet'>
<a class='btn-fill' onclick='modifyMember()'>저장</a>
<a class='btn-empty' href='profile.pro?id=${loginInfo.id}'>취소</a>
<!-- <a class='btn-empty' href='javascript:history.go(-1)'>취소</a> -->
</div>
<script src="js/modify.js"></script>
<script type="text/javascript">
function modifyMember(){
	if(!item_check($('[name=pw]'))) return;
	if(!item_check($('[name=pw_ck]'))) return;
	if(!item_check($('[name=nickname]'))) return;
	if(!item_check($('[name=email]'))) return;
	
	$("form").submit();
}

function item_check(tag){
	var result = modify.tag_status(tag);

	if(result.code == "invalid"){
		alert("수정 불가!\n" + result.desc);
		tag.focus();
		return false;
	}else{
		return true;
	}
}
function pw_check(){
	var $pw = $('[name=pw]');
	var data = modify.tag_status($pw);
	if(data.code == "invalid"){
		alert("중복확인 불필요\n" + data.desc);
		$pw.focus();
		return;
	}
	
	$.ajax({
		type: "POST",
		url: "pw_check",
		data: {pw : $pw.val() },
		success: function(response) {			
			response = modify.pw_valid(response);
					
			if(result === "pwConfirmOK") {
				$('[name=pw]').html('');
				chk = true;
			} else {
				$('[name=pw_ck]').html('');
				chk = false;
			}
									
		},
		error : function(req,text) {
    		alert(text + " : " + req.status);
		}
	});

}

$(".chk").on('keyup', function(){
	validate($(this));
});

function validate(tag){
	var data = modify.tag_status(tag);
	tag.siblings("div").text(data.desc);
	tag.siblings("div").removeClass();
	tag.siblings("div").addClass(data.code);
}

</script>
</body>
</html>