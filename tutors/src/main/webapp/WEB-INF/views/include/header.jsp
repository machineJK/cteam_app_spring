<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<header style='border-bottom:1px solid #ccc; padding:15px 0; text-align:left'>
	<div class='category' style='margin-left:100px'>
		<ul>
			<li><a href='<c:url value="/" />'><img src='images/weblogo.png' width="90px" height="90px"/><span style="font-size: 30px; font-weight: bold;"><img src='images/logo.png' width="210px" height="70px"/></span></a></li>
			<li><a class="${category eq 'match' ? 'active' : ''}" href='list.match'>과외매칭</a></li>
			<li><a class="${category eq 'chat' ? 'active' : ''}" href='list.chat'>채팅하기</a></li>
			<li><a class="${category eq 'no' ? 'active' : ''}" href='list.bo'>게시판</a></li>
			<%-- <li><a class="${category eq 'bo' ? 'active' : ''}" href='list.bo'>마이페이지</a></li> --%>
			<%-- <li><a class="${category eq 'da' ? 'active' : ''}" href='list.da'>공공데이터</a></li> --%>
		</ul>
	</div>
	
	<div style='position:absolute; right:0; top:50px; margin-right:100px'>
		<ul>
			<!-- 로그인하지 않은 경우 -->
			<c:if test='${empty loginInfo}'>
			<li><a class='btn-fill' href='login' style="font-family: 'S-CoreDream-4Regular';">로그인</a></li>
			<li><a class='btn-fill' href='member' style="font-family: 'S-CoreDream-4Regular';">회원가입</a></li>
			</c:if>
			<!-- 로그인한 경우 -->
			<c:if test='${!empty loginInfo and !empty loginInfo.name}'>
			<li style='padding-right:30px'>
			<a class="${category eq 'pro' ? 'active' : ''}" href='profile.pro?id=${loginInfo.id}' style="font-family: 'S-CoreDream-4Regular';">내 프로필</a></li>
			<li style='padding-right:20px'><strong style="font-family: 'S-CoreDream-4Regular';">&nbsp;&nbsp;&nbsp;&nbsp;${loginInfo.name}&nbsp;</strong>님</li>
			<li><a class='btn-fill' href='logout' style="font-family: 'S-CoreDream-4Regular';">로그아웃</a></li>
			</c:if>
			<c:if test='${!empty loginInfo and empty loginInfo.name}'>
			<li style='padding-right:10px'><strong style="font-family: 'S-CoreDream-4Regular';">${loginInfo.nickname}</strong>님</li>
			<li><a class='btn-fill' href='logout'>로그아웃</a></li>
			</c:if>

			</ul>
	</div>
</header>
<style>
@font-face {
     font-family: 'S-CoreDream-4Regular';
     src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-4Regular.woff') format('woff');
     font-weight: normal;
     font-style: normal;
}
@font-face {
    font-family: 'Cafe24Danjunghae';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.1/Cafe24Danjunghae.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
header {
	background-color: #c5cefa;
	
}
header ul, header ul li { 
	margin:0; padding:0; display:inline; }
.category { font-size:25px; font-family: 'Cafe24Danjunghae'; }
.category li:not(:first-child) { padding-left:60px; }
.category ul li:first-child{margin-right:100px;}
.category li a:not(:first-child):hover, .category li a.active { font-family: 'S-CoreDream-4Regular'; font-weight:bold; color:#0000cd; }
</style>