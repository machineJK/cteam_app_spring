/**
 * 
 */
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
	
	function chatWithStudent(s_id, s_nickname, s_intro, myId){
		var msg = s_intro;
		var date = new Date();
		
		var hours = date.getHours();
		var minutes = date.getMinutes();
		var ampm = hours >= 12 ? '오후' : '오전';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'
		minutes = minutes < 10 ? "0" + minutes : minutes;
		var strTime = ampm + " " + hours + ":" + minutes;
		
		firebase.database().ref( myId + 1 ).child( s_id ).push().set({
			"nickname": s_nickname,
			"msg": msg,
			"date": strTime 
		});
		firebase.database().ref( s_id ).child( myId + 1 ).push().set({
			"nickname": s_nickname,
			"msg": msg,
			"date": strTime 
		});
	}
	
	function chatWithTeacher(t_id, t_nickname, t_intro, myId){
		var msg = "";
		if(t_intro == ""){
			msg = "안녕하세요" + t_nickname + "입니다. 어떤 상담을 원하시나요?";
		}else {
			msg = t_intro;
		}
		var date = new Date();
		
		var hours = date.getHours();
		var minutes = date.getMinutes();
		var ampm = hours >= 12 ? '오후' : '오전';
		hours = hours % 12;
		hours = hours ? hours : 12; // the hour '0' should be '12'
		minutes = minutes < 10 ? "0" + minutes : minutes;
		var strTime = ampm + " " + hours + ":" + minutes;
		
		firebase.database().ref( myId + 2 ).child( t_id ).push().set({
			"nickname": t_nickname,
			"msg": msg,
			"date": strTime 
		});
		firebase.database().ref( t_id ).child( myId + 2 ).push().set({
			"nickname": t_nickname,
			"msg": msg,
			"date": strTime 
		});
	}
	
	//매칭 요청하기
	function sendMatch(){
		
		studentId = $('#myId').val();
		//console.log(studentId);
		teacher_id = teacherId.substring(0,teacherId.length-1);
		//console.log(teacher_id);
		
		$.ajax({
			url: "student_match",
			data : {student_id : studentId, teacher_id : teacher_id},
			success: function(){
				alert("요청성공!");
			},
			error: function(req,text){
				alert(text + " : " + req.status);
			}
		});
		
						
		var myNick = document.getElementById('myNick').value;
		var msg = myNick + "님이 매칭을 요청하였습니다. My Info 화면에서 수락 또는 거절을 눌러주세요!";
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
		setTimeout(function() {
			$('#chatListToTeacher').scrollTop($('#chatListToTeacher')[0].scrollHeight);
		}, 300);
		
		//prevent form from submitting
		return false;
	}
	
	
	
	var teacherId;
	//message send to teacher
	function sendMsgToTeacher(){
		//msg 내용
		var myNick = document.getElementById('myNick').value;
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
		setTimeout(function() {
			$('#chatListToTeacher').scrollTop($('#chatListToTeacher')[0].scrollHeight);
		}, 300);
		
		//prevent form from submitting
		return false;
	}
	
	var studentId;
	//message send to student
	function sendMsgToStudent(){
		//msg 내용
		var myNick = document.getElementById('myNick').value;
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
		setTimeout(function() {
			$('#chatListToStudent').scrollTop($('#chatListToStudent')[0].scrollHeight);
		}, 500);
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
		
		//제이쿼리//
		/*$div = $("#teacherList");
		_teacherId = teacherId;
		var _teacher = "<div id='" + teacherId +"'>" + teacherName + "</div>";
		$div.append(_teacher);*/
		
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
		var myNick = document.getElementById('myNick').value;
		var teacher = firebase.database().ref(myId + 2).once('value', function(snapshot){
			snapshot.forEach(
				function(ChildSnapshot){
					teacherName = "";
					var teacherId = ChildSnapshot.key;		
					var teacherVO = ChildSnapshot.val();
					
 					//console.log(teacherVO);
					$.each(teacherVO, function(key, value){
						if( value.nickname != myNick ){
 							//console.log(value.nickname);
							teacherName = value.nickname;
						}
						if ( teacherName == ""){
							teacherName = "미응답 선생님";
							//console.log(teacherName);
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
					//console.log(studentVO);
					$.each(studentVO, function(key, value){
						if( value.nickname != myNick){
							studentName = value.nickname;
							//console.log(studentName);
							
						}
						if (studentName == ""){ 
							studentName = "미응답 학생";
						//	console.log(studentName);
						}
					});
					addStudentList(studentId, studentName);
 					//console.log(studentName);
					
				}		
			)
		});
		
}
