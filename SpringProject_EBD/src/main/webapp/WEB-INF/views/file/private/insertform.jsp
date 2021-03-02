<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File insertFrom</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.head{
		text-align: center;
	}
</style>
</head>
<body>
<div class="container">
	<!-- 독후감 양식 파일 업로드(게시글) 추가 폼-->
	<h1 class="head" >독후감 양식을 공유해주세요</h1>
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
	 
	 <form action="insert.do" method="post" enctype="multipart/form-data">
	 	
	 	<div class="form-group">
	 		<label for="title">제목</label>
	 		<input class="form-control" type="text" id="title" name="title" />
	 	</div>
	 	<!-- 파일 업로드  -->
	 	<div class="form-group">
	 		<label for="myFile">첨부할 파일 선택</label>
	 		<input class="form-control" type="file" name="myFile" id="myFile" />
	 		<small class="text-muted">공유할 독후감 양식파일을 넣어주세요</small>
	 	</div>
	 	<!-- 이미지 업로드 -->
	 	<div class="form-group">
	 		<label for="myImg">첨부할 이미지 선택</label>
	 		<input class="form-control" type="file" name="myImg" id="myImg" 
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
	 		<small class="text-muted">예시 사진을 넣어주세요</small>
	 	</div>
	 	<!-- 스마트 에디터 보류 일단은 textarea로 구현 -->
	 	<div class="form-group">
		    <label for="content">내용</label>
		    <textarea class="form-control" type="text"  name="content" id="content" rows="5"></textarea>
		</div>
	 	
		<button class="btn btn-dark" type="submit">업로드</button>
		<button class="btn btn-dark" type="reset">입력 내용 취소</button>
	 	
	 </form>
	
</div>

</script>
</body>
</html>