<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정완료</title>
</head>
<body>
<script>
	alert("게시글이 수정 되었습니다.");
	//episode의 list로 이동
	location.href="${pageContext.request.contextPath }/episode/detail.do?num=${num}";
</script>
</body>
</html>