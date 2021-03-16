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
  background-color: rgba(255, 255, 255, 0.5);
  border: 1.5px solid #DCDCDC;
  text-align: left;
  border-radius: 10px;
}
.grid-content {
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 50px auto;
  grid-gap: 10px;
}
#goMatch,#goModify{
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
	border: 1.5px solid #DCDCDC;
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
		<div class="left"> <i class="far fa-address-card"></i> ${fn:substring(teacherDetail.teacher_univnum,2,4) }학번</div>
		<div class="left"> <i class="fas fa-book"></i> ${teacherDetail.teacher_subject }</div>
		<div class="left"> <i class="fas fa-comment-dollar"></i> ${teacherDetail.teacher_worktime }시간 ${teacherDetail.teacher_pay }만원</div>
		<div class="left"> <i class="fas fa-map-marker-alt"></i> ${teacherDetail.teacher_addr }</div>
	</div>
	<c:if test="${loginInfo.id ne teacherDetail.teacher_id }">
	<a class="btn-fill" id="goMatch" onclick="goChat('${loginInfo.id}');">상담하기</a>
	</c:if>
	<c:if test="${loginInfo.id eq teacherDetail.teacher_id }">
	<a href="teacherModify.match?teacher_id=${teacherDetail.teacher_id}" class="btn-fill" id="goModify">수정하기</a>
	</c:if>
</div>
<div id="intro">
	${fn: replace(  fn:replace(teacherDetail.teacher_intro, crlf, '<br>'), lf, '<br>') }
</div>
<input type="hidden" id="t_id" value="${teacherDetail.teacher_id}"/>
<input type="hidden" id="t_nickname" value="${teacherDetail.teacher_nickname}"/>
<input type="hidden" id="t_intro" value="${teacherDetail.teacher_intro}"/>
<input type="hidden" id="myId" value="${loginInfo.id}"/>

<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-analytics.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-database.js"></script>
<script src="js/chat.js"></script>

<script type="text/javascript">
var t_id = $('#t_id').val() + '1';
var t_nickname = $('#t_nickname').val();
var t_intro = $('#t_intro').val();
var myId = $('#myId').val();

function goChat(my_id){
	$.ajax({
		url: "student_check",
		data : {id : my_id},
		success : function(response){
			if(response == true){
				chatWithTeacher(t_id, t_nickname, t_intro, myId);
				setTimeout(function() {
					location.href = "list.chat?receiveId=" + t_id;
				}, 1000);
			}else{
				alert("먼저 학생으로 등록해주세요!");
				location.href = "list.match";
			}
		},
		error : function(req,text){
			alert(text + " : " + req.status);
		}
	});
}
</script>

</body>
</html>