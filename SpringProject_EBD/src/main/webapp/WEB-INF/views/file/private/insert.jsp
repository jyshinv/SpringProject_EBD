<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/private/insert.jsp</title>
</head>
<body>
<script>
	alert("게시글이 등록 되었습니다.");
	location.href="${pageContext.request.contextPath}/file/list.do";
</script>
</body>
</html>