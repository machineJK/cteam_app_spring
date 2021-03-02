<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>게시판</h3>
	 <form method="post" action="list.bo"></form>
	 <div id="list-top">
	 	<div>
	 		<ul>
 				<c:if test="${loginInfo.id eq 'admin' }">
		 			<li>
		 				<a class="btn-fill" href="new.bo">글쓰기</a>
		 			</li>
 				</c:if>
	 		</ul>
	 	</div>
	 </div>
</body>
</html>