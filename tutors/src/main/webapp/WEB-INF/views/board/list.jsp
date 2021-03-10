<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function clickTrEvent(id) {
	$("[name=id]").val(id);
	$("form").attr("action", "view.bo");
	$("form").submit();
}

/* $('[name=keyword]').change(function(){
	$('#delete').css("display", "inline");
});
$('#delete').click(function(){
	$('[name=keyword]').val('');
	$('#delete').css('display', 'none');
}); */

</script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
h3 {font-size: 20px}
#frame {margin: 0 auto; width: 55%;}
.searchBar { width: 100%; margin-bottom: 50px; margin-top: 30px;}
input[name=keyword]{width:90%;}
#noti {margin-bottom: 50px; margin-top: 30px; overflow: hidden;}
.noti_left {float: left; line-height: 50px; font-size: 20px;}
.noti_right {float: right; line-height: 50px; margin-right: 5px}
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
p { margin-bottom: 35px; }

.ellip{
	overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 7; 
    -webkit-box-orient: vertical;
    line-height: 2.2em;
	height: 10.6em;
}
.color{ color: #3982f7; margin-top: 10px; cursor: pointer; width: 15%}
.pic_size { width: 100%; margin: 0px;}
.readcount {
	margin-bottom: 20px;
	color: #9e9e9e;
}
</style>
</head>
<body>
	<div id="frame">
		<table>
			<h3>게시판</h3>
			<div><hr></div>
			<form method="post" action="list.bo">
				<div>
				 	<div>
				 		<div id="noti">
				 			<div class="noti_left">공지사항과 질문 및 답변이 있는 페이지입니다.</div>
						 	<div class="right noti_right"><c:if test="${!empty loginInfo }"><a class="btn-fill" href="new.bo">글쓰기</a></c:if></div>
				 		</div>
					 	<div class="searchBar">
				 			<input type="text" name="keyword" value="${page.keyword}" placeholder="검색어입력" /> 
				 			<!-- <span id="delete" style="display: none; color: gray; position: relative; right: 25px; cursor: pointer;"><i class="fas fa-times"></i></span> -->
				 			<span id="btn_search" 
				 				onclick="$('form').submit()" 
				 				style="width: 50px; color:#3982f7; position: relative; right: 25px; cursor: pointer;"><i class="fas fa-search"></i></span>
				 				
					 	</div>
				 	</div>
				</div>
				<input type="hidden" name="curPage" value="1">
				</form>
			<div>
				<c:forEach items="${page.list }" var="vo">
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
								<span class="ellip">${fn:replace(vo.board_content, crlf, '</br>')}</span>
								<div class="color" onclick="clickTrEvent(${vo.board_num})">···전체보기</div><br>
								<div class="readcount">글이&nbsp;${vo.board_readcount}번 읽혔습니다. </div>
							</td>
					 	</tr>
					</table>
					<p></p>
					</br>
				</c:forEach>
			</div>
		</table>
		<form action="list.bo" method="post">
			<input type="hidden" name="id"/>
			<input type="hidden" name="curPage" value="1"/>
		</form>
	</div>
</body>
</html>