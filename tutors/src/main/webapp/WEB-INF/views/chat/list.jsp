<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅하기</title>
<style type="text/css">
*{
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}
#chat{
width: 85%;
height: 100%;
background-image: url("images/pc.png");
background-size: 100% 100%;
background-repeat: no-repeat;
background-position: center;
position: relative; top: 50%; left:5%;
 }
.textList{
	height: 90%;
}
.textContent {
	height: 10%;
}
.textList { overflow-y : auto;}
</style>
</head>
<body>
<div id="chat">
<h2 id="myChatList">나의 채팅목록</h2>
<input type="hidden" id="myId" value="${loginInfo.id}"/>
<input type="hidden" id="myNick" value="${loginInfo.name}"/>
<input type="hidden" id="receiveId" value="${receiveId}"/>
<br/>
<div>
<div id="box">
<div id="listBox">
<div id="teacherBox">
	<div><h2 style="margin-bottom: 2%;">선생님 목록</h2></div>
	<div id="teacherList">
		
	 </div>
</div>
<div id="studentBox">
	<div><h2 style="margin-bottom: 2%;">학생 목록</h2></div>
	<div id="studentList">
		
	</div>
</div>
</div>
<div id="chatTeacher">
	<div id="chatListToTeacher" class="textList"></div>
	<div class="textContent">
		<form onsubmit="return sendMsgToTeacher();" id="teachertxt">
			<input type="text" id="textBox1" autocomplete="off" class="chk" onkeypress="if(event.keyCode==13){return emptyCheck1();}"/>
			<input type="button" value="보내기" class="send" onclick="$('#teachertxt').submit();" />
			<input type="button" value="요청하기" class="send2"  onclick="sendMatch()"/>
		</form>
	</div>
</div>
<!-- 		<form onsubmit="return sendMsgToTeacher();" id="teachertxt">
			<input type="text" id="textBox1" autocomplete="off" />
			<input type="submit" value="보내기" id="send" />
		</form> -->

<div id="chatStudent">
	<div id="chatListToStudent" class="textList"></div>
	<div class="textContent">
		<form onsubmit="return sendMsgToStudent();" id="studenttxt">
			<input type="text" id="textBox2" autocomplete="off"  class="chk"  onkeypress="if(event.keyCode==13){return emptyCheck2();}"/>
			<input type="button" value="보내기" class="send"  onclick="$('#studenttxt').submit();"/>
		</form>
	</div>
</div>
<!-- 		<form onsubmit="return sendMsgToStudent();" id="studenttxt">
			<input type="text" id="textBox2" autocomplete="off"/>
			<input type="submit" value="보내기" id="send"/>
		</form> -->

</div>
</div>
</div>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-analytics.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.2.10/firebase-database.js"></script>
<script src="js/chat.js"></script>
<script id="MainScript">
//평소에는 안보이다가 list눌렀을때만 반응한다.
$(function(){
	$('#chatTeacher').css('height','0px');
	$('#chatStudent').css('height','0px');

});

$(document).on('click', '#teacherList div', function(){
 	$('#chatListToTeacher').empty('div');
	$('#chatStudent').css('height','0px');
 	
 	teacherId = $(this).attr('id');
 	
// 	var top = $('#chatListToTeacher').prop('scrollHeight');
// 	$('#chatListToTeacher').animate({scrollTop : top}, 5000);
	receiveMsgImStudent( teacherId );
	setTimeout(function() {
		$('#chatListToTeacher').scrollTop($('#chatListToTeacher')[0].scrollHeight);
		$('#chatTeacher').css('height','57%');
	}, 500);
	
}).on('click', '#studentList div', function(){
	$('#chatTeacher').css('height','0px');
	
 	$('#chatListToStudent').empty('div');

	setTimeout(function() {
		$('#chatListToStudent').scrollTop($('#chatListToStudent')[0].scrollHeight);
		$('#chatStudent').css('height','57%');
	}, 500);
 	
 	studentId = $(this).attr('id');
 	
 	receiveMsgImTeacher( studentId );
})	
var receiveId = $('#receiveId').val();



function emptyCheck1(){
	var ok = true;
	var val = $('#textBox1').val().trim().length;
	console.log(val);
	
	if( val == 0 ){
		$('#textBox1').focus();
		ok = false;
		return ok;
	}
	return ok;
}

function emptyCheck2(){
	var ok = true;
	var val = $('#textBox2').val().trim().length;
	console.log(val);
	
	if( val == 0 ){
		$('#textBox2').focus();
		ok = false;
		return ok;
	}
	return ok;
}

//alert(receiveId);
if(receiveId != null){
	var targetId = receiveId;
	//alert(targetId);
 	setTimeout(function() {
 		$('#'+targetId).trigger('click');
	}, 1000); 
	
}
//$(document).on('click', receiveId);
window.onload = FetchAllData(); 
</script>

</body>
</html>