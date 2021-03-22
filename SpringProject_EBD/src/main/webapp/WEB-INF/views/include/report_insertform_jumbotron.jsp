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
    <h1 class="display-4"><b>Write Report</b></h1>
    <p class="lead">당신이 남기고 싶은 책을 기록해보세요.</p>
  </div>
</div>