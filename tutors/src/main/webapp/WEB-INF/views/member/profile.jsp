<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.modi:hover{
		border: 1px solid black;
		padding: 5px;
		border-radius: 30px;
		background-color: #CCCCFF; 
	}
	.wantmatchparent{
		border:1px solid black; 
		border-radius: 30px; 
		width:300px;
		margin:0 auto; 
		margin-bottom: 5px;
	}
	.wantmatchstyle{
		width: 200px;
		margin: 0 auto;
		text-align: left;
	}
	.check{
		color: green;
	}
	.close{
		color: red;	
		margin-left: 10px;
	}
	.wantmatchstyle, .check, .close{
		display: inline-block;
		font-size: 1.1rem;
	}
	.wantmatchstyle:hover, .check:hover, .close:hover{
		cursor: pointer;
	}
	.matchedStyle{
		display:inline-block;
		width: 150px;
		font-size: 1.1rem;
	}
	.matchedStyle:hover{
		cursor: pointer;
		background-color: #CCCCFF;
	}
	.matchedStyleLine{
		display:inline-block;
		width: 50px;
	}
	.matchedparent{
		display: inline-block;
		border: 1px solid black;
		width: 210px;
		margin-bottom: 5px;
		font-size: 1.1rem;
	}
	.wantmatch{
		display:inline-block;
		width: 200px;
		border: 1px solid black;
	}
	.wantmatchts{
		display: inline-block;
		width: 145px;
		border: 1px solid black;
	}
	.wantmatchts:not(:first-child){
		margin-left: 5px;
	}
	table{
		width: 50%;
	}
</style>
</head>
<body>

<h2>내 프로필</h2>
<div class=""><br/>



<br/>
</div>
<div class="title_image">
	<img src="${vo.dbimgpath}" class="profile_image" style="width: 200px; height: 200px; border-radius: 100px">
</div>
 <br>
	<%-- <a href="update/${vo.id}"><i class="far fa-image"></i></a><br> --%>
	
	
	<a class="modi" href="modify.pro?id=${vo.id}">프로필 수정하기</a><br><br>
<form method="post" action="profile.pro">
<table class="w-pct20 prot" >
<tr>
	<td class="w-pct40 prot" colspan="2">이름</td>
	<td class="prot" colspan="2">${vo.name}</td>
</tr>
<tr>
	
	<td class="prot" colspan="2">닉네임</td>
	<td class="prot" colspan="2">${vo.nickname}</td>
</tr>
<tr>

	<td class="prot" colspan="2">이메일</td>
	<td class="prot" colspan="2">${vo.email}</td>
</tr>
<tr>
	<td class="prot" colspan="2">성별</td>
	<td class="prot" colspan="2">${vo.gender}</td>
</tr>
<tr>
	<td class="prot" colspan="2">과외지역</td>
	<td class="prot" colspan="2">${vo.addr1} ${vo.addr2}</td>
</tr>
</table>
<table class="w-pct30">
<c:forEach items="${profile}" var="vo">
<tr>
	<td class="w-pct30" colspan="2">닉네임</td>
	<td class="" colspan="2"><a href='detail.pro?id='></a></td>
</tr>

</c:forEach>
</table>
</form>

<div>
	<c:if test='${loginInfo.id ne "admin" }'>
		<h3>매칭을 요청한 학생</h3>
		<c:forEach var="vo" items="${wantmatchstudent }">
			<div class="wantmatchparent">
				<div class="wantmatchstyle" onclick="location.href='studentDetail.match?student_id=${vo.student_id}'">${vo.student_nickname }</div>
				<div class="check" onclick="checkMatch('${vo.teacher_id}','${vo.student_id}');"><i class="fas fa-check"></i></div>
				<div class="close" onclick="closeMatch('${vo.teacher_id}','${vo.student_id}');"><i class="fas fa-times"></i></div>
			</div>
		</c:forEach>
		
		<br>
		
		<h3>매칭된 리스트</h3>
		<div class="matchedparent">선생</div><div class="matchedparent">학생</div>
		<c:forEach items="${allmatch }" var="vo">
			<div style="margin-bottom: 5px;">
				<div class="matchedStyle" onclick="location.href='teacherDetail.match?teacher_id=${vo.teacher_id}'">${vo.teacher_nickname }</div> 
				<div class="matchedStyleLine">----</div>
				<div class="matchedStyle" onclick="location.href='studentDetail.match?student_id=${vo.student_id}'">${vo.student_nickname }</div>
			</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${loginInfo.id eq 'admin' }">
		<h3>매칭 요청 리스트</h3>
		<table>
			<tr>
				<td style="font-weight: bold;">선생</td>
				<td style="font-weight: bold;">학생</td>
				<td></td>
				<td></td>
			</tr>
		<c:forEach items="${wantmatchadmin }" var="vo">
			<tr>
				<td>${vo.teacher_nickname }</td>
				<td>${vo.student_nickname }</td>
				<td class="check" onclick="checktsMatch('${vo.teacher_id}','${vo.student_id }')"><span><i class="fas fa-check"></i></span></td>
				<td class="close" onclick="closetsMatch('${vo.teacher_id}','${vo.student_id }')"><span><i class="fas fa-times"></i></span></td>
			</tr>
		</c:forEach>
		</table>
	</c:if>
	
</div>

<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript">
function checkMatch(teacher_id,student_id){
	$.ajax({
		url: "teacherCheck.match",
		data: {teacher_id:teacher_id, student_id:student_id },
		success: function(){
			location.reload();
		},
		error: function(req,text){
			alert(text + " : " + req.status);
		}
	});
	
}

function closeMatch(teacher_id,student_id){
	$.ajax({
		url: "teacherClose.match",
		data: {teacher_id:teacher_id, student_id:student_id },
		success: function(){
			location.reload();
		},
		error: function(req,text){
			alert(text + " : " + req.status);
		}
	});	
}

function checktsMatch(teacher_id, student_id){
	$.ajax({
		url: "adminCheck.match",
		data: {teacher_id:teacher_id, student_id:student_id },
		success: function(){
			location.reload();
		},
		error: function(req,text){
			alert(text + " : " + req.status);
		}
	});
}

function closetsMatch(teacher_id, student_id){
	$.ajax({
		url: "adminClose.match",
		data: {teacher_id:teacher_id, student_id:student_id },
		success: function(){
			location.reload();
		},
		error: function(req,text){
			alert(text + " : " + req.status);
		}
	});
}
</script>
</body>
</html>