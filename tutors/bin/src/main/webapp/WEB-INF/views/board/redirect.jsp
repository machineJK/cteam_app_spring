<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${url}" method="post">
		<input type="hidden" name="id" value="${id}">
		<input type="hidden" name="curPage" value="${page.curPage }">
	</form>
<script type="text/javascript">
$("form").submit();
</script>
</body>
</html>