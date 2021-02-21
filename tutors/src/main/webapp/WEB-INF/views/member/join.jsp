<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table tr td { text-align:center; }
	input[name=addr] { width:calc(100% - 24px);  }
	.valid, .invalid{font-size: 13px; font-weight: bold;}
	.valid{color:green;}
	.invalid{color:red;}
	table, table tr td, table tr th {border:none;}
	input{border: none; border-bottom: 1px solid black; width: 400px;}
	/* input:focus {outline:none;} */ /* input태그를 눌렀을 때 나오는 테두리 없애기 */

</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>
<h3>회원가입</h3>

<form method="post" action="join" style="margin-bottom: 10px;">
<table class='w-pct50'>
<tr>
	<td><input type='text' name='name' placeholder="이름을 입력하세요"/></td>
</tr>
<tr>
	<td><input type='text' name='id' class="chk" placeholder="아이디를 입력하세요"/>
		<a class="btn-fill-s" id="btn-id">중복확인</a>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><input type='password' name='pw' class="chk" placeholder="비밀번호를 입력하세요"/><br>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><input type='password' name='pw_ck' class="chk" placeholder="비밀번호를 재입력해주세요"/><br>
		<div class="valid"></div>
	</td>
</tr>
<tr>
	<td><label><input type='radio' name='gender' value='남' />남</label>
		<label><input type='radio' name='gender' value='여' checked />여</label>
	</td>
</tr>
<tr>
	<td><input type='text' name='email' class="chk" placeholder="이메일을 입력해주세요"/><br>
		<div class="valid"></div>
	</td>
</tr>
<!-- 참고 -->
<tr>
	<td><input type='text' name='birth' placeholder="생일을 입력해주세요" />
		<span id="delete" style="color:red; position:relative; right:25px; cursor: pointer; display:none;">
		<i class="fas fa-times"></i></span></td>
</tr>
<tr>
	<td>
		<select name="addr1">
			<option value="광주">광주</option>
			<option value="부산">부산</option>
			<option value="대구">대구</option>
			<option value="인천">인천</option>
			<option value="울산">울산</option>
			<option value="서울">서울</option>
			<option value="대전">대전</option>
		</select>
		<select name="addr2">
			
		</select>
	</td>
</tr>

</table>

</form>

<a class="btn-fill" onclick="go_join()">회원가입</a>
<a class="btn-empty" href="<c:url value='/' />">취소</a>

<!-- datepicker jQueryUI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 다음 우편주소 사용 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="js/join_chk.js"></script>
<script type="text/javascript">
function go_join(){
	if($("[name=name]").val() == ""){
		alert("성명을 입력하세요!!!!");
		$("[name=name]").focus();
		return;
	}
	
	//중복확인 한 경우 : chked 클래스가 있음
	if($("[name=id]").hasClass("chked")){
		if($("[name=id]").siblings("div").hasClass("invalid")){
			alert("회원가입 불가!\n" + join.id.unusable.desc);
			$("[name=id]").focus();
			return;
		}
		
	}else{
		if(!item_check($("[name=id]"))) return;
		else{
			alert(join.id.valid.desc);
			$("[name=id]").focus();
			return;
		}
	}
	
	
	//중복확인 하지 않은 경우
	if(!item_check($("[name=pw]"))) return;
	if(!item_check($("[name=pw_ck]"))) return;
	if(!item_check($("[name=email]"))) return;
	
	$("form").submit();
}

function item_check(tag){
	var result = join.tag_status(tag);
	if(result.code == "invalid"){
		alert("회원가입 불가!\n" + result.desc);
		tag.focus();
		return false;
	}else{
		return true;
	}
}



$(function(){
	var today = new Date();
	var endDay = new Date( today.getFullYear()-13, today.getMonth(), today.getDate()-1 );
	console.log(endDay);
	
	$("[name=birth]").datepicker({
		dayNamesMin: ["일","월","화","수","목","금","토"],
		dateFormat : "yy.mm.dd",
		changeYear : true,
		changeMonth : true,
		showMonthAfterYear: true,
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		//beforeShowDay:after
		maxDate: endDay
	});
});


function id_check(){
	var $id = $('[name=id]');
	var data = join.tag_status($id);
	if(data.code == "invalid"){
		alert("중복확인 불필요\n" + data.desc);
		$id.focus();
		return;
	}
	
	$.ajax({
		type : "post",
		url : "id_check",
		data : {id : $id.val() },
		success : function(response){
			response = join.id_usable(response);
			
			$id.siblings("div").text(response.desc);
			$id.siblings("div").removeClass();
			$id.siblings("div").addClass(response.code);	
			$id.addClass("chked");
		},
		error : function(req,text){
			alert(text + " : " + req.status);
		}
		
	});
	
	
}


$("#btn-id").on("click",function(){
	id_check();
});

$(".chk").on('keyup', function(){
	validate($(this));
});

function validate(tag){
	var data = join.tag_status(tag);
	tag.siblings("div").text(data.desc);
	tag.siblings("div").removeClass();
	tag.siblings("div").addClass(data.code);
}

$(".chk").on("keyup",function(e){
	if($(this).attr("name")=="id"){
		if(e.keyCode==13){
			id_check();
			return;
		}else{
			$(this).removeClass("chked");
		}
	}
	validate($(this));
});



$("[name=birth]").change(function(){
	$("#delete").css("display","inline");
});

$("#delete").click(function(){
	$("[name=birth]").val('');
	$("#delete").css("display","none");
});

function after(date){
	if(date > new Date()){
		return [false];
	}else{
		return [true];
	}
}


</script>


</body>




</html>