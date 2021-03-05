<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/private/updateform</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>

<div class="container">
	<h1>중고 거래 글쓰기  수정 폼</h1>
	<form action="update.do" method="post" enctype="multipart/form-data">
	 	<input type="hidden" name="num" value="${dto.num }"/>
	 	<div class="form-group">
	 		<label for="salesType">유형</label>
	 		<select class="form-control" name="salesType" id="salesType">
	 			<option>${dto.salesType }</option>
				<option>도서 나눔</option>
				<option>도서 교환</option>
				<option>도서 판매</option>	 		
	 		</select>
	 	</div>
	 	
	 	<!-- 판매상태 디폴트 판매중으로 하려면 히든을 하면 되는걸까? -->
	 	<div class="form-group">
	 		<label for="salesStatus">판매상태</label>
	 		<select class="form-control" name="salesStatus" id="salesStatus">
	 			<option>${dto.salesStatus }</option>
				<option>판매 중</option>
				<option>판매 완료</option>
	 		</select>
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="title">제목</label>
	 		<input class="form-control" type="text" id="title" name="title" value="${dto.title }"/>
	 	</div>
	 	
	 	<!-- 이미지 업로드 -->
	 	<div class="form-group">
	 		<label for="myImg">첨부할 이미지 선택</label>
	 		<input class="form-control" type="file" name="myImg" id="myImg" 
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG" disabled/>
	 	</div>
	 	
	 	<!-- 스마트 에디터 보류 일단은 textarea로 구현 -->
	 	<div class="form-group">
		    <label for="content">내용</label>
		    <textarea class="form-control" type="text" name="content" id="content" rows="5">${dto.content }</textarea>
		</div>
	 	
		<button class="btn btn-dark" type="submit">수정 완료</button>
		<button class="btn btn-dark" type="reset">입력 내용 취소</button>
	 	
	 </form>
	 
</div>

</body>
</html>