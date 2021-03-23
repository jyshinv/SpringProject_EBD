<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/private/insert</title>
</head>
<body>
<!-- 글 작성 완료 알림 -->
<script>
	alert("게시글이 등록 되었습니다.");
	location.href="${pageContext.request.contextPath}/market/list.do";
</script>
</body>
</html>