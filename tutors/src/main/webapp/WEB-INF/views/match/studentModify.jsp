<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.grid-container {
  display: grid;
  grid-template-columns: 250px 800px;
  grid-template-rows: 250px;
  grid-gap: 20px;
  width: 1000px;
  margin: 0 auto;
  position: relative;
  margin-bottom: 30px;
}

.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: left;
}
.grid-content {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 50px auto;
  grid-gap: 10px;
}
#goMatch,#goModify{
	position: absolute;
	top:80px;
	right:80px;
	font-size: 50px;
	text-align: center;
}
#nickname{
	font-size: 35px;
}

textarea{resize: none; width: 1000px; height: 400px;}

</style>
</head>
<body>

	<form action="studentUpdate.match" method="post">
		<div class="grid-container">
			<div><img src="${vo.student_image_path }" width="250" height="250"/></div>
			<div class="grid-content">
				<div class="left" id="nickname"> ${vo.student_nickname }</div>
				<div class="left"> 학년 : 
					<select name="student_grade">
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
				</div>
				<div class="left"> 과목 : 
					<select name="student_subject">
						<option value="국어">국어</option>
						<option value="수학">수학</option>
						<option value="사회">사회</option>
						<option value="과학">과학</option>
						<option value="영어">영어</option>
					</select>
				</div>
				<div class="left"> <i class="fas fa-map-marker-alt"></i> ${vo.student_addr }</div>
			</div>
		</div>
		<div id="intro">
			<textarea name="student_intro">${vo.student_intro }</textarea>
		</div>
		<input type="hidden" name="student_id" value="${vo.student_id }" />
	</form>
	<a class="btn-fill" onclick="$('form').submit();">수정</a>
	<a class="btn-empty" onclick="history.go(-1);">취소</a>
</body>
</html>