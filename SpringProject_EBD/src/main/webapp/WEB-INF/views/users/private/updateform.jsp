<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	/* 프로필 업로드 폼을 화면에 안보이게 숨긴다 */
	#profileForm{
		display: none;
	}
</style>
</head>
<body>
<div class="container">
	<h1>회원정보 수정 </h1>
	<a id="profileLink" href="javascript:">
		<c:choose>
			<c:when test="${empty dto.profile }">
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
	  				<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<img id="profileImage" 
					src="${pageContext.request.contextPath }${dto.profile}" />
			</c:otherwise>
		</c:choose>
	</a>
	<form action="#">
		<div>
			<!--  <label for="id">아이디</label>-->
			<input type="text" id="id" value=""  placeholder="아이디" disabled/>
		</div>
		<div>
			<!--  <label for="name">이름</label>-->
			<input type="text" id="id" value="${name}"  placeholder="이름"disabled />
		</div>
		<div>
			<!-- <label for="nickname">닉네임</label> -->
			<input type="text" id="nickname" value="${nickname}"  placeholder="닉네임"/>
		</div>
		<div>
			<!--  <label for="email">이메일</label>-->
			<input type="text" id="email" name="email" value="${dto.email }"  placeholder="이메일"/>
		</div>
		<div>
			<!--  <label for="phonenumber">핸드폰번호</label>-->
			<input type="number" id="phonenumber" name="phonenumber"  placeholder="핸드폰번호 -없이 입력"/>
			
		
		</div>
		<button type="submit" class="btn btn-outline-primary">수정</button>
		
		
		<!--<button type="reset">취소</button>-->
	</form>
	
	<form action="#">
		<label for="image">프로필 이미지 선택</label>
		<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		<button type="submit">업로드</button>
	</form>
</div>
<script>
	//프로필 링크를 클릭했을때 실행할 함수 등록
	$("#profileLink").on("click", function(){
		// 아이디가 image 인 요소를 강제 클릭하기
		$("#image").click();
	});
	//이미지를 선택했을때 실행할 함수 등록
	$("#image").on("change", function(){
		//폼을 강제 제출해서 선택된 이미지가 업로드 되도록 한다.
		$("#profileForm").submit();
	});
	
	
	
	//update 
	alert("수정 했습니다.");
	location.href="${pageContext.request.contextPath }/users/private/info.do";

	</script>
	
	
	
	
	<!-- pwd_update -->
	
	<div class="container">
	<h1>비밀번호 수정 </h1>
	<form action="#">
		<div>
			<!-- <label for="pwd">기존 비밀번호</label>-->
			<input type="password" name="pwd" id="pwd" placeholder="기존 비밀번호"/>
		</div>
		<div>
			<!-- <label for="newPwd">새 비밀번호</label> -->
			<input type="password" name="newPwd" id="newPwd" placeholder="새 비밀번호"/>
		</div>
		<div>
			<!-- <label for="newPwd2">새 비밀번호 확인</label> -->
			<input type="password" id="newPwd2" placeholder="새 비밀번호 확인"/>
		</div>
		<button type="submit" class="btn btn-outline-primary">수정</button>
		<button type="reset" class="btn btn-outline-danger" >취소</button>
	</form>
	</div>
	<script>
		//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
		document.querySelector("#myForm")
		.addEventListener("submit", function(event){
			let pwd1=document.querySelector("#newPwd").value;
			let pwd2=document.querySelector("#newPwd2").value;
			//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
			if(pwd1 != pwd2){
				alert("비밀번호를 확인 하세요!");
				event.preventDefault();//폼 전송 막기 
			}
		});
	</script>
	
	
	
	<!-- 독후감양식!! -->
	<form action="#">
	<div>
	<label for="booktitle">글 제목</label>
	<input type="text" name="booktitle" id="booktitle" placeholder="내용을 입력해주세요"/>
	</div>
	<div>
	<label for="attach_img">이미지 첨부</label>
	<input type="text" name="attach_img" id="attach_img" placeholder="내용을 입력해주세요"/>
	</div>
	<div>
	<label for="review_discussion">리뷰 및 의견 나누기</label>
	<!-- 
	<input type="review_discussion" name="review_discussion" id="review_discussion" placeholder="스마트 에디터" />
	
	input 보다 밑에 textarea가 맞겠죠??
	
	-->
	
	<textarea name="review_discussion" id="review_discussion" class='ta' cols="30" rows="16.5" placeholder="스마트 에디터" ></textarea>
	</div>
	
	<button type="submit" class="btn btn-outline-primary">작성</button>
	<button type="reset" class="btn btn-outline-danger" >취소</button>
	</form>
	
	<!-- pwd_updateform -->
	
	<div class="container">
	<h1>비밀번호 수정 </h1>
	<form action="#">
		<div>
			<!-- <label for="pwd">기존 비밀번호</label>-->
			<input type="password" name="pwd" id="pwd" placeholder="기존 비밀번호"/>
		</div>
		<div>
			<!-- <label for="newPwd">새 비밀번호</label> -->
			<input type="password" name="newPwd" id="newPwd" placeholder="새 비밀번호"/>
		</div>
		<div>
			<!-- <label for="newPwd2">새 비밀번호 확인</label> -->
			<input type="password" id="newPwd2" placeholder="새 비밀번호 확인"/>
		</div>
		<button type="submit" class="btn btn-outline-primary">수정</button>
		<button type="reset" class="btn btn-outline-danger" >취소</button>
	</form>
	</div>
	<script>
		//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
		document.querySelector("#myForm")
		.addEventListener("submit", function(event){
			let pwd1=document.querySelector("#newPwd").value;
			let pwd2=document.querySelector("#newPwd2").value;
			//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
			if(pwd1 != pwd2){
				alert("비밀번호를 확인 하세요!");
				event.preventDefault();//폼 전송 막기 
			}
		});
	</script>
</body>
</html>


