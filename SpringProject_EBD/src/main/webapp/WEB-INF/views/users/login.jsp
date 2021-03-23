<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EBD 로그인</title>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${requestScope.isValid}">
			<p>
				<script>
					alert('${requestScope.id }(${nick }) 님 로그인 되었습니다.');
					location.href="${requestScope.url}";
				</script>
			</p>
		</c:when>
		<c:otherwise>
			<p>
				아이디 혹은 비밀번호가 틀려요!
				<script>
					alert('아이디 비밀번호가 틀립니다!');
					location.href="loginform.do?url=${requestScope.encodedUrl}";
				</script>
			</p>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>

