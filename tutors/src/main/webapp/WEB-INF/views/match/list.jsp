<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.grid-container {
	display: grid;
	width: 60%;
	margin: 0 auto;
	grid-template-columns: auto auto auto auto;
	grid-gap: 20px;
	background-color: #2196F3;
}

.grid-container > div {
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid black;
	text-align: center;
	font-size: 30px;
	width: 100%;

}
.grid-item{
	cursor: pointer;
}
	
</style>
</head>
<body>
	<div class="grid-container">
		<c:forEach items="${teacherList }" var="i">
			<div class="grid-item" onclick="location.href='teacherDetail.match?teacher_id=${i.teacher_id}'">
				<div><img src="${i.teacher_image_path }" width="100%" height="200"/></div>
				<div>${i.teacher_nickname }</div>
				<div class="left"> <i class="fas fa-graduation-cap"></i> ${i.teacher_univ } ${i.teacher_major }</div>
				<div class="left"> <i class="far fa-address-card"></i> ${i.teacher_univnum }</div>
				<div class="left"> <i class="fas fa-book"></i> ${i.teacher_subject }</div>
				<div class="left"> <i class="fas fa-comment-dollar"></i> ${i.teacher_worktime }시간 ${i.teacher_pay }만원</div>
				<div class="left"> <i class="fas fa-map-marker-alt"></i> ${i.teacher_addr }</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>