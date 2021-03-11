<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/private/insertform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.head{
		text-align: center;
	}
	.btn-file{
        position: relative;
        overflow: hidden;
        /* 내용이 넘치면 자른다 */
    }
    .btn-file input[type=file] {
    	/* 부모 기준으로 움직인다? */
        position: absolute;
        top: 0;
        right: 0;
        
        min-width: 100%;
        min-height: 100%;
        font-size: 100px;
        text-align: right;
        
         /* 투명도 */
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
	 		<input class="form-control" type="text" id="title" name="title" placeholder="제목을 입력해 주세요." />
	 	</div>
	 	
	 	<!-- 파일 업로드  -->
	 	<div>
	 		첨부 파일 : <input type="text" id="fileName2" placeholder="파일을 첨부해주세요" />
	 		
	 		<label for="myFile" class="btn btn-primary btn-sm btn-file">첨부할 파일 선택
	 			<input type="file" name="myFile" id="myFile" onchange="reviewUploadImg2(this);" />
	 		</label>
	 		<br />
	 		<small class="text-muted">공유할 독후감 양식파일을 넣어주세요.</small>
	 	</div>
	 	
	 	<!-- 이미지 업로드 -->
	 	<div>
	 		이미지 : <input type="text" id="fileName" placeholder="이미지를 첨부해주세요" />
	 	
	 		<label for="myImg" class="btn btn-primary btn-sm btn-file">첨부할 이미지 선택
	 			<input type="file" name="myImg" id="myImg" onchange="reviewUploadImg(this);"
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
	 		</label>
	 		<br />
	 		<small class="text-muted">예시 사진을 넣어주세요.</small>
	 	</div>
	 	<br />
	 	
	 	<div class="form-group">
	 		<label for="content"></label>
		    <textarea class="form-control" type="text"  name="content" id="content"></textarea>
		</div>
	 	
		<button class="btn btn-dark" type="submit" onclick="submitContents(this);" >업로드</button>
		<button class="btn btn-dark" type="reset">입력 내용 취소</button>
	 	
	 </form>
	
</div>
<script>
   //이미지를 등록할 때마다 호출되는 함수 등록
   function reviewUploadImg(fileObj){
         var filePath = fileObj.value; //파일경로
         var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);//파일이름
         var fileKind = fileName.split(".")[1];//파일유형
         document.getElementById('fileName').value=fileName; //input text에 파일의 이름 들어감 
      }
   
   //파일을 등록할 때마다 호출되는 함수 등록
   function reviewUploadImg2(fileObj){
         var filePath = fileObj.value; //파일경로
         var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);//파일이름
         var fileKind = fileName.split(".")[1];//파일유형
         document.getElementById('fileName2').value=fileName; //input text에 파일의 이름 들어감 
      }
</script>

<!-- SmartEditor 에서 필요한 javascript 로딩  -->
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
</script>
</body>
</html>