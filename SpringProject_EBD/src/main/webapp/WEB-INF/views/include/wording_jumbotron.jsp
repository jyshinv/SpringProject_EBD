<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 290px;
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
  					Jump <br /> 
  					In to the Book !
  				</h1>
   		 		<p class="lead">
   		 			당신이 오늘, <br />
   		 			책 속에서 발견한 아름다운 구절을 공유해주세요.
   		 		</p>	
   		 		<p>
					<a href="${pageContext.request.contextPath }/wording/private/insertform.do" class="btn">
						책 명언/글귀 작성</a>
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_wording.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>