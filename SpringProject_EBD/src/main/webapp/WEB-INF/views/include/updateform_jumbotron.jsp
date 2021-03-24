<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.jumbotronImg{
		height: 150px;
		margin-bottom: 20px;
	}
</style>
<%-- 회원정보 수정폼 점보트론 --%>
<div class="jumbotron jumbotron-fluid" style="background-color:#FEF9E7;">
  <div class="container">
 	<div class="text-center">
 		<h1 class="display-4">
			${sessionScope.nick}님
		</h1>
		<p>개인정보 수정을 원하시나요? <br />
		입력 후 수정 버튼을 꼭 눌러주세요 !
		</p>
 	</div>
  </div>
</div>