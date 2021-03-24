<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 검색</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
	/*버튼 기본 노랑*/
    .btn {
    	background-color:#F7DC6F ;
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    }
    /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	text-decoration: none;
    }
</style>
<body>
<div class="container-fluid">
	<div class="container" style="margin-bottom:10px;">
		<form action="bookList.do">
			<div class="row justify-content-md-center">
				<div class="col-md-8">
					<input class="form-control" type="text" name="keyword" />
				</div>
				<span>
					<input class="btn" type="submit" value="검색" />
				</span>
			</div>
		</form>
	</div>
	<table class="table" id="search-api">
		<thead>
    		<div class="container">
		       	<tr class="text-center">
		       		<th>책표지</th>
		       		<th>책제목</th>
		       		<th>저자</th>
		       		<th>출판사</th>
		       		<th>책소개</th>
		       		<th>구매처 링크</th>
		       		<th>선택</th>
		       	</tr>
    		</div>
    	</thead>
    	<tbody>
	        <c:forEach items="${bookList}" var ="b">
	            <tr class="text-center">
	                <td width="100"><img src="${b.image}"></td>
	                <td width="200">"${b.title}"</td>
	                <td width="100">${b.author}</td>
	                <td width="100">${b.publisher }</td>
	                <td width="400">${b.description}</td>
	            	<td width="200">
	            		<a href="${b.link }">${b.link }</a>
	            	</td>
	                <td width="100">
			  			<form action="insertform.do">
			  				<label for="title"></label>
			  				<input type="hidden" id="title" name="title" value="${b.title }" /> 
			  				<label for="author"></label>
			  				<input type="hidden" id="author" name="author" value="${b.author }" /> 
			  				<input class="btn" type="submit" value="선택" />
			  			</form>
	                </td>
	            </tr>
	        </c:forEach>
    	</tbody>
    </table>
</div>
</body>
</html>