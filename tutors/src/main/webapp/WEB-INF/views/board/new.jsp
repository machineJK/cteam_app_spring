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
.file_img { width: 40px; height:40px; cursor: pointer; text-align: right; margin-right: 25px}


table { width: 100%; margin-top: 1px;}
.lineNo {
 	border: 0px;
 	padding: 0px;
}
.font_size{ font-size: 20px;}
</style>
</head>
<body>
	<form method="post" action="insert.bo" enctype="multipart/form-data">
		<div id="frame">
			<h3>글쓰기</h3>
			<div><hr></div>
			<div class="right file">
				
				<label>
					<input type="file" name="file" id="attach-file"/>
					<img src="images/camera.png" class="file_img" />
				</label>
				<span id='preview'></span>
				<span id='file-name'></span>
				<span id='delete-file'><i class="fas fa-times"></i></span>			
			</div>
			<table class="lineNo">
				<tr valign="top" class="font_size">
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