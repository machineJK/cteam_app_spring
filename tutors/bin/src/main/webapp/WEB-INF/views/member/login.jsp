<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
	position: absolute; left:50%;  top:50%;
	width: 380px; height:340px; 
	margin-left: -200px; margin-top:-300px;   
}
#login { width:100%; border:1px solid #ccc; }
#userid, #userpw { width:70%; height:45px; border-radius: 10px; outline: none;
	padding:5px 10%; margin-bottom:10px; border: 1px solid #ccc; font-size: 16px; }
.social img { width:254px; height:45px; margin: 5px; }
input{background-color: #FFFFFF;}
input:hover{background-color: #CCCCCC;}
input:focus{background-color: #FFFFFF;  outline: none;}
</style>
</head>
<body>

<div class='container'>
	<div style='height:100px'>
		<a href='<c:url value="/"/>'><img src='images/weblogo.png' width="50px" height="50px"/></a>
		<a href='<c:url value="/"/>'><img src='images/logo.png' width="150px" height="50px"/></a>
	</div>
	<div id='login' style="padding:30px;">
		<form method="post" action=''>
			<input type='text' id='userid' placeholder="아이디" /><br>
			<input type='password' id='userpw' placeholder="비밀번호"
					onkeypress="if( event.keyCode==13 ) go_login()"	 />
			<a onclick='go_login()' class='btn-fill' style='display:block; font-size: 20px; width: 110px;'>로그인</a>
		</form>
		<br>
		<!-- <hr style='width:69%; margin:25px auto'> -->
		<a class='social' href='naverlogin'><img src='images/naver_login.png' alt='네이버로그인' /></a><br>
		<a class='social' href='kakaologin'><img src='images/kakao_login.png' alt='카카오로그인' /></a><br><br>
		
		<div>아직 회원이 아니세요? <a href="member" style="color:blue;">회원가입</a> 하기</div>
		
	</div>
</div>

<script type="text/javascript">
function go_login(){
	if( $('#userid').val()=='' ){
		alert('아이디를 입력하세요!');
		$('#userid').focus();
		return;
	}else if( $('#userpw').val()=='' ){
		alert('비밀번호를 입력하세요!');
		$('#userpw').focus();
		return;
	}
	
	$.ajax({
		type: 'post',
		url: 'tutorlogin',
		data: { id:$('#userid').val(), pw:$('#userpw').val() },
		success: function( response ){
			if( response ){
				//목록을 제외한 화면과 회원가입화면은 홈으로 연결
				//그 외는 해당 화면
				location.href = ( document.referrer.match(/member/g)
								 || !document.referrer.match(/list/g) ) 
							? '<c:url value="/" />' : document.referrer;
			}else{
				alert('아이디나 비밀번호가 일치하지 않습니다!');
			}
		},error: function(req, text){
			alert(text + ':' + req.status);
		}
	});
	
}
</script>
</body>
</html>






