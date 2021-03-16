<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	textarea {outline:none; width: 600px; height: 200px; font-size: 16px; border-radius: 15px; 
	border:none; padding:10px; resize: none;}
</style>
</head>
<body>
	<form action="student_join" method="post">
		<select name="student_grade"  class="font upinput" style="height: 32px; width: 80px;">
			<option value="초1">초1</option>
			<option value="초2">초2</option>
			<option value="초3">초3</option>
			<option value="초4">초4</option>
			<option value="초5">초5</option>
			<option value="초6">초6</option>
			<option value="중1">중1</option>
			<option value="중2">중2</option>
			<option value="중3">중3</option>
			<option value="고1">고1</option>
			<option value="고2">고2</option>
			<option value="고3">고3</option>
		</select>	
		<select name="student_subject"  class="font upinput" style="height: 32px; width: 80px;">
			<option value="국어">국어</option>
			<option value="수학">수학</option>
			<option value="영어">영어</option>
			<option value="사회">사회</option>
			<option value="과학">과학</option>
		</select>
		<br><br>
		<textarea name="student_intro" placeholder="소개말" class="font"></textarea>
		
		<input type="hidden" name="student_id" value="${loginInfo.id }"/>
		<input type="hidden" name="student_image_path" value="${loginInfo.dbimgpath }"/>
		<input type="hidden" name="student_addr" value="${loginInfo.addr1 } ${loginInfo.addr2}"/>
		<input type="hidden" name="student_nickname" value="${loginInfo.nickname }"/>
	</form>
	<a class="btn-fill" onclick="go_submit();">등록</a>
	<a class="btn-fill" onclick="go_cancel();">취소</a>
	
<script type="text/javascript">
function go_submit(){
	if($("textarea").val() == ''){
		alert("빈 공간을 작성해주세요!");
		return;
	}else{
		$("form").submit();
	}
}
function go_cancel(){
	location.href="index";
}
</script>
</body>
</html>