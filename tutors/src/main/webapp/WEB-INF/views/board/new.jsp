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
#frame {margin: 0 auto; width: 55%; }
.file {margin-top: 40px;}
.file_img { width: 40px; cursor: pointer; text-align: right; margin-right: 5px}
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
					<div><img src="images/pngwing.png" class="file_img" /></div>
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
		<a class="btn" onclick="if(emptyCheck()) $('form').submit()">완료</a>
	</div>
<script type="text/javascript" src="js/file_check.js"></script>
</body>
</html>