<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<title>채팅하기</title>
</head>
<body>
<h3>채팅채팅</h3>
	Name <input id="namebox" type="text" /> <br><br/>
	Roll No <input id="rollbox" type="text" /> <br><br/>
	Section <input id="secbox" type="text" /> <br><br/>
	Gender <input id="genbox" type="text" /> <br><br/>
	<br><br/>
	<button id="insert">Insert</button>
	<button id="select">Select</button>
	<button id="update">Update</button>
	<button id="delete">Delete</button>

	<ul id="list">
	</ul>


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
	
	
	//Ready
	var nameV, rollV, secV, genV;
	function Ready(){
		nameV = document.getElementById('namebox').value;
		rollV = document.getElementById('rollbox').value;
		secV = document.getElementById('secbox').value;
		genV = document.getElementById('genbox').value;
		
	}
	
	//Insert
	document.getElementById('insert').onclick = function(){
		Ready();
		firebase.database().ref('student/' + rollV).set({
			NameOfStudent: nameV,
			RollNo: rollV,
			Section: secV,
			Gender: genV
		});
	}
	
	//Select(검색기능 비슷 누르면 다른 조건들 가져옴)
	document.getElementById('select').onclick = function(){
		Ready();
		firebase.database().ref('student/' + rollV).on('value', function(snapshot){
			document.getElementById('namebox').value = snapshot.val().NameOfStudent;			
			document.getElementById('rollbox').value = snapshot.val().RollNo;			
			document.getElementById('secbox').value = snapshot.val().Section;
			document.getElementById('genbox').value = snapshot.val().Gender;
		});
	}
	
	//Update
	document.getElementById('update').onclick = function(){
		Ready();
		firebase.database().ref('student/' + rollV).set({
			NameOfStudent: nameV,
			RollNo: rollV,
			Section: secV,
			Gender: genV
		});		
	}
	
	//Delete
	document.getElementById('delete').onclick = function(){
		Ready();
		firebase.database().ref('student/' + rollV).remove();
	}
	
	var stdNo = 0;
	
	function addItemsToList(name, rollNo, sec, gen){
		var ul = document.getElementById("list");
		var header = document.createElement("h2");
		
		
		var _name = document.createElement('li');
		var _rollNo = document.createElement('li');
		var _sec = document.createElement('li');
		var _gen = document.createElement('li');
		
		header.innerHTML = 'Student : ' + (++stdNo);
		
		_name.innerHTML = 'Name : ' + name;
		_rollNo.innerHTML = 'RollNo : ' + rollNo;
		_sec.innerHTML = 'Section : ' + sec;
		_gen.innerHTML = 'Gender : ' + gen;
			
		ul.appendChild(header);
		ul.appendChild(_name);
		ul.appendChild(_rollNo);
		ul.appendChild(_sec);
		ul.appendChild(_gen);
		
	}
	
	function FetchAllData(){
		firebase.database().ref('student').once('value', function(snapshot){
			snapshot.forEach(
				function (ChildSnapshot){
					let name = ChildSnapshot.val().NameOfStudent;
					let rollNo = ChildSnapshot.val().RollNo;
					let sec = ChildSnapshot.val().Section;
					let gen = ChildSnapshot.val().Gender;
					addItemsToList(name, rollNo, sec, gen);
				}		
			)
		});
	}
	
	window.onload = FetchAllData();
</script>

</body>
</html>