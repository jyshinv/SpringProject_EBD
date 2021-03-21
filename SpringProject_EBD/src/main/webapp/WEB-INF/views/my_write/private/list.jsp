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
	/* card 이미지 부모요소의 높이 지정 */
	.img-wrapper{
		height: 250px;
		/* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
		transition: transform 0.3s ease-out;
		
	}
	/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
	.img-wrapper:hover{
		/* 원본 크기의 1.1 배로 확대 시키기*/
		/*transform: scale(1.05);*/
		opacity: 0.3;
	}
	.card .card-title{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: clip;
		overflow: auto;
		color:white;
	}
	.card{
		margin:5px;
		border:0px;
	}
	.card-body{
	    padding-top: 10px;
	    padding-bottom: 10px;
	    height: 50px;
	}
	#img{
		object-fit: cover;
		background-position:center;
		
	}
	.heart-link{
	/*
      font-size : 2em;
    */  
   	}
   	
	
	/* 프로필 이미지를 작은 원형으로 만든다 */
    #profileImage{
      width: 100px;
      height: 100px;
      border: 1px solid #cecece;
      border-radius: 50%;
    }	
	/*버튼 기본 노랑*/
    .btn{
    	background-color:#F7DC6F;
    	/*color:sienna;*/
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    	/*color:sienna;*/
    }
    /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	/*color:sienna;*/
    }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn>a:hover{
    	color:#212529;
    	text-decoration:none;
    }  
    /* page-item active 색상 변경 */
    .page-item.active .page-link{
    	background-color:#F7DC6F;
    	border-color:#F7DC6F;
    } 
    .page-link:hover{
    	color:#212529;
    	background-color:#FBEEE6;
    	border-color:#FBEEE6;
    }
    .page-link{
    	color:#212529;
    }    
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_write" name="thisPage"/>
</jsp:include>
<div class="container">
	<div class="row justify-content-md-center" style="margin:10px;">
		<div class="col-8">
			<select class="form-control" name="condition" id="condition">
				<option value="market">마켓</option>
				<option value="file">파일</option>
				<option value="episode">에피소드</option>
				<option value="wording">명언/글귀</option>
			</select>
		</div>
		<span>
			<button id="button" class="btn btn-light" style="background-color:#F7DC6F;">검색</button>
		</span>
	</div>
	<!-- ajax요청 내용이 나오는 곳 -->
	<div cass="container" id="list">
	</div>
</div>
<script>
	//처음에 요청되는 ajax요청(리포트가 기본적으로 요청된다.)
	//let condition=$("#condition option:selected").val();
	//$.ajax({
	//	url:"${pageContext.request.contextPath }/my_write/private/my_write.do",
	//	method:"GET",
	//	data: "condition="+condition,
	//	success:function(data){ 
			//id가 list인 요소를 일단 비워준다.
			//$("#list").empty();
			//id가 list인 요소에 append 해준다.
			//$("#list").append(data);
	//	}
	//});
	//검색 버튼을 클릭할 때마다 ajax요청을 한다. 
	$(document).on("click",".btn", function(){
		//어떤 카테고리를 선택했는 지 읽어온다. 
		let condition=$("#condition option:selected").val();
		$.ajax({
			url:"${pageContext.request.contextPath }/my_write/private/my_write.do",
			method:"GET",
			data: "condition="+condition,
			success:function(data){ 
				//id가 list인 요소를 일단 비워준다.
				$("#list").empty();
				//id가 list인 요소에 append 해준다.
				$("#list").append(data);
			}
		});
	});
	
</script>
</body>
</html>