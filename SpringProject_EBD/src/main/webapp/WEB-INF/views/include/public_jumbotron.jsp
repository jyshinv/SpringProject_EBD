<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
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
  					Share <br/>
  				    Your Book Report !
  				</h1>
   		 		<p class="lead">
   		 			당신이 경험한 새로운 세계를 다른 사람들과 공유해보세요.
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_report.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>