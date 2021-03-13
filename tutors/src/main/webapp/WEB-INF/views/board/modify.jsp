<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
h3 {font-size: 20px}
#frame {margin: 0 auto; width: 55%; }
.file {margin-top: 40px;}
.file_img { width: 40px; cursor: pointer; text-align: right; margin-right: 25px}
#textarea { width: 95%; height: 300px; padding: 20px; font-size: 20px; resize: none;}
table { width: 100%; margin-top: 1px;}
.lineNo {
 	border: 0px;
}
a.btn {
	text-align:center;
	padding: 7px 80px;
	border:1px solid #3367d6;
	border-radius:3px; 
	box-shadow:2px 2px 3px #022d72; 
	background-color: #3367d6;
	color: #fff;
}
.font_size{ font-size: 20px;}
</style>
</head>
<body>
	<form method="post" action="update.bo" enctype="multipart/form-data">
		<div id="frame">
		<h3>${vo.board_nickname }님의 글 </h3>
			
			<div class="right file">
				<label>
					<input type="file" name="file" id="attach-file" style="display: none;"/>
					<div><img src="images/camera.png" class="file_img" /></div>
				</label>
			</div>
			<table class="lineNo">
				<tr valign="top" class="font_size">
					<th class="lineNo w-pct10">내용</th>
					<td class="lineNo"><textarea id="textarea" name="board_content" title="내용" class="font out">${vo.board_content }</textarea></td>
				</tr>
				<tr><th class="w-pct15 lineNo2">첨부파일</th>
					<td class='left lineNo2'>
						<span id='preview'></span>
						<span id='file-name'>
						<c:if test="${!empty vo.board_image_path }">
							<img class="file-img" src="${vo.board_image_path }"/>
							<span id='delete-file' style="display: inline;"><i class='fas fa-times'></i></span>
						</c:if>
						</span>
						
					</td>
				</tr>
			</table>
			<input type="hidden" name="board_num" value="${vo.board_num }"/>
			<input type="hidden" name="attach"/>
		</div>
	</form>
	<div class="btnSet">
		<a class="btn-fill" style="font-size: 20px; width: 60px;" onclick="$('[name=attach]').val( $('#file-name').text() ); $('form').submit()">등록</a>
		<a class="btn-empty" onclick="history.go(-1)" style="font-size: 20px; width: 80px;">취소</a>
	</div>
<script type="text/javascript" src="js/file_check.js"></script>
	
</body>
</html>