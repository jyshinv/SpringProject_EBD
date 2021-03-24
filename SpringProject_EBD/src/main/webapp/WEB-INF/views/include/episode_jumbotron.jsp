<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 310px;
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
    }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn>a:hover{
    	color:#212529;
    	text-decoration:none;
    }  
</style>
<%-- episode jumbotron --%>
<div class="jumbotron jumbotron-fluid" style="background-color: #FEF9E7;">
  <div class="container">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
   		 		<h1 class="display-4">
  					Write Your <br />
  					Book Day !
  				</h1>
   		 		<p class="lead">
   		 			당신이 오늘, <br />
   		 			겪은 책과 관련된 재미있는 경험을 공유해주세요.
   		 		</p>
   		 		<p>
					<a href="${pageContext.request.contextPath }/episode/private/uploadform.do" class="btn">
						에피소드 작성</a>
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_signup.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>