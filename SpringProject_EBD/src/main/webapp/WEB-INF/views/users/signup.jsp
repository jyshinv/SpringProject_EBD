<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EBD 회원가입</title>
</head>
<body>
<script>
	alert("회원가입이 완료되었습니다. 로그인 화면으로 이동합니다.");
	location.href="${pageContext.request.contextPath }/users/loginform.do";
</script>
</body>
</html>