<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<h1>허용되지 않은 요청입니다.</h1>
	<p>${exception.message }</p>
	<a href="${pageContext.request.contextPath }/">홈으로 돌아가기</a>
</div>
</body>
</html>