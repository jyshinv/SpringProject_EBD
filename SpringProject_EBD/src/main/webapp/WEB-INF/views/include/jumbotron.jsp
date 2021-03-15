<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	.jumbotronImg{
		width: 350px;
		height: 350px;
		margin-left: 50px;
	}
	.jumbotron_table{
		margin-left: 100px;
	}
	
</style>

<%-- jumbotron --%>
<div class="jumbotron jumbotron-fluid" style="background-color: #e3f2fd;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
  				<h1 class="display-4">
  					Make Every Day <br />
  					Your Book Day
  				</h1>
   		 		<p class="lead">
   		 			매일 책을 읽는다면 당신의 하루는 어떻게 달라질까요?<br />
   		 			이곳에서 일상이 책이 되는 순간을 경험해 보세요.
   		 		</p>
   		 		<a href="">More</a>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="https://resource.grapplet.com/marketplace/7176/1591667231081/i.svg.preview.580x870.png" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>