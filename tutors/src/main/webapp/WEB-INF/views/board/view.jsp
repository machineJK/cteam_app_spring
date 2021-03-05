<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="_content">
	 	<tr class="left divi">
	 		<th class="w-px60 lineNo" rowspan="2" >프로필사진</th>
	 		<td class="lineNo">${vo.board_id}</td>
	 	</tr>
	 	<tr class="left divi">
	 		<td class="lineNo">${vo.board_write_date}</td>
	 	</tr>
	</table>
	<table class="_content">
	 	<tr valign="top" class="">
			<td class="lineNo2 left c_detail ">${fn:replace(vo.board_content, crlf, '</br>') }</td>
	 	</tr>
	</table>
</body>
</html>