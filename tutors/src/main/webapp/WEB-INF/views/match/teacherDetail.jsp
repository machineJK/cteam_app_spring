<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  background-color: rgba(255, 255, 255, 0.5);
  text-align: left;
  border-radius: 10px;
}
.grid-content {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 50px auto;
  grid-gap: 10px;
}
#goMatch{
	position: absolute;
	top:4px;
	right:400px;
	font-size: 23px;
	text-align: center;
}
#nickname{
	font-size: 35px;
	padding-top: 10px;
}
#intro{
	width: 900px;
	height: 300px;
	margin: 0 auto;
	text-align: left;
	background-color: rgba(255, 255, 255, 0.5);
    border-radius: 10px;
    padding: 25px;
    padding-left: 30px;
    font-size: 20px;
}
.left{ padding-left: 25px; }

</style>
</head>
<body>

<div class="grid-container">
	<div><img src="${teacherDetail.teacher_image_path }" width="250" height="250"/></div>
	<div class="grid-content">
		<div class="left" id="nickname"> ${teacherDetail.teacher_nickname }</div>
		<div class="left"> <i class="fas fa-graduation-cap"></i> ${teacherDetail.teacher_univ } ${teacherDetail.teacher_major }</div>
		<div class="left"> <i class="far fa-address-card"></i> ${teacherDetail.teacher_univnum }</div>
		<div class="left"> <i class="fas fa-book"></i> ${teacherDetail.teacher_subject }</div>
		<div class="left"> <i class="fas fa-comment-dollar"></i> ${teacherDetail.teacher_worktime }시간 ${teacherDetail.teacher_pay }만원</div>
		<div class="left"> <i class="fas fa-map-marker-alt"></i> ${teacherDetail.teacher_addr }</div>
	</div>
	<a href="#" class="btn-fill" id="goMatch">상담하기</a><!-- 채팅방으로 이동하게 수정 -->
</div>
<div id="intro">
	${teacherDetail.teacher_intro }
</div>
	
</body>
</html>