<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.head{
		text-align: center;
	}
</style>
</head>
<body>
<!-- 독후감 양식 파일 업로드(게시글) 수정 폼-->

<!-- 제목 수정 불가 : 폼전송 막기 / 파일&내용 수정 가능
	정보를 그대로 가져오기  -->
	
<div class="container">
	<!-- 독후감 양식 파일 업로드(게시글) 추가 폼-->
	<h1 class="head" >독후감 수정 페이지 입니다.</h1>
	
	<%--
			[ 파일 업로드 폼 작성법 ]
			1. method="post"
			2. 폼에 enctype="multipart/form-data" 속성 추가
			3. <input type="file" /> 을 이용한다.  
	
			[ SmartEditor 를 사용하기 위한 설정 ]
			
			1. WebContent 에 SmartEditor  폴더를 복사해서 붙여 넣기
			2. WebContent 에 upload 폴더 만들어 두기
			3. WebContent/WEB-INF/lib 폴더에 
			   commons-io.jar 파일과 commons-fileupload.jar 파일 붙여 넣기
			4. <textarea id="content" name="content"> 
			   content 가 아래의 javascript 에서 사용 되기때문에 다른 이름으로 바꾸고 
			      싶으면 javascript 에서  content 를 찾아서 모두 다른 이름으로 바꿔주면 된다. 
			5. textarea 의 크기가 SmartEditor  의 크기가 된다.
			6. 폼을 제출하고 싶으면  submitContents(this) 라는 javascript 가 
		      	폼 안에 있는 버튼에서 실행되면 된다.
	 --%>
	 
	 <form action="update.do" method="post" enctype="multipart/form-data">
	 	<input type="hidden" name="num" value="${dto.num }"/>
	 	<div class="form-group">
	 		<label for="title">제목</label> 
	 		<input class="form-control" type="text" id="title" name="title" value="${dto.title }"/>
	 	</div>
	 	<div class="form-group">
	 	<!-- 파일 업로드  -->
	 	<div class="form-group">
	 		<label for="myFile">첨부할 파일 선택</label>
	 		<input class="form-control" type="file" name="myFile" id="myFile" value="${dto.orgfname }" disabled/>
	 		<small class="text-muted">공유할 독후감 양식파일을 넣어주세요</small>
	 	</div>
	 	<!-- 이미지 업로드 -->
	 	<div class="form-group">
	 		<label for="myImg">첨부할 이미지 선택</label>
	 		<input class="form-control" type="file" name="myImg" id="myImg" 
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG" value="${dto.imgpath }" disabled/>
	 			<small class="text-muted">공유할 독후감 양식파일을 넣어주세요</small>
	 	</div>
	 	<!-- 스마트 에디터 보류 일단은 textarea로 구현 -->
	 	<div class="form-group">
		    <label for="content">내용</label>
		    <textarea class="form-control" type="text" name="content" id="content" 
		    	rows="5" >${dto.content }</textarea>
		</div>
		
		<button class="btn btn-dark" type="submit">수정 완료</button>
		<button class="btn btn-dark" type="reset">입력 내용 취소</button>
	 	
	 </form>
	
</div>

</body>
</html>