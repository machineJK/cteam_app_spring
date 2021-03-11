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
	grid-template-columns: 300px 300px 300px 300px;
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
ul{
	padding:0;
	list-style: none;
}
.chked{
	background-color: #CCCCFF;
}

.search-container {
  display: grid;
  grid-template-columns: 220px 220px 220px 220px;
  grid-template-rows:120px 120px;
  background-color: #2196F3;
  text-align: center;
  width:880px;
  height:240px;
  margin: 0 auto;
}
.search-item {
  background-color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.8);
  padding: 20px;
  font-size: 29px;
  cursor: pointer;
}
.search-item:hover{  cursor: pointer;}
.modal > div:first-child{
	font-size: 2rem; 
	padding-left: 15px; 
	padding-top: 15px;	
	text-align: left;
}
#addr_modal{
	width: 800px;
	height: 600px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;
	display:none;
}
#addr1-grid-container{
	display: grid;
	grid-template-columns: 114px 114px 114px 114px 114px 114px 114px;
	grid-template-rows: 50px;
}
.addr1-item{
	font-size: 1.2rem;
	line-height: 50px;
}
#addr2-grid-container{
	display: grid;
	grid-template-columns: 110px 110px 110px 110px 110px 110px 110px;
	grid-template-rows: 50px 50px 50px;
	grid-gap:5px;
}
.addr2-item{
    line-height: 50px;
}
.addr1-item:hover, .addr2-item:hover, .validate:hover, .close:hover{
	background-color: #CCCCFF !important;
	cursor: pointer;
}
#addr_modal > .validate{
	font-size: 1.2rem;
	position: absolute;
    bottom: 2%;
    right: 19%;
	padding: 20px 40px;
	border: 1px solid gray;
	cursor: pointer;
}
#addr_modal > .close{
	font-size: 1.2rem;
	position: absolute;
    bottom: 2%;
    right: 2%;
	padding: 20px 40px;
	border: 1px solid gray;
	cursor: pointer;	
}
#gender_modal{
	width: 400px;
	height: 200px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;
	display:none;
}
#gender_modal > div:not(:first-child){
	font-size: 1.2rem;
    margin-bottom: 10px;
}
#gender_modal > div:not(:first-child):hover{
	background-color: #CCCCFF;
}
#subject_modal{
	width: 400px;
	height: 400px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;	
	display: none;
}
.subject-item{
	font-size: 1.2rem;
    padding: 20px;
}
.subject-item:hover{
	background-color: #CCCCFF;
}
#univNum_modal{
	width: 300px;
	height: 600px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;
	display:none;
}
#pay_modal{
	width: 300px;
	height: 500px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;	
	display:none;	
}
.pay-item{
	font-size: 1.2rem;
    padding: 17px;
}
.pay-item:hover{
	background-color: #CCCCFF;
}
#major_modal{
	width: 300px;
	height: 600px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;		
	display:none;
}
#univ_modal{
	width: 300px;
	height: 600px;
	position: fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	background-color: #FFFFFF;	
	display:none;	
}
.addr1{
	display: inline-block;
}
</style>
</head>
<body>

	<div class="listOption">
		<a class="btn-fill">선생님 찾기</a>
		<a class="btn-empty">학생 찾기</a>
	</div>
	
	<div class="search-container">
		<div class="search-item" id="addr"><i class="fas fa-map-marker-alt"></i><br><span>지역</span></div>
		<div class="search-item" id="gender"><i class="fas fa-venus-mars"></i><br><span>성별</span></div>
		<div class="search-item" id="subject"><i class="fas fa-book"></i><br><span>과목</span></div>  
		<div class="search-item" id="pay"><i class="fas fa-comment-dollar"></i><br><span>수업료</span></div>
