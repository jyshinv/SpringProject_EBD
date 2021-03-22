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
	/*버튼 관련 css*/
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
       
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_write" name="thisPage"/>
</jsp:include>
<div class="container">
	<form action="my_write_category.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-8">
				<select class="form-control" name="condition" id="condition">
					<option value="wording">명언/글귀</option>
					<option value="episode" selected>에피소드</option>
					<option value="market">마켓</option>
					<option value="file">파일</option>
				</select>
			</div>
			<span>
				<button id="button" class="btn btn-light" style="background-color:#F7DC6F;">검색</button>
			</span>
		</div>
	</form>	
	에피소드 페이지입니다.
</div>
</body>
</html>