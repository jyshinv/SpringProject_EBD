<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/private/updateform.jsp</title>
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
	<h1 class="head" >중고 거래 글쓰기  수정 폼</h1>
	<form action="update.do" method="post" enctype="multipart/form-data">
	 	<input type="hidden" name="num" value="${dto.num }"/>
	 	<input type="hidden" name="imgpath" value="${dto.imgpath }" } />
	 	
	 	<div class="form-group">
	 		<label for="title">제목</label>
	 		<input class="form-control" type="text" id="title" name="title" value="${dto.title }"/>
	 	</div>
	 	
	 	<div class="form-group">
	 		<label for="salesType">유형</label>
	 		<select class="form-control" name="salesType" id="salesType">
				<c:if test="${dto.salesType eq '도서 나눔' }">
					<option>${dto.salesType}</option>
					<option>도서 교환</option>
					<option>도서 판매</option>
				</c:if>
				<c:if test="${dto.salesType eq '도서 교환' }">
					<option>${dto.salesType}</option>
					<option>도서 나눔</option>
					<option>도서 판매</option>
				</c:if>
				<c:if test="${dto.salesType eq '도서 판매' }">
					<option>${dto.salesType}</option>
					<option>도서 나눔</option>
					<option>도서 교환</option>
				</c:if>
	 		</select>
	 	</div>
	 	
<!--  	 	<div class="form-group">
	 		<label for="salesStatus">판매상태</label>
	 		<select class="form-control" name="salesStatus" id="salesStatus">
	 			<c:choose>
					<c:when test="${dto.salesStatus eq '판매 중' }">
						<option>${dto.salesStatus}</option>
						<option>판매 완료</option>
					</c:when>
					<c:otherwise>
						<option>${dto.salesStatus}</option>
						<option>판매 중</option>
					</c:otherwise>
				</c:choose>
	 		</select>
	 	</div> -->
	 	
	 	<!-- 이미지 업로드 -->
	 	<div class="form-group">
	 		이미지 : <input type="text" id="fileName" placeholder="이미지를 첨부해주세요" value="${filename }" />
	 		
	 		<label for="myImg" class="btn btn-primary btn-sm btn-file" >첨부할 이미지 선택
	 			<input type="file" name="myImg" id="myImg" onchange="reviewUploadImg(this);"
	 			accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
	 		</label>
	 		<br />
	 	</div>
	 	<br />
	 	<div class="form-group">
		    <textarea class="form-control" type="text" name="content" id="content">${dto.content }</textarea>
		</div>
		<button class="btn btn-dark" type="submit" onclick="submitContents(this);" >수정 완료</button>
		<button class="btn btn-dark" type="reset" >취소</button>
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