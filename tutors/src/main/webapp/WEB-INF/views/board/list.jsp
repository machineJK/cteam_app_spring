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
#frame {margin: 0 auto; width: 60%;}
.searchBar { width: 100%; margin-bottom: 50px;}
input[name=keyword]{padding:3px; width:50%; height: 50px; border-radius: 10px; border: 1px solid #6875dd; padding: 5px; outline: none;}
#noti {margin-bottom: 20px; margin-top: 20px; overflow: hidden;}
.noti_left {float: left; line-height: 60px;}
.noti_right {float: right; margin-right: 5px;}

._content { 
	width: 100%;
	font-size: 18px;
	border: 1px solid #ccc;
}
.lineNo {
 	border: 0px;
 	border-top: 1px;
}
.lineNo2 {
	border: 1px solid #ccc;
	margin-bottom: 20px;
}
.c_detail {
	height: 100px;
	padding: 22px 30px;
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


</style>
</head>
<body>
	<div id="frame">
		<table>
			<h1>게시판</h1>
			<form method="post" action="list.bo">
				<div>
				 	<div>
				 		<div id="noti">
				 			<div class="noti_left">공지사항과 질문 및 답변이 있는 페이지입니다.</div>
						 	<div class="right po noti_right"><c:if test="${!empty loginInfo }"><a class="btn-fill" href="new.bo" style="font-size: 18px; width: 90px;">글쓰기</a></c:if></div>
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
					 		<th class="w-px60 lineNo" rowspan="2" ><img src="${loginInfo.dbimgpath}" style="width: 50px; height: 50px; border-radius: 100px"></th>
					 		<td class="lineNo">${vo.board_id}</td>
					 	</tr>
					 	<tr class="left divi">
					 		<td class="lineNo">${vo.board_write_date}</td>
					 	</tr>
					</table>
					<table class="_content">
					 	<tr valign="top" class="">
							<td class="lineNo2 left c_detail ">
							<span class="ellip">${fn:replace(vo.board_content, crlf, '</br>') }</span><div class="color" onclick="clickTrEvent(${vo.board_num})">···전체보기<div></td>
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