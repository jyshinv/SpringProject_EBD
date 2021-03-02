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
		<label for="title"></label>책제목
		<input type="text" name="title" id="title" value="${empty title ? "" : title }"/><br />			
		<label for="author"></label>작가
		<input type="text" name="author" id="author" value="${empty author ? "" : author }" /><br />
		<label for="content"></label>내용
		<input type="text" name="content" id="content" /><br />
		<input type="submit" value="입력하기" />
	</form>

</body>
</html>