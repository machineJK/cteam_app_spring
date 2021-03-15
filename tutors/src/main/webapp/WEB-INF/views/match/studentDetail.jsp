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
	left:500px;
	font-size: 23px;
	text-align: center;
}
#nickname{
	font-size: 35px;
	font-weight: bold;
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
    font-size: 20px;
    padding-left: 30px;
}
.left{ padding-left: 25px; padding-top: 10px; font-size: 25px; }

</style>
</head>
<body>

<div class="grid-container">
	<div><img src="${studentDetail.student_image_path }" width="250" height="250"/></div>
	<div class="grid-content">
		<div class="left" id="nickname"> ${studentDetail.student_nickname }</div>
		<div class="left"> <i class="fas fa-graduation-cap"></i> ${studentDetail.student_grade }</div>
		<div class="left"> <i class="fas fa-book"></i> ${studentDetail.student_subject }</div>
		<div class="left"> <i class="fas fa-map-marker-alt"></i> ${studentDetail.student_addr }</div>
	</div>
	<c:if test="${loginInfo.id ne studentDetail.student_id }">
	<a href="#" class="btn-fill" id="goMatch" onclick="goChat('${loginInfo.id}');">상담하기</a>
	</c:if>
	<c:if test="${loginInfo.id eq studentDetail.student_id }">
	<a href="studentModify.match?student_id=${studentDetail.student_id }" class="btn-fill" id="goModify">수정하기</a>
	</c:if>
</div>
<div id="intro">
	${fn: replace(  fn:replace(studentDetail.student_intro, crlf, '<br>'), lf, '<br>') }
</div>

<script type="text/javascript">
function goChat(my_id){
	$.ajax({
		url: "teacher_check",
		data : {id : my_id},
		success : function(response){
			if(response == true){
				//alert("선생 아이디가 있어요! 채팅 가능 합니다!");
				/* 여기서 메세지 보내기 */
			}else{
				alert("먼저 선생으로 등록해주세요!");
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