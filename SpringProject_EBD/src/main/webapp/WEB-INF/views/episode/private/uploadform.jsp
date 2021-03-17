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
	<form action="upload.do" method="post" enctype="multipart/form-data" class="form-group">
		<div class="row">
			<div class="col-2">
				<label for="title">글 제목</label>
			</div>
			<div class="col">
				<input class="form-control" type="text" id="title" name="title" placeholder="내용을 입력해주세요"/>
			</div>
		</div>
		<div class="row">
			<div class="col-2">
				<label for="image" class="col-form-label">이미지 첨부</label>
			</div>
			<div class="col-8" style="padding-right:0px;">
				<input class="form-control" type="text" id="fileName" placeholder="이미지를 첨부해주세요" disabled/>
			</div>
			<div class="col" style="padding-left:0px;">
				<label for="image" class="btn btn-file" style="margin-bottom:0px;">파일첨부
				<input type="file" id="image" name="image" onchange="reviewUploadImg(this);" 
				accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
				</label>
			</div>
		</div>
		<div class="row">
			<div class="col-2">
				<label for="content" class="col-form-label">내용</label>
			</div>
			<div class="col">
				<textarea class="form-control" type="text" id="content" name="content" style="height:200px;"></textarea>
			</div>
		</div>
		<div class="text-center" style="margin-top:50px; margin-bottom:50px;">
			<button class="btn" type="submit">등록</button>
		</div>
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