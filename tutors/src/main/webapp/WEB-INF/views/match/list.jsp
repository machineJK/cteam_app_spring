<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.grid-container {
	display: grid;
	width: 1268px;
	margin: 0 auto;
	grid-template-columns: auto auto auto auto;
	grid-gap: 20px;
	/* background-color: #2196F3; */
	margin-top: 30px;
}

.grid-container > div {
	/* background-color: rgba(255, 255, 255, 0.8); */
	border: 1px solid black;
	text-align: center;
	font-size: 30px;
}

.grid-item{
	cursor: pointer;
}

.loading{
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%,-50%);
	display: none;
}

#more{
	margin-top: 50px;
    margin-bottom: 35px;
}
a{
	display: inline;
	text-decoration: none;
}
	
</style>
</head>
<body>

	<div class="listOption">
		<a class="btn-fill">선생님 찾기</a>
		<a class="btn-empty">학생 찾기</a>
	</div>
	<div class="grid-container">
		
	</div>
	<div class="loading"><img src="images/loading.gif" /></div>
	<div id="more"><a onclick="more_list();" class="btn-empty">더보기</a></div>
	
<script type="text/javascript">
var cnt = 0;
teacher_list();

function more_list(){
	if($(".listOpion a").eq(0).has(".btn-fill")){
		teacher_list();
	}else if($(".listOpion a").eq(1).has(".btn-fill")){
		student_list();
	}
}

$(".listOption > a").click(function(){
	$(".listOption > a").removeClass();
	$(".listOption > a").addClass("btn-empty");
	$(this).removeClass().addClass("btn-fill");
	var idx = $(this).index();
	if(idx == 0){
		$(".grid-container").html("");
		cnt = 0;
		teacher_list();
	}else{
		$(".grid-container").html("");
		cnt = 0;
		student_list();
	} 
});

function teacher_list(){
	$(".loading").attr("display","block");
	$.ajax({
		url:"data/teacher_list",
		data:{count : cnt},
		success:function(response){
			//$(".grid-container").html("");
			//console.log("teacher_list : " + cnt);
			//console.log(response);
			for(let i=0; i< response.length; i++){
				var tag = "";
				tag += "<div class='grid-item' onclick='teacherDetail(\"" + response[i].teacher_id + "\")'>"
					+  "<div><img src='" + response[i].teacher_image_path + "' width='300' height='200'/></div>"
					+  "<div>" + response[i].teacher_nickname + "</div>"
					+  "<div class='left'> <i class='fas fa-graduation-cap'></i> " + response[i].teacher_univ + " " + response[i].teacher_major + "</div>"
					+  "<div class='left'> <i class='far fa-address-card'></i> " + response[i].teacher_univnum + "</div>"
					+  "<div class='left'> <i class='fas fa-book'></i> " + response[i].teacher_subject + "</div>"
					+  "<div class='left'> <i class='fas fa-comment-dollar'></i> " + response[i].teacher_worktime + "주 " + response[i].teacher_pay + "만원</div>"
					+  "<div class='left'> <i class='fas fa-map-marker-alt'></i> " + response[i].teacher_addr + "</div>"
					+  "</div>";
				$(".grid-container").append(tag);
			}
			$(".loading").attr("display","none");
			cnt += 1;
		},
		error:function(req,text){
			alert(text + " : " + req.status);
		}
	});
}

function student_list(){
	$(".loading").attr("display","block");
	$.ajax({
		url:"data/student_list",
		data:{count : cnt},
		success:function(response){
			//console.log(response.length);
			//$(".grid-container").html("");
			for(let i=0; i< response.length; i++){
				var tag = "";
				tag += "<div class='grid-item' onclick='studentDetail(\"" + response[i].student_id + "\")'>"
					+  "<div><img src='" + response[i].student_image_path + "' width='300' height='200'/></div>"
					+  "<div>" + response[i].student_nickname + "</div>"
					+  "<div class='left'> <i class='fas fa-graduation-cap'></i> " + response[i].student_grade + "</div>"
					+  "<div class='left'> <i class='fas fa-book'></i> " + response[i].student_subject + "</div>"
					+  "<div class='left'> <i class='fas fa-map-marker-alt'></i> " + response[i].student_addr + "</div>"
					+  "</div>";
				$(".grid-container").append(tag);
			}
			$(".loading").attr("display","none");
			cnt += 1;
			
		},
		error:function(req,text){
			alert(text + " : " + req.status);
		}
	});
}

function teacherDetail(teacher_id){
	location.href = "teacherDetail.match?teacher_id=" + teacher_id;
}

function studentDetail(student_id){
	location.href = "studentDetail.match?student_id=" + student_id;
}
</script>
</body>
</html>