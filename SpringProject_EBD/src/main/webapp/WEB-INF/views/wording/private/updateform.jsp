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
	<form action="update.do" method="post">
		<input type="hidden" name="num" value="${dto.num }" />
		<label for="title">책 제목</label>
		<input type="text" name="title" id="title" value="${dto.title }" disabled/><br />			
		<label for="author">작가</label>
		<input type="text" name="author" id="author" value="${dto.author }" disabled/><br />
		<label for="content">내용</label>
		<input type="text" name="content" id="content" value="${dto.content }" /><br />
		<input type="submit" value="수정하기" />
		<input type="reset" value="취소" />
	</form>
</body>
</html>