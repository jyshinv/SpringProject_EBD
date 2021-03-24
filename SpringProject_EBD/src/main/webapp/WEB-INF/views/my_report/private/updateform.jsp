<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 글 수정</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   *{
      font-family: 'Gothic A1', sans-serif;
   }
	body{
		padding-top:120px;
	}
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
    	margin-bottom:10px;
    }
    /*버튼 기본 노랑*/
    .btn {
    	background-color:#F7DC6F ;
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    }
    /* 스마트 에디터 전체 화면 보이게 하는 css */
    #content{
		width: 99.5%;
		height: 400px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<form action="update.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="${dto.num }"/>
		<input type="hidden" name="imgpath" value="${dto.imgpath}"/><!-- 기존의 경로 불러옴 -->
		<div class="row">
			<div class="col-2">
				<label for="title" class="col-form-label">제목</label>
			</div >
			<div class="col">
				<input class="form-control" type="text" name="title" id="title" value="${dto.title }"/>
			</div >
		</div>
		<div class="row">
			<div class="col-2">
				<label for="booktitle" class="col-form-label">도서명</label>
			</div >
			<div class="col">
				<input class="form-control" type="text" name="booktitle" id="booktitle" value="${dto.booktitle }" disabled/>
			</div >
		</div>
		<div class="row">
			<div class="col-2">
				<label for="author" class="col-form-label">저자명</label>
			</div >
			<div class="col">
				<input class="form-control" type="text" name="author" id="author" value="${dto.author }" disabled/>
			</div >
		</div>
		<div class="row">
			<div class="col-2">
				<label for="genre" class="col-form-label">장르</label>
			</div >
			<div class="col">
				<%String[] genreArr={"선택안함","소설","시","수필","역사","예술","종교","인문","철학","자기계발"}; %>
				<select class="form-control" name="genre" id="genre">
					<c:forEach var="tmp" items="<%=genreArr %>">
						<option value="${tmp }" <c:if test="${dto.genre eq tmp }">selected</c:if>>${tmp }</option>						
					</c:forEach>
				</select>
			</div >
		</div>
		<div class="row">
			<div class="col-2">
				<label for="stars" class="col-form-label">평점</label>
			</div >
			<div class="col">
				<%String[] starsArr={"선택안함","★","★★","★★★","★★★★","★★★★★"}; %>
				<select class="form-control" name="stars" id="stars">
					<c:forEach var="tmp" items="<%=starsArr %>">
						<option value="${tmp }" <c:if test="${dto.stars eq tmp }">selected</c:if>>${tmp }</option>						
					</c:forEach>
				</select>
			</div >
		</div>
		<div class="row">
			<div class="col-2">
				<label for="image" class="col-form-label">이미지 첨부</label>
			</div >
			<div class="col-8" style="padding-right:0px;">
				<input class="form-control" type="text" id="fileName" placeholder="이미지를 첨부해주세요" value="${filename }" disabled/>
			</div >
			<div class="col" style="padding-left:5px;">
				<label for="image" class="btn btn-file" style="margin-bottom:0px;">파일수정
					<input type="file" id="image" name="image" onchange="reviewUploadImg(this);" 
			    			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
				</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="content"></label>
				<textarea class="form-control" name="content" id="content">${dto.content }</textarea>
			</div>
		</div>
		<div class="text-center" style="margin-top:30px; margin-bottom:30px;">
			<button class="btn" type="submit" onclick="submitContents(this);">수정</button>
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			elClickedObj.form.submit();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
	
   //이미지를 등록할 때마다 호출되는 함수 등록
   function reviewUploadImg(fileObj){
         var filePath = fileObj.value; //파일경로
         var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);//파일이름
         var fileKind = fileName.split(".")[1];//파일유형
         document.getElementById('fileName').value=fileName; //input text에 파일의 이름 들어감 
      }
</script>
</body>
</html>