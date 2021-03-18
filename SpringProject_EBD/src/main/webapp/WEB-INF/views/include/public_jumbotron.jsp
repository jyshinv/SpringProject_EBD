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
  					<b>
	  					Sharing <br/>
	  					a Book Review
  					</b>
  				</h1>
   		 		<p class="lead">
   		 			당신이 경험한 새로운 세계를 다른 사람들과 공유해보세요.<br />
   		 			빛나는 작은 씨앗이 예쁜 꽃이 되어 무럭무럭 자랄거예요.
   		 		</p>
  			</td>
  			<td>
  				<img class="jumbotronImg" src="${pageContext.request.contextPath}/resources/images/public_report.png" alt="대문이미지" />
  			</td>
  		</tr>
  	</table>
  </div>
</div>