<!-- 		<div class="search-item" id="univ"><i class="fas fa-university"></i><br><span>대학교</span></div>
		<div class="search-item" id="major"><i class="fas fa-book-open"></i><br><span>전공</span></div>  
		<div class="search-item" id="univNum"><i class="far fa-address-card"></i><br><span>학번</span></div> -->
	</div>
	
	<div id="addr_modal" class="modal">
		<div>지역 선택</div>
		<br>
		<div id="addr1-grid-container">
			<div class="addr1-item">광주</div>
			<div class="addr1-item">부산</div>
			<div class="addr1-item">대구</div>
			<div class="addr1-item">인천</div>
			<div class="addr1-item">울산</div>
			<div class="addr1-item">서울</div>
			<div class="addr1-item">대전</div>
		</div>
		<br><hr>
		<div id="addr2-grid-container">
			<div class="addr2-item">동구</div>
			<div class="addr2-item">서구</div>
			<div class="addr2-item">남구</div>
			<div class="addr2-item">북구</div>
			<div class="addr2-item">광산구</div>
		</div>
		<div class="validate">확인</div>
		<div class="close">닫기</div>
	</div>
	
	<div id="gender_modal" class="modal">
		<div>성별</div>
		<div class="gender-item">전체</div>
		<div class="gender-item">남자</div>
		<div class="gender-item">여자</div>
	</div>
	<div id="subject_modal" class="modal">
		<div>과목</div>
		<div class="subject-item">국어</div>
		<div class="subject-item">수학</div>
		<div class="subject-item">사회</div>
		<div class="subject-item">과학</div>
		<div class="subject-item">영어</div>
	</div>
	<div id="pay_modal" class="modal">
		<div>수업료</div>
		<div class="pay-item">80만원 이하</div>
		<div class="pay-item">70만원 이하</div>
		<div class="pay-item">60만원 이하</div>
		<div class="pay-item">50만원 이하</div>
		<div class="pay-item">40만원 이하</div>
		<div class="pay-item">30만원 이하</div>
		<div class="pay-item">20만원 이하</div>
	</div>
<!-- 	<div id="univ_modal" class="modal">
		대학교
	</div>
	<div id="major_modal" class="modal">
		전공
	</div>
	<div id="univNum_modal" class="modal">
		학번
	</div> -->
	
	<!-- 데이터 나열하는 곳 -->
	<div class="grid-container"></div>

	<div class="loading"><img src="images/loading.gif" /></div>
	<div id="more"><a onclick="more_list();" class="btn-empty">더보기</a></div>
	
<script type="text/javascript">
var addr1 = "", addr2 = "", gender = "", subject="", pay="";
var cnt = 0;
teacher_list();


//모달창 생성 및 없애기
$(".search-item").click(function(){
	$("body, header").css("backgroundColor","#999999");
	$(".modal").css("display","none");
	if($(this).attr("id") == "addr"){
		$("#addr_modal").css("display","block");
	}else if($(this).attr("id") == "gender"){
		$("#gender_modal").css("display","block");
	}else if($(this).attr("id") == "subject"){
		$("#subject_modal").css("display","block");
	}else if($(this).attr("id") == "univNum"){
		$("#univNum_modal").css("display","block");
	}else if($(this).attr("id") == "pay"){
		$("#pay_modal").css("display","block");
	}else if($(this).attr("id") == "major"){
		$("#major_modal").css("display","block");
	}else if($(this).attr("id") == "univ"){
		$("#univ_modal").css("display","block");
	}
	
});

//더보기
function more_list(){
	if($(".listOpion a").eq(0).has(".btn-fill")){
		teacher_list();
	}else if($(".listOpion a").eq(1).has(".btn-fill")){
		student_list();
	}
}

//모달창 닫기(확인 및 취소버튼 눌렀을 때 값 저장)
$(document).on("click",function(e){
	if($("#content").is(e.target)){
		$(".modal").css("display","none");
		$("body, header").css("backgroundColor","#FFFFFF");

		//alert("addr1 : " + addr1 + ",addr2 : " + addr2);
	}else if($("#addr_modal > .close").is(e.target)){
		$(".modal").css("display","none");
		$("body, header").css("backgroundColor","#FFFFFF");

		//alert("addr1 : " + addr1 + ",addr2 : " + addr2);
	}else if($("#addr_modal > .validate").is(e.target)){
		addr1 = $(".addr1-item.chked").text();
		addr2 = $(".addr2-item.chked").text();

		if((addr1 == "" && addr2 == "") || (addr1 == "" && addr2 != "") ){
			alert("지역을 선택해 주세요!");
			return;
		}
		
		$(".modal").css("display","none");
		$("body, header").css("backgroundColor","#FFFFFF");
		$("#addr > span").text(addr1 + " " + addr2).css("color","red");
		$(".grid-container").html("");
		cnt = 0;
		if($(".listOption > a").eq(0).hasClass("btn-fill")) teacher_list();
		if($(".listOption > a").eq(1).hasClass("btn-fill")) student_list();
			
		
		//alert("addr1 : " + addr1 + ",addr2 : " + addr2);	
	}
	 
})


