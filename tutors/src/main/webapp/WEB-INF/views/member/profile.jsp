<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3>내 프로필</h3>
<div class=""><br/>

		<a class="" href="modify.pro?id=${vo.id}">프로필 수정하기</a><br/>

<br/>
</div>
<div>
<img src="${vo.dbimgpath}">
</div>
<form method="post" action="profile.pro">
<table class="w-pct40">
<tr>
	<td class="w-pct40" colspan="2">이름</td>
	<td class="" colspan="2">${vo.name}</td>
</tr>
<tr>
	
	<td class="" colspan="2">닉네임</td>
	<td class="" colspan="2">${vo.nickname}</td>
</tr>
<tr>

	<td class="" colspan="2">이메일</td>
	<td class="" colspan="2">${vo.email}</td>
</tr>
<tr>
	<td class="" colspan="2">성별</td>
	<td class="" colspan="2">${vo.gender}</td>
</tr>
<tr>
	<td class="" colspan="2">과외지역</td>
	<td class="" colspan="2">${vo.addr1} ${vo.addr2}</td>
</tr>

<!-- <tr>
	
	<td class="" colspan="4">과외정보</td>
</tr>
<tr>
	

	<td class="" colspan="2">학교</td>
	<td class=""></td>
</tr>
	<tr>
	

	<td class="" colspan="2">과목</td>
	<td class=""></td>
</tr>
<tr>
	
	
	<td class="" colspan="2">과외지역</td>
	<td class=""></td>
</tr> -->
<!-- <tr>
	<td colspan="5">
	<hr style="background-color: lightgray; height: 0.5px; border: thin"></td>
</tr> -->
</table>
</form>

</body>
</html>