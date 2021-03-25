<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Every Book Day</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
	.best{
		animation: motion 0.4s linear 0s infinite alternate; margin-left: 0;
	}
	
	@keyframes motion {
		   0% {margin-left: 0px;}
		   100% {margin-left: 15px;}
	}
	 /*BEST*/
   .badge-size{
   		font-size : 15px;
   		padding:10px;
   		margin-top: 10px;
   }
   #badge-color{
   
   	background-color:#6DB286;
   }
   body{
   	margin-bottom:32px;
   }
</style>
</head>
<body>
<%-- nav bar --%>
<jsp:include page="include/navbar.jsp"></jsp:include>
<jsp:include page="include/main_info_jumbotron.jsp"></jsp:include>	
<div class="container">
	<div class="card">
		<p class="best text-center">
			<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
			Every Book Day 티저 영상</span>
		</p>
		<div class="card-body text-center">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/dLUVLDHrENQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<br />
		<br />
		<br />
		<p class="best text-center">
			<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
			Every Book Day 이용 안내 영상</span>
		</p>
		<div class="card-body text-center">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/Y-T6-H_4ZKM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
</div>
</body>
</html>