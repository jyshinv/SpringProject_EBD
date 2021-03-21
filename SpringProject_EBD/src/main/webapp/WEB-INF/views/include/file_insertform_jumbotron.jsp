<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<style>
	.jumbo-font{
		
	}
	
	.jumbotronImg{
		width: 250px;
		height: 250px;
	}
	.jumbotron_table{
		text-align: center;
	}
	
</style>

<%-- file insertform jumbotron --%>
<div class="jumbotron jumbotron-fluid jumbo-font" style="background-color: white; margin-bottom:0px;">
	<div class="container">
		<div class="row">
		    <div class="col-md-6 offset-md-3">
		    	<table class="jumbotron_table">
		    		<tr> 
			  			<td>
			  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_img1.svg" 
			  				alt="대문이미지"/>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td>
			  				<h1 class="display-6 text-center" >
			  					 Share it with us!
			  				</h1>
			  			</td>
			  		</tr>
			  		<tr>
					 	<td>
					 		<p class="lead text-center">
					 			북스북스 회원들과 내가 만든 양식을 나누고, 공유하고 
					 		</p>
					 	</td>
			  		</tr>
			  	</table>
			</div>
		</div>
	</div><!-- container -->
</div>