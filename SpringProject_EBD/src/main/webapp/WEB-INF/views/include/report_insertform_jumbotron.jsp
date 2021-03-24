<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotron{
		background-color:white;
		margin-bottom:0px;
	}
	.jumbotronImg{
		width: 550px;
	}
</style>
<%-- 독후감 인서트폼 점보트론 --%>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
  	<div>
  		<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd6.svg" alt="대문이미지" />
  	</div>
  	<br />
    <p class="lead">
    	당신이 남기고 싶은 책을 기록해보세요.
    </p>
  </div>
</div>