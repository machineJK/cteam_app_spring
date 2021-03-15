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

</style>
</head>
<body>
<div id="chat">
<h2 id="myChatList">나의 채팅목록</h2>
<input type="hidden" id="myId" value="${loginInfo.id}"/>
<input type="hidden" id="myNick" value="${loginInfo.name}"/>
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
	<div id="chatListToTeacher"></div>
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
	<div id="chatListToStudent"></div>
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

<script id="MainScript">
	// Your web app's Firebase configuration
	// For Firebase JS SDK v7.20.0 and later, measurementId is optional
	var firebaseConfig = {
	  apiKey: "AIzaSyC35KuZ6ztn9THDgLdIQsW7oF7nUafhvVU",
	  authDomain: "myproject-4683c.firebaseapp.com",
	  databaseURL: "https://myproject-4683c-default-rtdb.firebaseio.com",
	  projectId: "myproject-4683c",
	  storageBucket: "myproject-4683c.appspot.com",
	  messagingSenderId: "404974216941",
	  appId: "1:404974216941:web:5aab0f08914f5638800ee4",
	  measurementId: "G-NWTCJ911QT"
	};
	// Initialize Firebase
	firebase.initializeApp(firebaseConfig);
	firebase.analytics();
	
	var myId = document.getElementById("myId").value;
	
	var teacherId;
	//message send to teacher
	function sendMsgToTeacher(){
		//msg 내용
		var msg = document.getElementById("textBox1").value;
		var date = new Date();

		var hours = date.getHours();
		var minutes = date.getMinutes();
		var ampm = hours >= 12 ? '오후' : '오전';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'
		minutes = minutes < 10 ? "0" + minutes : minutes;
		var strTime = ampm + " " + hours + ":" + minutes;
		
		//save in database
		firebase.database().ref( myId + 2 ).child( teacherId ).push().set({
			"nickname": myNick,
			"msg": msg,
			"date": strTime 
		});
		firebase.database().ref( teacherId ).child( myId + 2 ).push().set({
			"nickname": myNick,
			"msg": msg,
			"date": strTime 
		});
		
		$('#textBox1').val('');
		
		//prevent form from submitting
		return false;
	}
	
	var studentId;
	var myNick = document.getElementById('myNick').value;
	//message send to student
	function sendMsgToStudent(){
		//msg 내용
		var msg = document.getElementById("textBox2").value;
		var date = new Date();

		var hours = date.getHours();
		var minutes = date.getMinutes();
		var ampm = hours >= 12 ? '오후' : '오전';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'
		minutes = minutes < 10 ? "0" + minutes : minutes;
		var strTime = ampm + " " + hours + ":" + minutes;
		
		//save in database
		firebase.database().ref( myId + 1 ).child( studentId ).push().set({
			"nickname": myNick,
			"msg": msg,
			"date": strTime 
		});
		firebase.database().ref( studentId ).child( myId + 1 ).push().set({
			"nickname": myNick,
			"msg": msg,
			"date": strTime 
		});
		
		$('#textBox2').val('');
		
		//prevent form from submitting
		return false;
	}
	
	//메세지 받아오기
	function receiveMsgImStudent( teacherId ){
		firebase.database().ref( myId + 2).child( teacherId ).on('child_added', function(snapshot){
			var html = 
				(snapshot.val().nickname == $('#myNick').val() ? 
					'<div style="text-align:right;"><h6><span style="display: inline-block; color:white; margin-bottom:3px; font-size: 12px;">'
						+ snapshot.val().date + 
						' <span style="background-color:#f8fc00; color: black; display:inline-block; max-width: 200px; min-width:50px; border-radius: 10px; margin: 5px 0px; font-size:20px; padding: 10px;">'
						+ snapshot.val().msg + '</span></h6></div>' :		
					'<div style="text-align:left;"><h5 style="color:white; margin-bottom:3px;">' + snapshot.val().nickname + '<h5>'
					+ '<h6><span style="background-color:#ffffff; display:inline-block; max-width: 200px; min-width:50px; border-radius: 10px; margin-bottom:5px; font-size:20px; padding: 10px;">'
					+ snapshot.val().msg + '</span><span style="display: inline-block; color:white; margin-left:5px;">' + snapshot.val().date + '</span></h6></div>');
			$('#chatListToTeacher').append(html);
			
		});
	}
	//메세지 받아오기
	function receiveMsgImTeacher( studentId ){
		firebase.database().ref( myId + 1).child( studentId ).on('child_added', function(snapshot){
			var html = 
				(snapshot.val().nickname == $('#myNick').val() ? 
					'<div style="text-align:right;"><h6><span style="display: inline-block; color:white; margin-bottom:3px; font-size: 12px;">'
						+ snapshot.val().date + ' <span style="background-color:#f8fc00; display:inline-block; max-width: 200px; min-width:50px; border-radius: 10px; margin: 5px 0px; font-size:20px; padding: 10px; color:black;">'
						+ snapshot.val().msg + '</span></h6></div>' :		
					'<div style="text-align:left;"><h5 style="color:white; margin-bottom:3px;">' + snapshot.val().nickname + '<h5>'
					+ '<h6><span style="background-color:#ffffff; margin-bottom:5px; border-radius: 10px; display:inline-block; max-width: 150px; min-width:50px; border-radius: 10px margin: 5px 0px; font-size:20px; padding: 10px;">'
					+ snapshot.val().msg + '</span><span style="display: inline-block; color:white; margin-left:5px;">' + snapshot.val().date + '</span></h6></div>');
			$('#chatListToStudent').append(html);
			
		});
	}
	
	//teacherList
	function addTeacherList(teacherId, teacherName){
		var div = document.getElementById("teacherList");
		_teacherId = teacherId;
		
		var _teacher = document.createElement("div");
		_teacher.id = teacherId;

		_teacher.innerHTML = teacherName;
		div.appendChild(_teacher);
	}
	//studentList
	function addStudentList(studentId, studentName){
		var div = document.getElementById("studentList");
		_studentId = studentId;
		
		var _student = document.createElement("div");
		_student.id = _studentId;
		
		_student.innerHTML = studentName;
		div.appendChild( _student );
	}
	
	var teacherName;
	var studentName;
	function FetchAllData(){
		var teacher = firebase.database().ref(myId + 2).once('value', function(snapshot){
			snapshot.forEach(
				function(ChildSnapshot){
					teacherName = "";
					var teacherId = ChildSnapshot.key;		
					var teacherVO = ChildSnapshot.val();
// 					console.log(teacherVO);
					$.each(teacherVO, function(key, value){
						if( value.nickname != myNick ){
// 							console.log(value.nickname);
							teacherName = value.nickname;
						}
					});
					addTeacherList( teacherId, teacherName );
				}
			)			
		});			
		var student = firebase.database().ref(myId + 1).once('value', function(snapshot){
			snapshot.forEach(
				function(ChildSnapshot){
					studentName = "";	
					var studentId = ChildSnapshot.key;
					var studentVO = ChildSnapshot.val();
					console.log(studentVO);
					$.each(studentVO, function(key, value){
						if( value.nickname != myNick){
							studentName = value.nickname;
							console.log(studentName);
						}
						if (studentName == ""){ 
							studentName = "응답하지 않은 학생";
							console.log(studentName);
						}
					});
// 					console.log(studentName);
					addStudentList(studentId, studentName );
				}		
			)
		});
	} 
	


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
});	

window.onload = FetchAllData(); 
</script>

</body>
</html>