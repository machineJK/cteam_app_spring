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
					<c:if test="${!empty loginInfo }">
						<c:if test="${loginInfo.id eq vo.board_id }">
							<a class="btn-fill" onclick="$('form').submit();">수정하기</a>
							<a class="btn-fill" href="new.bo">삭제하기</a>
						</c:if>
					</c:if>
				</div>
				<form action="modify.bo">
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
					</td>
			 	</tr>
			</table>
		</div>
	</div>
</body>
</html>