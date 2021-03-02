<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명언/글귀 저장</title>
</head>
<body>
<script>
	alert("저장 완료");
	//wording의 list로 이동
	location.href="${pageContext.request.contextPath }/wording/list.do";
</script>
</body>
</html>