<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/private/insertform</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>

<div class="container">
	<h1>중고 거래 글쓰기 폼</h1>
	<form action="insert.do" method="post" enctype="multipart/form-data">
	 	
	 	<div class="form-group">
	 		<label for="salesType">유형</label>
	 		<select class="form-control" name="salesType" id="salesType">
				<option selected >도서 나눔</option>
				<option>도서 교환</option>
				<option>도서 판매</option>	 		
	 		</select>
	 		<small class="text-muted">거래 유형을 선택해주세요.</small>
	 	</div>
	 	
	 	<!-- 테이블을 '판매중'으로 디폴트 설정할지
	 		 숨길지 고민 고민 고민 고민  -->
	 	<div class="form-group">
	 		<label for="salesStatus">판매상태</label>
	 		<select class="form-control" name="salesStatus" id="salesStatus" >
				<option selected >판매 중</option>
				<option>판매 완료</option>
	 		</select>
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="title">제목</label>
	 		<input class="form-control" type="text" id="title" name="title" 
	 			placeholder="제목을 입력해 주세요."/>
	 	</div>
	 	
	 	<!-- 이미지 업로드 -->
	 	<div class="form-group">
	 		<label for="myImg">첨부할 이미지 선택</label>
	 		<input class="form-control" type="file" name="myImg" id="myImg" 
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
	 		<small class="text-muted">거래할 도서의 사진을 넣어주세요</small>
	 	</div>
	 	
	 	<!-- 스마트 에디터 보류 일단은 textarea로 구현 -->
	 	<div class="form-group">
		    <label for="content">내용</label>
		    <textarea class="form-control" type="text" name="content" id="content" rows="5"></textarea>
		</div>
	 	
		<button class="btn btn-dark" type="submit">작성</button>
		<button class="btn btn-dark" type="reset">입력 내용 취소</button>
	 	
	 </form>
	 
</div>
</body>
</html>