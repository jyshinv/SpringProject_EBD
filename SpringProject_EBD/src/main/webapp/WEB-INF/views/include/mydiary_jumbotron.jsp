<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 330px;
		margin-left: 50px;
	}
	.jumbotron_table{
		margin-left: 100px;
	}
</style>
<div class="jumbotron jumbotron-fluid" style="background-color:#FEF9E7;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
  				<h1 class="display-4">
	  				${sessionScope.nick}님 개인 서재
  				</h1>
   		 		<p class="lead">
   		 			Every moment written in My Diary <br />
   		 			에브리북데이에서 함께한 시간들을 추억해 보세요.
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_img7.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>