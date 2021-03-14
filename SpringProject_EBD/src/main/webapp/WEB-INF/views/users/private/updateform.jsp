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
		width: 100px;
		height: 100px;
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
	<!-- 프로필 수정 -->
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
	<button class="btn btn-outline-primary" id="profileLink" href="javascript:">수정하기</button>
	<br />
	<form action="profile_upload.do" method="post" 
		enctype="multipart/form-data" id="profileForm">
		<label for="image">프로필 이미지 선택</label>
		<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		<button type="submit">업로드</button>
	</form>
	<br />
	<!-- 개인정보 수정 -->
	<form action="update.do" method="post" id="myForm" novalidate>
		<div class="form-group" id="form-id">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id" value="${id }" placeholder="아이디" disabled/>
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" name="name" id="name" value="${dto.name }" placeholder="이름" disabled/>
		</div>
		<div class="form-group" id="form-nick">
			<label for="nick">닉네임</label>
			<input class="form-control" type="text" name="nick" id="nick" value="${nick }" placeholder="닉네임" />
			<small class="form-text text-muted">한글, 영소문자, 대문자, 숫자, 사용가능 (<b>1~15글자</b> 이내로 입력해주세요)</small>
			<div class="invalid-feedback"></div>
			<div class="valid-feedback"></div>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="email" name="email" id="email" value="${dto.email }" placeholder="이메일 예)ebd@acorn.com" />
			<div class="invalid-feedback">이메일 형식을 확인해주세요.</div>
			<div class="valid-feedback">사용가능한 이메일 입니다.</div>
		</div>
		<div class="form-group">
			<label for="email">연락처</label>
			<input class="form-control" type="text" name="phone" id="phone" value="${dto.phone }" placeholder="연락처를 - 없이 입력해주세요" />
			<div class="invalid-feedback">숫자만 입력해주세요.</div>
			<div class="valid-feedback">사용가능한 연락처 입니다.</div>
		</div>		
		<button type="submit" class="btn btn-outline-primary">수정</button>
		<button type="reset" class="btn btn-outline-primary">취소</button>
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
	
	//https://regexr.com/ 테스트는 여기서 해보기 
	//닉네임을 검증할 정규 표현식 (한글, 영소문자, 대문자 숫자 사용가능 1~15글자 이내)
	let reg_nick=/^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣A-Za-z0-9]{1,15}$/;
	//이메일을 검증할 정규 표현식(@가 포함되어 있는 지 검증, 이메일을 제대로 입력해주세요.)
	let reg_email=/@/; 
	//핸드폰을 검증할 정규 표현식(-를 제외하고 숫자만 입력해주세요)
	let reg_phone=/[0-9]$/;
	
	//넘어온 값은 모두 저장 가능한 값이므로 true로 만들어준다.
	//닉네임 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isNickValid=true;
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isEmailValid=true;
	//핸드폰 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isPhoneValid=true;
	//폼 전체 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isFormValid=true;
	
	//넘어온 값은 모두 저장 가능한 값이므로 모든 폼을 valid로 만들어준다. 
	$("#nick, #email, #phone").removeClass("is-valid is-invalid");
	$("#nick, #email, #phone").addClass("is-valid");
	$("#form-nick").children(".valid-feedback").text("사용가능한 닉네임입니다");

	//폼에 submit이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm인 요소에 submit이벤트가 일어났을 때 실행할 함수 등록 
	$("#myForm").on("submit",function(){
		
		//폼 전체의 유효성 여부를 얻어낸다. 
		isFormValid = isNickValid&isEmailValid&isPhoneValid;
		
		//true가 아니면 모두 입력해주세요 라는 알림창과 함께 폼전송을 막는다. 
		if(!isFormValid){
			alert('모두 입력해주세요'); //알림창
			return false; //폼전송을 막는다. 
		}
		
	});

	//닉네임 중복 & 유효성 검사
	$("#nick").on("input", function(){
		//입력한 닉네임을 읽어온다.
		let inputNick= $("#nick").val();
		let inputBeforeNick="${nick }";
		console.log(inputBeforeNick);
		
		//일단 모든 검증 클래스를 제거하고
		$("#nick").removeClass("is-valid is-invalid");
		
		//닉네임이 정규표현식에 매칭되지 않으면
		if(!reg_nick.test(inputNick)){
			//닉네임이 유효하지 않는다고 표시하고
			$("#nick").addClass("is-invalid");
			$("#form-nick").children(".invalid-feedback").text("한글, 영소문자, 대문자, 숫자만 사용가능 (1~15글자 이내로 입력해주세요)");
			isNickValid=false;
			//함수를 여기서 종료한다.
			return;
		}
		
		//입력을 했으나 기존의 닉네임의 경우네는 기존의 닉네임이라고 알려준다. 
		if(inputNick==inputBeforeNick){
			$("#nick").addClass("is-valid");
			$("#form-nick").children(".valid-feedback").text("기존의 닉네임입니다. 사용가능합니다.");
			//닉네임이 유효하다고 표시한다.
			isNickValid=true;
			//함수를 여기서 종료한다.
			return;
		}

		
		$.ajax({
			url: "${pageContext.request.contextPath }/users/checknick.do",
			method : "GET",
			data:"inputNick="+inputNick,
			success:function(responseData){
				if(responseData.isExist){//이미 존재하는 닉네임인 경우
					$("#nick").removeClass("is-valid is-invalid");
					$("#nick").addClass("is-invalid");
					$("#form-nick").children(".invalid-feedback").text("이미 존재하는 닉네임입니다.");
					isNickValid=false;
				}else{ //존재하지 않는 닉네임 즉 사용하지 않는 닉네임인 경우
					$("#nick").removeClass("is-valid is-invalid");
					$("#nick").addClass("is-valid");
					$("#form-nick").children(".valid-feedback").text("사용가능한 닉네임입니다.");
					//닉네임이 유효하다고 표시한다.
					isNickValid=true;
				}
			}
		})
	});
	
	
	
	//이메일 유효성 검사
	$("#email").on("input", function(){
		//입력한 이메일을 읽어온다.
		let email=$("#email").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-valid is-invalid");
		
		//이메일이 정규표현식에 매칭되지 않으면
		if(!reg_email.test(email)){
			//이메일이 유효하지 않는다고 표시하고
			$("#email").addClass("is-invalid");
			isEmailValid=false;
			//함수를 여기서 종료한다.
			return;
		}else{
			isEmailValid=true;
			$("#email").addClass("is-valid");			
		}
		
		
	});
	
	//핸드폰 번호 유효성 검사
	$("#phone").on("input", function(){
		//입력한 핸드폰 번호를 읽어온다.
		let phone=$("#phone").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#phone").removeClass("is-valid is-invalid");
		
		//핸드폰 번호가 정규표현식에 매칭되지 않으면
		if(!reg_phone.test(phone)){
			//핸드폰 번호가 유효하지 않는다고 표시하고
			$("#phone").addClass("is-invalid");
			isPhoneValid=false;
			//함수를 여기서 종료한다.
			return;
		}else{
			isPhoneValid=true;
			$("#phone").addClass("is-valid");
		}
		
	});
</script>
</body>
</html>


