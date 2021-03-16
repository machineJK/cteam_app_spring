<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	input{border: none; width: 400px; font-size: 16px; height: 40px; border-radius: 15px; outline: none; margin-bottom: 10px;}
	input:hover{background-color: #CCCCCC;}
	input:focus{background-color: #FFFFFF;  outline: none;}
	select{margin-bottom: 10px;}
	textarea {outline:none; width: 600px; height: 200px; font-size: 16px; border-radius: 15px; 
	border:none; padding:10px; resize: none;}
</style>
</head>
<body>
	<h3>선생님 등록하기</h3>
	<form action="teacher_join" method="post">
		<input type="text" name="teacher_univ" placeholder="대학교" maxlength="10" class="font"/><br>
		<input type="text" name="teacher_major"  placeholder="전공" maxlength="10" class="font"/><br>
		<input type="text" name="teacher_univnum" placeholder="학번" maxlength="8" class="font" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><br>
		<select name="teacher_subject" class="font upinput" style="height: 32px; width: 80px;">
			<option value="국어">국어</option>
			<option value="수학">수학</option>
			<option value="영어">영어</option>
			<option value="사회">사회</option>
			<option value="과학">과학</option>
		</select><br>
		<input name="teacher_worktime" class="font" type="text" placeholder="몇 주" maxlength="1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><br>
		<input name="teacher_pay" class="font" type="text" placeholder="수업료" maxlength="2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><br>
		<textarea name="teacher_intro" placeholder="소개말" class="font"></textarea>
		
		<input type="hidden" name="teacher_id" value="${loginInfo.id }" />
		<input type="hidden" name="teacher_image_path" value="${loginInfo.dbimgpath }" />
		<input type="hidden" name="teacher_nickname" value="${loginInfo.nickname }" />
		<input type="hidden" name="teacher_addr" value="${loginInfo.addr1 } ${loginInfo.addr2 }" />
	</form>
	<a class="btn-fill" onclick="go_submit();">등록</a>
	<a class="btn-fill" onclick="go_cancel();">취소</a>
	
<script type="text/javascript">
function go_submit(){
	if($("input").val() == '' || $("textarea").val() == ''){
		alert("빈 공간을 작성해주세요!");
		return;
	}
	$("form").submit();
}
function go_cancel(){
	location.href="index";
}

</script>
</body>
</html>