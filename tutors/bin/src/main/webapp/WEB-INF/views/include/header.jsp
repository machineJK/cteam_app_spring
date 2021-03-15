<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<header style='border-bottom:1px solid #ccc; padding:15px 0; text-align:left'>
<div>
	<div style="margin-left:5%;">
	<a href='<c:url value="/" />'>
	<img src='images/weblogo.png' width="90px" height="90px"/>
	<span><img src='images/logo.png' width="210px" height="70px"/></span></a>
		<ul id="nav-1">
			<li class="slide1"></li>         
    		<li class="slide2"></li>
			<li><a class="${category eq 'cu' ? 'active' : ''}" href='list.match'>과외매칭</a></li>
			<li><a class="${category eq 'chat' ? 'active' : ''}" href='list.chat'>채팅하기</a></li>
			<li><a class="${category eq 'no' ? 'active' : ''}" href='list.bo'>게시판</a></li>
			<%-- <li><a class="${category eq 'bo' ? 'active' : ''}" href='list.bo'>마이페이지</a></li> --%>
			<%-- <li><a class="${category eq 'da' ? 'active' : ''}" href='list.da'>공공데이터</a></li> --%>
		</ul>
	</div>
</div>

	

	
	<div style='position:absolute; right:50px; top:50px; margin-right:100px'>
		<ul>
			<!-- 로그인하지 않은 경우 -->
			<c:if test='${empty loginInfo}'>
			<li><a class='btn-fill' href='login' style="font-size: 18px; width: 80px;">로그인</a></li>
			<li><a class='btn-fill' href='member' style="font-size: 18px; width: 90px;">회원가입</a></li>
			</c:if>
			<!-- 로그인한 경우 -->
			<c:if test='${!empty loginInfo and !empty loginInfo.name}'>
			<li style='padding-right:10px'>
		
			<a class="${category eq 'pro' ? 'active' : ''}" href='profile.pro?id=${loginInfo.id}'>
			내 프로필</a></li>
			<%-- <img src="${loginInfo.dbimgpath}" class="profile_image" style="width: 50px; height: 50px; border-radius: 100px"> --%>
			<li style='padding-right:10px'><strong>&nbsp;&nbsp;${loginInfo.name}&nbsp;</strong>님</li>
			<li><a class='btn-fill' href='logout' style="font-size: 18px; width: 90px;">로그아웃</a></li>
			</c:if>
			<c:if test='${!empty loginInfo and empty loginInfo.name}'>
			<li style='padding-right:10px'><strong>${loginInfo.nickname}</strong>님</li>
			<li><a class='btn-fill' href='logout' style="font-size: 18px; width: 90px;">로그아웃</a></li>
			</c:if>

			</ul>
	</div>
</header>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script><script  src="js/script.js"></script>
<style>
header {
	/* background-color: #c5cefa; */
	/* background-color: rgba(230, 238, 249); */
	
	
}
header ul, header ul li { 
	margin:0; padding:0; display:inline; }
.category { font-size:25px; font-family: 'Cafe24Danjunghae';
  display: flex;
  align-items: center;
  justify-content: center; }
.category li:not(:first-child) { padding-left:60px; }
.category ul li:first-child{margin-right:100px;}
.category li a:not(:first-child):hover, .category li a.active { font-family: 'S-CoreDream-4Regular'; font-weight:bold; color:#0000cd; }
</style>




