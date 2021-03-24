<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 300px;
		margin-left: 50px;
	}
	.jumbotron_table{
		margin-left:100px;
	}
	
	/*버튼 기본 노랑*/
    .btn {
    	background-color:#F7DC6F;
    }
    
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    }
   
    /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	text-decoration: none;
    }
</style>
<%-- file jumbotron --%>
<div class="jumbotron jumbotron-fluid jumbo-font" style="background-color: #FEF9E7; padding-bottom:10px;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
  				<h1 class="display-4">
  					Please <br />
  					Share it with us !
  				</h1>
   		 		<p class="lead">
   		 			당신이 만든 독후감 양식을 <br />
   		 			회원들과 공유하고 나눔의 기쁨을 느껴보세요.
   		 		</p>
   		 		<p>
					<a href="${pageContext.request.contextPath }/file/private/insertform.do" class="btn">
						독후감 양식 공유</a>
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_myreport.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  	<br /><br />
  </div>
</div>