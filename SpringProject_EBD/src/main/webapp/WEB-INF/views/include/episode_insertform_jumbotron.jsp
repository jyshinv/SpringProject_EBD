<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotron{
		background-color:white;
		margin-bottom:0px;
	}
	.jumbotronImg{
		height:130px;
	}
</style>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
  	<div>
  		<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd3.svg" alt="대문이미지" />
  	</div>
  	<br />
    <p class="lead">오늘은 어떤 이야기를 들려주고 싶은가요?</p>
  </div>
</div>