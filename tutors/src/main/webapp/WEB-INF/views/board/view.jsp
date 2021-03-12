<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#frame {margin: 0 auto; width: 55%;}
.top { margin-top: 70px;}
._content { 
	width: 100%;
	font-size: 18px;
}
.lineNo {
 	border: 0px;
 	border-top: 1px;
 	padding: 2px;
    padding-right: 5px;
}
.lineNo2 {
	border: 1px solid;
	margin-bottom: 20px;
}
.c_detail {
	height: 100px;
	padding: 22px 30px;;
	width: 20%;
}

.pic_size { width: 100%; margin: 0px;}
.noti_right {float: right; line-height: 50px; margin-right: 5px}
</style>
</head>
<body>
	<div id="frame">
		<div class="top">
			<!-- 로그인한 이용자가 글작성자 정보와 일치하면 수정/삭제하기 버튼 보임 -->
				<div class="right noti_right">
				<a class='btn-fill' href='list.bo?curPage=${page.curPage}&search=${page.search}&keyword=${page.keyword}'>목록으로</a>
					<c:if test="${!empty loginInfo }">
						<c:if test="${loginInfo.id eq vo.board_id }">
							<a class="btn-fill" onclick="$('#modify').submit();">수정하기</a>
							<a class="btn-fill" onclick="if( confirm('정말 삭제?') ){ location='delete.bo?board_num=${vo.board_num}' }">삭제하기</a>
						</c:if>
					</c:if>
				</div>
				<form id="modify" action="modify.bo">
					<input type="hidden" name="id" value="${vo.board_num }"/>
				</form>
				
			<table class="_content">
			 	<tr class="left divi">
			 		<th class="w-px60 lineNo" rowspan="2" ><img src="${vo.id_image_path }" class="pic_size"></th>
			 		<td class="lineNo">${vo.board_id}</td> 
			 	</tr>
			 	<tr class="left divi">
			 		<td class="lineNo">${vo.board_write_date}</td>
			 	</tr>
			</table>
			<table class="_content">
			 	<tr valign="top" class="">
					<td class="lineNo2 left c_detail ">
						${fn:replace(vo.board_content, crlf, '</br>')}
						<c:if test="${!empty vo.board_image_path }">
							<img class="file-img" src="${vo.board_image_path }"/>
						</c:if>
					</td>
			 	</tr>
			</table>
		</div>
	</div>
	<form id="reply" action="reply.bo">
	<table style='margin:20px auto; padding-top:20px; width:55%;' >
		<tr id='comment_regist'>
			<c:if test="${!empty loginInfo}">
				<td class='w-px100'><span class='left'><strong>댓글작성</strong></span></td>
				<td><textarea id='comment' name="board_content" style='margin-top:5px; width:96%; height:60px; resize:none'></textarea></td>
				<td class='w-px100'><span class='right'><a class='btn-fill-s'  onclick="$('#reply').submit();">댓글등록</a></span>
				<input type="hidden" name="board_id" value="${loginInfo.id }" />
				<input type="hidden" name="board_nickname" value="${loginInfo.nickname }" />
				<input type="hidden" name="board_image_path" value="${loginInfo.dbimgpath }" />
				<input type="hidden" name="board_num" value="${vo.board_num }" /></td>
			</c:if>
		</tr>
	 	<tr id='comment_list' style='text-align:left'>
	 	<c:if test="${fn:length(cvo) > 0 }">
	 		<c:forEach items="${cvo}" var="cvo">
	 			<td>
	 			<c:if test="${!empty cvo.board_image_path }">
					<img class="file-img" src="${cvo.board_image_path }"/>
				</c:if>
	 			<span>${cvo.board_nickname}</span>
	 			<span>${cvo.board_write_date}</span></td>
	 			<td>${cvo.board_content}</td>
	 			<td><a class="btn-fill" onclick="if( confirm('정말 삭제?') ){ location='deleteC.bo?board_num=${cvo.board_num}' }">삭제</a></td>
	 		</c:forEach>
	 	</c:if>
	 	</tr>
	</table>
	</form>
	<div id='popup-background' onclick="$('#popup, #popup-background').css('display', 'none');"></div>
	<div id='popup'></div>
	
<script type="text/javascript" src="js/file_check.js"></script>	

</body>
</html>