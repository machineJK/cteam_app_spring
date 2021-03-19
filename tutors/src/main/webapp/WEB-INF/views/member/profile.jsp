<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.modi:hover{
		border: 1px solid black;
		padding: 5px;
		border-radius: 30px;
		background-color: #CCCCFF; 
	}
</style>
</head>
<body>

<h2>내 프로필</h2>
<div class=""><br/>



<br/>
</div>
<div class="title_image">
	<img src="${vo.dbimgpath}" class="profile_image" style="width: 200px; height: 200px; border-radius: 100px">
</div>
 <br>
	<%-- <a href="update/${vo.id}"><i class="far fa-image"></i></a><br> --%>
	
	
	<a class="modi" href="modify.pro?id=${vo.id}">프로필 수정하기</a><br><br>
<form method="post" action="profile.pro">
<table class="w-pct20 prot" >
<tr>
	<td class="w-pct40 prot" colspan="2">이름</td>
	<td class="prot" colspan="2">${vo.name}</td>
</tr>
<tr>
	
	<td class="prot" colspan="2">닉네임</td>
	<td class="prot" colspan="2">${vo.nickname}</td>
</tr>
<tr>

	<td class="prot" colspan="2">이메일</td>
	<td class="prot" colspan="2">${vo.email}</td>
</tr>
<tr>
	<td class="prot" colspan="2">성별</td>
	<td class="prot" colspan="2">${vo.gender}</td>
</tr>
<tr>
	<td class="prot" colspan="2">과외지역</td>
	<td class="prot" colspan="2">${vo.addr1} ${vo.addr2}</td>
</tr>
</table>
<h3>매칭된 사람</h3>
<p>닉네임을 클릭하면 정보를 볼 수 있습니다.</p>
<table class="w-pct30">
<c:forEach items="${profile}" var="vo">
<tr>
	<td class="w-pct30" colspan="2">닉네임</td>
	<td class="" colspan="2"><a href='detail.pro?id='></a></td>
</tr>

</c:forEach>
</table>
</form>
<script type="text/javascript" src="js/file_check.js"></script>

</body>
</html>