//성별 모달창에서 값을 눌렀을 때 값 저장
$(".gender-item").click(function(){
	gender = $(this).text();
	$(".modal").css("display","none");
	$("body, header").css("backgroundColor","#FFFFFF");
	$("#gender > span").text(gender).css("color","red");
	$(".grid-container").html("");
	cnt = 0;
	if($(".listOption > a").eq(0).hasClass("btn-fill")) teacher_list();
	if($(".listOption > a").eq(1).hasClass("btn-fill")) student_list();
	//alert(gender);
});

//과목 모달창에서 값을 눌렀을 때 값 저장
$(".subject-item").click(function(){
	subject = $(this).text();
	$(".modal").css("display","none");
	$("body, header").css("backgroundColor","#FFFFFF");
	$("#subject > span").text(subject).css("color","red");
	$(".grid-container").html("");
	cnt = 0;
	if($(".listOption > a").eq(0).hasClass("btn-fill")) teacher_list();
	if($(".listOption > a").eq(1).hasClass("btn-fill")) student_list();
});

//수업료 모달창에서 값을 눌렀을 때 값 저장
$(".pay-item").click(function(){
	pay = $(this).text().substring(0,2);
	$(".modal").css("display","none");
	$("body, header").css("backgroundColor","#FFFFFF");
	$("#pay > span").text($(this).text()).css("color","red");
	$(".grid-container").html("");
	cnt = 0;
	if($(".listOption > a").eq(0).hasClass("btn-fill")) teacher_list();
	if($(".listOption > a").eq(1).hasClass("btn-fill")) student_list();
});



//선생님찾기, 학생찾기
$(".listOption > a").click(function(){
	$(".listOption > a").removeClass();
	$(".listOption > a").addClass("btn-empty");
	$(this).removeClass().addClass("btn-fill");

	$(".grid-container").html("");
	cnt = 0,addr1 = "", addr2 = "", gender = "", subject="", pay="";
	$("#addr > span").text("지역").css("color","black");
	$("#gender > span").text("성별").css("color","black");
	$("#subject > span").text("과목").css("color","black");
	$("#pay > span").text("수업료").css("color","black");

	var idx = $(this).index();
	if(idx == 0){
		teacher_list();
	}else{
		student_list();
	} 
});

