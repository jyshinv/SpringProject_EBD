<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 150px;
		margin-bottom: 20px;
	}

</style>
<div class="jumbotron jumbotron-fluid" style="background-color:#FEF9E7;">
  <div class="container">
 	<div class="text-center">
 		<h1 class="display-4">
			${sessionScope.nick}님의 <br />
			회원 수정 페이지
		</h1>
 	</div>
  </div>
</div>