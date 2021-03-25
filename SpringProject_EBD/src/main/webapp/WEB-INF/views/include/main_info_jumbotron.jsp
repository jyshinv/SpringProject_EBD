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
	 /*버튼 기본 노랑*/
    .btn {
    	background-color:#F7DC6F ;
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    }
     /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	/*color:sienna;*/
    }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn>a:hover{
    	color:#212529;
    	text-decoration:none;
    }  
	
</style>
<%-- wording jumbotron --%>
<div class="jumbotron jumbotron-fluid" style="background-color: #FEF9E7;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
  				<h1 class="display-4">
  					Welcome !
  				</h1>
   		 		<h1>
  					Every Day Book Day !
  				</h1>
   		 		<p class="lead">
   		 			이곳에서 Every Book Day 의 사용법을 더 자세히 알아보세요
   		 		</p>	
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_maininfo1.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>