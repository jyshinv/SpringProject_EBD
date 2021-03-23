<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
   .jumbotronImg{
      height: 250px;
   }
</style>

<%-- signup jumbotron --%>

<div class="jumbotron jumbotron-fluid" style="background-color: #FEF9E7;">
	<div class="container text-center">
		<div>
			<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_img3.svg" alt="대문이미지" />
  		</div>
  		<br />
    	<h1 class="display-4">
    		Create Your Account
		</h1>
    	<p class="lead">Every Book Day 회원님이 되어주세요 !</p>
	</div>
</div>
