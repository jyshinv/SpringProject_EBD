<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 명언/글귀 작성하기</title>
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
    /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	text-decoration: none;
    }
    /*세로 크기를 300px로 */
   	#content{
		height: 150px;
	}
    
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/wording_insertform_jumbotron.jsp"></jsp:include>
<div class="container">
   <div class="row">
      <div class="col-2">
         <label for="search" class="col-form-label">책검색</label>
      </div >
      <div class="col">
         <a class="btn" href="${pageContext.request.contextPath }/wording/private/bookList.do">검색</a>
      </div >
   </div>
   <form action="insert.do" method="post" class="form-group">
      <div class="row">
         <div class="col-2">
            <label for="title" class="col-form-label">도서명</label>
         </div >
         <div class="col">
         	<input class="form-control" type="text" name="title" id="title" value="${title }"/>
         </div >
      </div>
      <div class="row">
         <div class="col-2">
            <label for="author" class="col-form-label">작가</label>
         </div >
         <div class="col">
            <input class="form-control" type="text" name="author" id="author" value="${author }" />
         </div >
      </div>
      <div class="row">
         <div class="col-2">
            <label for="content" class="col-form-label">내용</label>
         </div >
         <div class="col">
         	<textarea class="form-control DOC_TEXT" type="text" name="content" id="content" placeholder="200글자까지 가능" /></textarea>
         	<span style="color:#aaa;" id="counter">(0 / 최대 200자)</span>
         </div >
      </div>
      <div id="content" class="text-center" style="margin-top:50px; margin-bottom:50px;">
         <button class="btn" type="submit">저장</button>
      </div>
   </form>
</div>
<script>
	//글자수 카운트 해주는 함수 
	$('.DOC_TEXT').keyup(function (e){
	    var content = $(this).val();
	    $('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅
	
	    if (content.length > 200){
	        alert("최대 200자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 200));
	        $('#counter').html("(200 / 최대 200자)");
	    }
	});
</script>

</body>
</html>