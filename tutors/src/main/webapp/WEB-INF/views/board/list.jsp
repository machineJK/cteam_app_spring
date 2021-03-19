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
function clickTrEvent(board_num) {
	$("[name=id]").val(board_num);
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



</style>
</head>
<body>
	<div id="frame">
		<table>
			<h1>게시판</h1>
			<form method="post" action="list.bo"  >
				<input type="hidden" name="id"/>
				<input type="hidden" name="curPage" value="1"/>
				<div>
			 		<div id="noti">
			 			<div class="noti_left">공지사항과 질문 및 답변이 있는 페이지입니다.</div>
					 	<div class="right po noti_right">
					 		<c:if test="${!empty loginInfo }"><a class="btn-fill" href="new.bo" style="font-size: 18px; width: 90px;">글쓰기</a>
					 		</c:if>
					 	</div>
			 		</div>
				 	<div class="searchBar">
					 	<ul>
							<li><select name='search' class='w-px80 option font'>
									<option value='all' ${page.search eq 'all' ? 'selected' :''} >전체</option>
									<option value='content' ${page.search eq 'content' ? 'selected' :''}>내용</option>
									<option value='writer' ${page.search eq 'writer' ? 'selected' :''}>작성자</option>
								</select>
							</li>
							<li>
								<input type='text' name='keyword' value='${page.keyword}' placeholder="검색어입력" style="height: 50px; font-family: 'S-CoreDream-4Regular'; font-size: 16px; padding-left: 15px;"/>
								<a id="btn_search" onclick="$('form').submit()" 
									style="width: 50px; color:#3982f7; position: relative; right: 25px; cursor: pointer;">
				 				<i class="fas fa-search" style="padding-left:-5px;"></i></a>
				 			</li>
						</ul>
					</div>
				</div>
				</form>
			<div>
				<c:forEach items="${page.list }" var="vo">
					<table class="_content">
					 	<tr class="left divi">
					 		<th class="w-px60 lineNo" rowspan="2" >
					 		<c:if test="${!empty vo.id_image_path }">
								<img class="pic_size" src="${vo.id_image_path }"  />
							</c:if></th>
					 		<td class="lineNo" style="padding-left: 20px; font-size: 25px; font-weight: bold;">${vo.board_nickname}</td>
					 	</tr>
					 	<tr class="left divi">
					 		<td class="lineNo" style="padding-left: 20px; font-size: 14px;">${vo.board_write_date}</td>
					 	</tr>
					</table>
					<table class="_content">
					 	<tr valign="top" class="">
							<td class="lineNo2 left c_detail ">
								<span class="ellip">${fn:replace(vo.board_content, crlf, '</br>')}</span>
								<c:if test="${!empty vo.board_image_path }">
									<img class="file-img" src="${vo.board_image_path }"/>
								</c:if>
								<div class="color" onclick="clickTrEvent(${vo.board_num})">···전체보기</div><br>
								<div class="readcount">글이&nbsp;${vo.board_readcount}번 읽혔습니다. </div>
							</td>
					 	</tr>
					</table>
					<p></p>
					<br/>
				</c:forEach>
			</div>
		</table>
		<div class='btnSet'>
			<jsp:include page="/WEB-INF/views/include/page.jsp"/>
		</div>
	</div>
</body>
</html>