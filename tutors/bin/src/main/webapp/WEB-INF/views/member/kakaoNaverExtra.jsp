<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	input{border: none; width: 400px; font-size: 16px; height: 40px; border-radius: 15px; outline: none;}
	input:hover{background-color: #CCCCCC;}
	input:focus{background-color: #FFFFFF;  outline: none;}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
	<h3>추가적으로 정보를 작성해 주세요!</h3>
	<form action="insertKakaoNaverExtra" method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${loginInfo.id }"/>
		<input type="hidden" name="naver_login" value="${loginInfo.naver_login }"/>
		<input type="hidden" name="kakao_login" value="${loginInfo.kakao_login }"/>
		<input type="hidden" name="pw" value="social"/>
		지역 : 
		<select id="addr1" name="addr1" style="width: 100px; border-radius: 5px; outline: none;">
			<option value="광주">광주</option>
			<option value="부산">부산</option>
			<option value="대구">대구</option>
			<option value="인천">인천</option>
			<option value="울산">울산</option>
			<option value="서울">서울</option>
			<option value="대전">대전</option>
		</select>
		<select id="addr2" name="addr2" style="width: 100px; border-radius: 5px; outline: none;">
			<option value='동구'>동구</option>
			<option value='서구'>서구</option>
			<option value='북구'>북구</option>
			<option value='남구'>남구</option>
			<option value='광산구'>광산구</option>
		</select>
		
		<br>
		
		<input type='text' name='birth' placeholder="생일을 입력해주세요" readonly="readonly" style="margin-top: 100px; margin-bottom: 100px;"/>
		<span id="delete" style="color:red; position:relative; right:25px; cursor: pointer; display:none;">
		<i class="fas fa-times"></i></span>
		
		<br>
		
		<label>
		<span id="preview"><img src="images/blank-profile-picture.png" width="100" height="100"></span>
			<input type='file' name='file' id='attach-file' accept=".jpg, .jpeg, .png, .bmp"/>
			<i class="fas fa-images"></i>
		</label>
		<span id='file-name'></span>
		<span id='delete-file'><i class='fas fa-times'></i></span>	
	</form>
	<a class="btn-fill" onclick="goSubmit();" style="margin-top:100px;">가입하기</a>
	
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="js/file_check.js"></script>
<script type="text/javascript">
function goSubmit(){
	if($("[name=birth]").val() == ""){
		alert("생일을 입력해주세요!");
		return;
	}

	if($("[name=file]").val() == ""){
		alert("이미지를 올려주세요!");
		return;
	}

	$("form").submit();
}


//광역시가 어디냐에 따라 구군이 달라짐(#addr1,#addr2)
$("#addr1").change(function(){
	if($("#addr1 option:selected").val() == "광주"){
		var option2 = "<option value='동구'>동구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='광산구'>광산구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "부산"){
		var option2 = "<option value='부산진구'>부산진구</option>"
				    + "<option value='동래구'>동래구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='강서구'>강서구</option>"
				    + "<option value='해운대구'>해운대구</option>"
				    + "<option value='사하구'>사하구</option>"
				    + "<option value='금정구'>금정구</option>"
				    + "<option value='연제구'>연제구</option>"
				    + "<option value='수영구'>수영구</option>"
				    + "<option value='사상구'>사상구</option>"
				    + "<option value='기장군'>기장군</option>"
				    + "<option value='중구'>중구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='영도구'>영도구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "대구"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='수성구'>수성구</option>"
				    + "<option value='달서구'>달서구</option>"
				    + "<option value='달성군'>달성군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "인천"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='미추홀구'>미추홀구</option>"
				    + "<option value='연수구'>연수구</option>"
				    + "<option value='남동구'>남동구</option>"
				    + "<option value='부평구'>부평구</option>"
				    + "<option value='계양구'>계양구</option>"
				    + "<option value='서구'>서구</option>"
				    + "<option value='강화군'>강화군</option>"
				    + "<option value='옹진군'>옹진군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "울산"){
		var option2 = "<option value='중구'>중구</option>"
				    + "<option value='남구'>남구</option>"
				    + "<option value='북구'>북구</option>"
				    + "<option value='동구'>동구</option>"
				    + "<option value='울주군'>울주군</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "서울"){
		var option2 = "<option value='종로구'>종로구</option>"
				    + "<option value='중구'>중구</option>"
				    + "<option value='용산구'>용산구</option>"
				    + "<option value='성동구'>성동구</option>"
				    + "<option value='광진구'>광진구</option>"
				    + "<option value='동대문구'>동대문구</option>"
				    + "<option value='중랑구'>중랑구</option>"
				    + "<option value='성북구'>성북구</option>"
				    + "<option value='강북구'>강북구</option>"
				    + "<option value='도봉구'>도봉구</option>"
				    + "<option value='노원구'>노원구</option>"
				    + "<option value='은평구'>은평구</option>"
				    + "<option value='서대문구'>서대문구</option>"
				    + "<option value='마포구'>마포구</option>"
				    + "<option value='양천구'>양천구</option>"
				    + "<option value='강서구'>강서구</option>"
				    + "<option value='구로구'>구로구</option>"
				    + "<option value='금천구'>금천구</option>"
				    + "<option value='영등포구'>영등포구</option>"
				    + "<option value='동작구'>동작구</option>"
				    + "<option value='관악구'>관악구</option>"
				    + "<option value='서초구'>서초구</option>"
				    + "<option value='강남구'>강남구</option>"
				    + "<option value='송파구'>송파구</option>"
				    + "<option value='강동구'>강동구</option>";
		$("#addr2").html(option2);
	}
	if($("#addr1 option:selected").val() == "대전"){
		var option2 = "<option value='east'>동구</option>"
				    + "<option value='west'>중구</option>"
				    + "<option value='north'>서구</option>"
				    + "<option value='south'>유성구</option>"
				    + "<option value='gwangsan'>대덕구</option>";
		$("#addr2").html(option2);
	}
});

//datepicker
$(function(){
	var today = new Date();
	//var endDay = new Date( today.getFullYear()-15, today.getMonth(), today.getDate());
	//console.log(endDay);
	
	$("[name=birth]").datepicker({
		dayNamesMin: ["일","월","화","수","목","금","토"],
		dateFormat : "yy.mm.dd",
		changeYear : true,
		changeMonth : true,
		showMonthAfterYear: true,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		//beforeShowDay:after
		//maxDate: endDay
		yearRange: "" + (today.getFullYear()-60) +":" + (today.getFullYear()-7),
		maxDate: today.getFullYear()-7
	});
});

//name=birth에 change가 일어날 경우 X자 버튼 나오게 하기
$("[name=birth]").change(function(){
	$("#delete").css("display","inline");
});

//X자 버튼 클릭하면 사라지게 만들고 name=birth의 val을 빈공간으로 변경
$("#delete").click(function(){
	$("[name=birth]").val('');
	$("#delete").css("display","none");
});

</script>
</body>
</html>