//선생 더보기
function teacher_list(){
	$(".loading").attr("display","block");
	$("#pay").css("display","block");
	$.ajax({
		url:"data/teacher_list",
		data:{count : cnt, addr1 : addr1, addr2 : addr2, gender : gender, subject : subject, pay : pay},
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

//학생 더보기
function student_list(){
	$(".loading").attr("display","block");
	$("#pay").css("display","none");
	$.ajax({
		url:"data/student_list",
		data:{count : cnt, addr1 : addr1, addr2 : addr2, gender : gender, subject : subject},
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

//선생 상세정보 페이지 이동
function teacherDetail(teacher_id){
	location.href = "teacherDetail.match?teacher_id=" + teacher_id;
}

//학생 상세정보 페이지 이동
function studentDetail(student_id){
	location.href = "studentDetail.match?student_id=" + student_id;
}

//도시가 어디냐에 따라 구군이 달라짐(배경색, chked 클래스 toggle)
$("#addr1-grid-container > div").click(function(){
	var $addr1_divs = $("#addr1-grid-container > div");
	$addr1_divs .css("backgroundColor","#FFFFFF");
	
	if($(this).text() == "광주"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		$("#addr2-grid-container").html("");
		var tag = "<div class='addr2-item'>동구</div>"
				+ "<div class='addr2-item'>서구</div>"
				+ "<div class='addr2-item'>남구</div>"
				+ "<div class='addr2-item'>북구</div>"
				+ "<div class='addr2-item'>광산구</div>";
		$("#addr2-grid-container").html(tag);
	}else if($(this).text() == "부산"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		$("#addr2-grid-container").html("");
		var tag = "<div class='addr2-item'>중구</div>"
				+ "<div class='addr2-item'>서구</div>"
				+ "<div class='addr2-item'>동구</div>"
				+ "<div class='addr2-item'>영도구</div>"
				+ "<div class='addr2-item'>부산진구</div>"
				+ "<div class='addr2-item'>동래구</div>"
				+ "<div class='addr2-item'>남구</div>"
				+ "<div class='addr2-item'>북구</div>"
				+ "<div class='addr2-item'>강서구</div>"
				+ "<div class='addr2-item'>해운대구</div>"
				+ "<div class='addr2-item'>사하구</div>"
				+ "<div class='addr2-item'>금정구</div>"
				+ "<div class='addr2-item'>연제구</div>"
				+ "<div class='addr2-item'>수영구</div>"
				+ "<div class='addr2-item'>사상구</div>"
				+ "<div class='addr2-item'>기장군</div>";
		$("#addr2-grid-container").html(tag);
	}else if($(this).text() == "대구"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		$("#addr2-grid-container").html("");
		var tag = "<div class='addr2-item'>중구</div>"
				+ "<div class='addr2-item'>동구</div>"
				+ "<div class='addr2-item'>서구</div>"
				+ "<div class='addr2-item'>남구</div>"
				+ "<div class='addr2-item'>북구</div>"
				+ "<div class='addr2-item'>수성구</div>"
				+ "<div class='addr2-item'>달서구</div>"
				+ "<div class='addr2-item'>달성군</div>";
		$("#addr2-grid-container").html(tag);
	}else if($(this).text() == "인천"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		$("#addr2-grid-container").html("");
		var tag = "<div class='addr2-item'>중구</div>"
				+ "<div class='addr2-item'>동구</div>"
				+ "<div class='addr2-item'>미추홀구</div>"
				+ "<div class='addr2-item'>연수구</div>"
				+ "<div class='addr2-item'>남동구</div>"
				+ "<div class='addr2-item'>부평구</div>"
				+ "<div class='addr2-item'>계양구</div>"
				+ "<div class='addr2-item'>서구</div>"
				+ "<div class='addr2-item'>강화군</div>"
				+ "<div class='addr2-item'>옹진군</div>";
		$("#addr2-grid-container").html(tag);		
	}else if($(this).text() == "울산"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		var tag = "<div class='addr2-item'>중구</div>"
			+ "<div class='addr2-item'>남구</div>"
			+ "<div class='addr2-item'>동구</div>"
			+ "<div class='addr2-item'>북구</div>"
			+ "<div class='addr2-item'>울주군</div>";
		$("#addr2-grid-container").html(tag);	
	}else if($(this).text() == "서울"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		$("#addr2-grid-container").html("");
		var tag = "<div class='addr2-item'>종로구</div>"
				+ "<div class='addr2-item'>중구</div>"
				+ "<div class='addr2-item'>용산구</div>"
				+ "<div class='addr2-item'>성동구</div>"
				+ "<div class='addr2-item'>광진구</div>"
				+ "<div class='addr2-item'>동대문구</div>"
				+ "<div class='addr2-item'>중랑구</div>"
				+ "<div class='addr2-item'>성북구</div>"
				+ "<div class='addr2-item'>강북구</div>"
				+ "<div class='addr2-item'>도봉구</div>"
				+ "<div class='addr2-item'>노원구</div>"
				+ "<div class='addr2-item'>은평구</div>"
				+ "<div class='addr2-item'>서대문구</div>"
				+ "<div class='addr2-item'>마포구</div>"
				+ "<div class='addr2-item'>양천구</div>"
				+ "<div class='addr2-item'>강서구</div>"
				+ "<div class='addr2-item'>구로구</div>"
				+ "<div class='addr2-item'>금천구</div>"
				+ "<div class='addr2-item'>영등포구</div>"
				+ "<div class='addr2-item'>동작구</div>"
				+ "<div class='addr2-item'>관악구</div>"
				+ "<div class='addr2-item'>서초구</div>"
				+ "<div class='addr2-item'>강남구</div>"
				+ "<div class='addr2-item'>송파구</div>"
				+ "<div class='addr2-item'>강동구</div>";
		$("#addr2-grid-container").html(tag);
	}else if($(this).text() == "대전"){
		$(this).css("backgroundColor","#CCCCFF");
		$addr1_divs.removeClass("chked");
		$(this).addClass("chked");
		addr2 = "";
		var tag = "<div class='addr2-item'>동구</div>"
				+ "<div class='addr2-item'>중구</div>"
				+ "<div class='addr2-item'>서구</div>"
				+ "<div class='addr2-item'>유성구</div>"
				+ "<div class='addr2-item'>대덕구</div>";
		$("#addr2-grid-container").html(tag);	
	}
});	

//동적으로 생성된 태그에 이벤트 주기(클릭하면 배경색 바꾸고 chked 클래스 주기)
$(document).on("click",".addr2-item",function(){
	$(".addr2-item").css("backgroundColor","#FFFFFF").removeClass("chked");
	$(this).css("backgroundColor","#CCCCFF").addClass("chked");	
	addr2 = $(this).text();
});




</script>
</body>
</html>