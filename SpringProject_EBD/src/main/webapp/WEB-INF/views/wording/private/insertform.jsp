<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 명언/글귀 작성하기</title>
</head>
<body>
	
	<form action="bookList.do">
		책검색<input type="submit" value="검색" />
	</form>
	<form action="insert.do" method="post">
		<label for="title">책 제목</label>
		<input type="text" name="title" id="title" value="${title }"/><br />			
		<label for="author">작가</label>
		<input type="text" name="author" id="author" value="${author }" /><br />
		<label for="content">내용</label>
		<input type="text" name="content" id="content" /><br />
		<input type="submit" value="입력하기" />
	</form>

</body>
</html>