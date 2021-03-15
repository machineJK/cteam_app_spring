<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<form method="post" action="teacherUpdate.match">
		<div class="grid-container">
			<div><img src="${vo.teacher_image_path }" width="250" height="250"/></div>
			<div class="grid-content">
				<div class="left" id="nickname">${vo.teacher_nickname }</div>
				<div class="left"> 대학교 : <input name="teacher_univ" type="text" value="${vo.teacher_univ }" placeholder="대학교를 입력하세요"/>
				학과 : <input name="teacher_major" type="text" value="${vo.teacher_major }" placeholder="전공을 입력하세요"/></div>
				<div class="left"> 학번 : <input name="teacher_univnum" type="text" value="${vo.teacher_univnum }" placeholder="학번을 입력하세요" maxlength="8"/></div>
				<div class="left"> 과목 : 
					<select name="teacher_subject">
						<option value="국어">국어</option>
						<option value="수학">수학</option>
						<option value="사회">사회</option>
						<option value="과학">과학</option>
						<option value="영어">영어</option>
					</select>
				</div>
				<div class="left"> 주 : <input name="teacher_worktime" type="text" value="${vo.teacher_worktime }" maxlength="1" placeholder="한 달에 몇주를 하실건가요?"/>
				수업료 :  <input name="teacher_pay" type="text" value="${vo.teacher_pay }" maxlength="2" placeholder="만원 기준입니다"/>  </div>
				<div class="left"> <i class="fas fa-map-marker-alt"></i> ${vo.teacher_addr }</div>
			</div>
		
		</div>
		<div id="intro">
			<textarea name="teacher_intro">${vo.teacher_intro }</textarea>
		</div>
		<input name="teacher_id" type="hidden" value="${vo.teacher_id }"/>
	</form>	
	<a class="btn-fill" onclick="$('form').submit()">수정</a>
	<a class="btn-empty" onclick="history.go(-1);">취소</a>
</body>
</html>