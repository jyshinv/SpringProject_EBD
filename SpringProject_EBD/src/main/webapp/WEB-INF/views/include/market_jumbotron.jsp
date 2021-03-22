<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 폰트 링크 --%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">

<style>
   *{
      font-family: 'Gothic A1', sans-serif;
   }
	
	.jumbotronImg{
		width: 350px;
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
    	text-decoration: none;
    }
</style>

<%-- market jumbotron --%>
<div class="jumbotron jumbotron-fluid" style="background-color: #FEF9E7;">
  <div class="container justify-content-md-center">
  	<table class="jumbotron_table">
  		<tr>
  			<td>
   		 		<h1 class="display-4">
  					Books Books Market
  				</h1>
   		 		<p class="lead">
   		 			아직 읽지 않은 책은 숨겨진 보물 입니다 <br />
   		 			북스북스 회원들이 내놓은 보물, <br />
   		 			지금 만나 보세요!
   		 		</p>
   		 		<p>
					<a href="${pageContext.request.contextPath }/market/private/insertform.do" 
						class="btn">
						거래 글 쓰러가기
					</a>
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_market.svg" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>