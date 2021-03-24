<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   *{
      font-family: 'Gothic A1', sans-serif;
   }
	.jumbotronImg{
		height: 350px;
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
	  				${sessionScope.nick}님,<br />
	  				개인공간
  				</h1>
   		 		<p class="lead">
   		 			Everyday BookDay!
   		 			매일 매일 책 읽는 습관을 가져요
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_img5.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>