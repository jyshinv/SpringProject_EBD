<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/private/update</title>
</head>
<body>
<!-- 글 수정 완료 알림 -->
<script>
	alert("게시글이 수정 되었습니다.");
	location.href="${pageContext.request.contextPath}/market/detail.do?num=${num }";
</script>
</body>
</html>