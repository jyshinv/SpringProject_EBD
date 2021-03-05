<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>



</head>
<body>
<div class="container">
	<form action="upload.do" method="post" enctype="multipart/form-data">
		<div>
			<label for="title">글 제목</label>
			<input type="text" id="title" name="title" placeholder="내용을 입력해주세요"/>
		</div>
		이미지<input type="text" id="fileName" placeholder="이미지를 첨부해주세요" disabled/>
		<label for="image" class="btn btn-primary btn-file">
			파일추가<input type="file" id="image" name="image" onchange="reviewUploadImg(this);" 
			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		</label>
		<br />
		<label for="content">내용</label>
		<input type="text" id="content" name="content" /><br />
		<button type="submit">등록</button>
	</form>
</div>
</body>
<script>
	//이미지를 등록할 때마다 호출되는 함수 등록
	function reviewUploadImg(fileObj){
   		var filePath = fileObj.value; //파일경로
   		var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);//파일이름
   		var fileKind = fileName.split(".")[1];//파일유형
   		document.getElementById('fileName').value=fileName; //input text에 파일의 이름 들어감 
   	}
	
	
</script>
</html>