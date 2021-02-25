<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h3>채팅채팅</h3>

</body>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/8.2.9/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script src="https://www.gstatic.com/firebasejs/8.2.9/firebase-analytics.js"></script>

<script>
  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  //파이어베이스 채팅
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
</script>
</html>