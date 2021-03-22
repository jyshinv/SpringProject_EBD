<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.jumbo-font{
		
	}
	.jumbotron{
		background-color:white;
		margin-bottom:0px;
	}
	.jumbotronImg{
		height: 250px;
	}
</style>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
  	<div>
  		<img class="jumbotronImg" src="${pageContext.request.contextPath}/resources/images/public_report.png" alt="대문이미지" />
  	</div>
    <h1 class="display-4"><b>Write Episode</b></h1>
    <p class="lead">오늘은 어떤 이야기를 들려주고 싶은가요?</p>
  </div>
</div>