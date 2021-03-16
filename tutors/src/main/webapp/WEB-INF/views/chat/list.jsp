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
			<input type="text" id="textBox1" autocomplete="off" />
			<input type="submit" value="보내기" id="send" />
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
			<input type="text" id="textBox2" autocomplete="off"/>
			<input type="submit" value="보내기" id="send"/>
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
	$('#chatStudent').css('height','0px');
	$('#chatTeacher').css('height','57%');
 	$('#chatListToTeacher').empty('div');
 	
 	
 	teacherId = $(this).attr('id');
 	/*
	console.log( chattingData );
	$.each(chattingData, function(key, value){
		console.log(value);
		
		$('#chatList').append(
			(value.nickname == $('#myNick').val() ?
				'<div style="text-align:right;"><h6><span style="display: inline-block;">' + value.date + ' <span style="background-color:#f8fc00; display:inline-block; max-width: 150px; min-width:50px; border-radius: 10px">' + value.msg + '</span></h6></div>' :		
				'<div style="text-align:left;"><h5>' + value.nickname + '<h5><h6><span style="background-color:#ffffff; display:inline-block; max-width: 150px; min-width:50px; border-radius: 10px">' + value.msg + '</span><span style="display: inline-block">' + value.date + '</span></h6></div>'
			)
		);
	}); */
	receiveMsgImStudent( teacherId );
}).on('click', '#studentList div', function(){
	$('#chatTeacher').css('height','0px');
	$('#chatStudent').css('height','57%');
	
 	$('#chatListToStudent').empty('div');
 
 	
 	studentId = $(this).attr('id');
 	
 	receiveMsgImTeacher( studentId );
})	
var receiveId = $('#receiveId').val();

//alert(receiveId);
if(receiveId != null){
	var targetId = receiveId;
	//alert(targetId);
 	setTimeout(function() {
 		$('#' + targetId).trigger('click');
	}, 1000); 
	
}
//$(document).on('click', receiveId);
window.onload = FetchAllData(); 
</script>

</body>
</html>