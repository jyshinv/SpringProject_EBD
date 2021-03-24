<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 200px;
		height: 200px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	
	.info{
		margin-top:50px;
		text-align:center;
	}
	
	.info-table{
		margin-top:40px;
	}
	
	.btn-style{
		margin-bottom:30px;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<%-- jumborton --%>
<jsp:include page="../../include/info_jumbotron.jsp"></jsp:include>
<div class="container">
	<div class="info">
		<c:choose>
			<c:when test="${empty dto.profile }">
				<!-- 비어있다면 기본이미지 -->
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
		  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<!-- 이미지를 업로드 했다면 업로드한 이미지를 불러온다.-->
				<img id="profileImage" src="${pageContext.request.contextPath }${requestScope.dto.profile}"/>
			</c:otherwise>
		</c:choose>
	</div>
	<table class="table info-table">
		<colgroup >
			<col width="150"/>
			<col />
		</colgroup>
		
		<tr>
			<th>아이디</th>
			<td>${id }</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td><a href="pwd_updateform.do"> 비밀번호 수정하기</a></td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${dto.name }</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${nick }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${dto.email }</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${dto.birth_year }년 ${dto.birth_month }월 ${dto.birth_day }일</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${dto.gender }</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td>${dto.regdate }</td>
		</tr>
	</table>
	<div class="text-center btn-style">
		<a class="btn" style="background-color:#F7DC6F; border:none;"
		 href="updateform.do">개인 정보 수정</a>
		<a class="btn" style="background-color:#AECA9F; border:none;"
		href="javascript:deleteConfirm()">탈퇴</a>
	</div>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm("회원님 탈퇴 하시겠습니까? 탈퇴하시면 모든 정보가 지워집니다.");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/users/private/delete.do";
		}
	}
</script>
</body>
</html>