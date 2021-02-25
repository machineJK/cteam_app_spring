<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
.pwd { height: 60px; }
table tr td { text-align:left; }
input[name=addr] { width:calc(100% - 24px); }
.valid, .invalid { font-size:13px; font-weight:bold; }
.valid { color:green; }
.invalid { color:red; }
</style>
</head>
<body>
<h3>[ ${vo.name} ] 내 프로필 정보수정</h3>

<form method="post" action='update.pro'>
<input type='hidden' name='id' value='${vo.id}' />
<table class='w-pct40'>

<tr><th>아이디</th>
	<td>${vo.id}</td>
</tr>
<tr><th class='pwd'>비밀번호</th>
	<td><input type='password' class='chk' name='pw' />
	<div class='valid'>비밀번호를 입력하세요(영문대/소문자, 숫자를 모두 포함)</div>
	</td>
</tr>
<tr><th class='pwd'>비밀번호 확인</th>
	<td><input type='password' class='chk' name='pw_ck' />
	<div class='valid'>비밀번호를 다시 입력하세요</div></td>
</tr>
<tr><th>닉네임</th>
	<td><input type='text' class='w-px300' name='nickname' value='${vo.nickname}'/>
	
</tr>
<tr><th>이메일</th>
	<td><input type='text' class='w-px300' name='email' value='${vo.email}'/>
	
</tr>
</table>
</form>
<!-- $("form").submit() -->
<div class='btnSet'>
<a class='btn-fill' onclick='go_save()'>저장</a>
<a class='btn-empty' href='profile.pro?id=${loginInfo.id}'>취소</a>
<!-- <a class='btn-empty' href='javascript:history.go(-1)'>취소</a> -->
</div>
<script type="text/javascript" src="js/modify.js"></script>
<script type="text/javascript">
function go_save() {
	if(!item_check($('[name=pw]'))) return;
	if(!item_check($('[name=pw_ck]'))) return;
	if(!item_check($('[name=nickname]'))) return;
	if(!item_check($('[name=email]'))) return;
	
	$('form').submit();
}

function item_check(item) {
	var data = join.tag_status(item);
	if(data.code == 'invalid') {
		alert('수정 불가! \n' + data.desc);
		item.focus();
		return false;
	} else return true;
}
</script>
</body>
</html>