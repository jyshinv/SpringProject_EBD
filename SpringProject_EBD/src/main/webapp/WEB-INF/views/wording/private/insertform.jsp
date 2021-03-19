<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 명언/글귀 작성하기</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
 	.btn-file{
        position: relative;
        overflow: hidden;
    }
    .btn-file input[type=file] {
        position: absolute;
        top: 0;
            right: 0;
        min-width: 100%;
        min-height: 100%;
        font-size: 100px;
        text-align: right;
        filter: alpha(opacity=0);
        opacity: 0;
        outline: none;
        background: white;
        cursor: inherit;
        display: block;
    }
    .row{
    	margin-bottom:5px;
    }
    /*버튼 기본 노랑*/
    .btn {
    	background-color:#F7DC6F ;
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    }
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<form action="bookList.do" class="form-group">
		<label for="booksearch">책검색</label>
		<button id="booksearch" class="btn" type="submit">등록</button>
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
</div>

</body>
</html>