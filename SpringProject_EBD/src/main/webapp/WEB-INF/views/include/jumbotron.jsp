<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 400px;
		margin-left: 50px;
	}
	.jumbotron_table{
		margin-left: 100px;
	}
	
	.jumbotron{
		padding-top:40px;
		padding-bottom:40px;
	}
	
	 /*버튼 기본 노랑*/
    #btn-s {
    	background-color:#F7DC6F ;
    }
    
    /*버튼 호버시 연한 노랑*/
    #btn-s:hover{
    	background-color:#FBEEE6;
    }
</style>

<%-- jumbotron --%>
<div class="jumbotron jumbotron-fluid" style="background-color: #FEF9E7;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
	  			<div class="mx-auto mt-3" style="margin-bottom: 16px;">
					<form action="${pageContext.request.contextPath }/bookList.do"> 
						<div class="form-row">
						  <div class="col-8">
						    <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="도서를 검색해주세요" aria-label="Search"
						    style="border-radius:30px;">
						  </div>
						  <div class="col">
						    <button id="btn-s" class="btn my-2 my-sm-0" type="submit" style="border-radius:20px;">
				   			Search</button>
						  </div>
						</div>
					</form>
				</div>
  				<h1 class="display-4">
  					Make Every Day <br />
  					Your Book Day
  				</h1>
   		 		<p class="lead">
   		 			매일 책을 읽는다면 당신의 하루는 어떻게 달라질까요?<br />
   		 			이곳에서 일상이 책이 되는 순간을 경험해 보세요.
   		 		</p>
   		 		<a href="info.do" style=" color:#6DB286; "><strong>More</strong></a>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_home1.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>