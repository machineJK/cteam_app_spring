<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
h3 {font-size: 20px}
#frame {margin: 0 auto; width: 60%;}
.file {margin-top: 40px;}
.file_img { width: 40px; cursor: pointer; text-align: right; margin: 5px;}
#textarea { width: 100%; height: 300px; margin: 0 auto; padding: 10px; font-size: 20px; resize: none;
border: 1px solid #ccc; outline: none;}
table { width: 100%; margin-top: 1px;}
.lineNo {
 	border: 0px;
 	padding: 0px;
}
</style>
</head>
<body>
	<form method="post" action="insert.bo" enctype="multipart/form-data">
		<div id="frame">
			<h3>글쓰기</h3>
			<div><hr></div>
			<div class="right file">
				<label>
					<input type="file" name="file" id="pic_file" style="display: none;"/>
					<div><img src="images/camera.png" class="file_img" /></div>
				</label>
			</div>
			<table class="lineNo">
				<tr valign="top">
					<th class="lineNo">내용</th>
					<td class="lineNo"><textarea id="textarea" name="board_content" title="내용"></textarea></td>
				</tr>
			</table>
		</div>
	</form>
	<div class="btnSet">
		<a class="btn-fill" style="width: 100px; font-size: 20px;" onclick="if(emptyCheck()) $('form').submit()">등록</a>
	</div>
<script type="text/javascript" src="js/file_check.js"></script>
</body>
</html>