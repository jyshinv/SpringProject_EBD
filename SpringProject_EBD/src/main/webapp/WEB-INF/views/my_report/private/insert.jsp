<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/my_report/private/insert.jsp</title>
</head>
<body>
<script>
	alert("독후감을 저장 했습니다.");
	location.href="${pageContext.request.contextPath }/my_report/private/list.do";
</script>
</body>
</html>