<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EBD 회원가입</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<img src="${pageContext.request.contextPath }/resources/images/logo_book.png"/>
	<h3>Create your Account</h3>
	<!-- 
		[ novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기 ]
		<input type="email" />  같은경우 웹브라우저가 직접 개입하기도 한다.
		해당기능 사용하지 않기 위해서는 novalidate 를 form 에 명시해야 한다. 
	 -->
	<form action="signup.do" method="post" id="myForm" novalidate>
		<div class="form-group" id="form-id">
			<input class="form-control" type="text" name="id" id="id" placeholder="아이디" />
			<small class="form-text text-muted"><b>영소문자</b>로 시작하고 <b>영소문자,대문자,숫자</b>만 사용가능합니다.(<b>5~15글자</b> 이내)</small>
			<div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
			<div class="valid-feedback">사용 가능한 아이디 입니다.</div>
		</div>
		<div class="form-group" id="form-pwd">
			<input class="form-control" type="password" name="pwd" id="pwd" placeholder="비밀번호" />
			<small class="form-text text-muted"><b>영소문자+숫자 </b>조합으로 <b>5~15글자</b> 이내로 입력해주세요</small>
			<div class="invalid-feedback">비밀번호를 확인 하세요 (영소문자+숫자 조합으로 5~15글자 이내로 입력해주세요)</div>
			<div class="valid-feedback">사용가능한 비밀번호 입니다.</div>
		</div>
		<div class="form-group" id="form-pwd2">
			<input class="form-control" type="password" id="pwd2" placeholder="비밀번호 확인" />
			<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
			<div class="valid-feedback">비밀번호가 일치합니다.</div>
		</div>
		<div class="form-group">
			<input class="form-control" type="text" name="name" id="name" placeholder="이름" />
		</div>
		<div class="form-group" id="form-nick">
			<input class="form-control" type="text" name="nick" id="nick" placeholder="닉네임" />
			<small class="form-text text-muted"><b>5~15글자</b> 이내로 입력해주세요</small>
			<div class="invalid-feedback">사용할 수 없는 닉네임 입니다.</div>
			<div class="valid-feedback">사용 가능한 닉네임 입니다.</div>
		</div>
		<div class="form-group">
			<fieldset>
				<p>성별 정보 선택</p>
				<label>
					<input type="radio" name="gender" value="male" checked/>남자
				</label>
				<label>
					<input type="radio" name="gender" value="female" />여자
				</label>
			</fieldset>
		</div>
		<div class="row g-3">
			<div class="col-auto">
				<span>생년월일</span>
				<label for="birth_year"></label>
				<select class="form-control" name="birth_year" id="birth_year">
					<option value="">년도</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
					<c:forEach var="i" begin="1930" end="2021">
						<option value="${i }">${i }</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-auto">
				<label for="birth_month"></label>
				<select class="form-control" name="birth_month" id="birth_month">
					<option value="">월</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
					<c:forEach var="i" begin="1" end="12">
						<option value="${i }">${i }</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-auto">
				<label for="birth_day"></label>
				<select class="form-control" name="birth_day" id="birth_day">
					<option value="">일</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
					<c:forEach var="i" begin="1" end="31"><!-- 일단 31일까지 있다고 가정하고 나중에 구현하기!! -->
						<option value="${i }">${i }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<br />
		<div class="form-group">
			<input class="form-control" type="email" name="email" id="email" placeholder="이메일 예)ebd@acorn.com" />
			<div class="invalid-feedback">이메일 형식을 확인해주세요.</div>
			<div class="valid-feedback">사용가능한 이메일 입니다.</div>
		</div>
		<div class="form-group">
			<input class="form-control" type="text" name="phone" id="phone" placeholder="연락처를 - 없이 입력해주세요" />
			<div class="invalid-feedback">숫자만 입력해주세요.</div>
			<div class="valid-feedback">사용가능한 연락처 입니다.</div>
		</div>		
		<button class="btn btn-outline-primary" type="submit">가입</button>
	</form>
</div>
<script>
	//https://regexr.com/ 테스트는 여기서 해보기 
	//아이디를 검증할 정규 표현 식 (영소문자로 시작해야하고 영소문자,대문자,숫자만 사용가능합니다.5~15글자 이내)
	let reg_id=/^[a-z]{1}[A-Za-z0-9]{4,14}$/;
	//닉네임을 검증할 정규 표현식 (모든 문자 가능 5~15글자 이내)
	let reg_nick=/^.{5,15}$/;
	//비밀번호를 검증할 정규 표현 식(영소문자+숫자 조합으로 5~15글자 이내)
	let reg_pwd=/^(?=.*[0-9]+)[a-z][a-z0-9]{5,15}$/;
	//이메일을 검증할 정규 표현식(@가 포함되어 있는 지 검증, 이메일을 제대로 입력해주세요.)
	let reg_email=/@/; 
	//핸드폰을 검증할 정규 표현식(-를 제외하고 숫자만 입력해주세요)
	let reg_phone=/[0-9]$/;
	
	//아이디 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isIdValid=false;
	//닉네임 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isNickValid=false;
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isPwdValid=false;
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isEmailValid=false;
	//핸드폰 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isPhoneValid=false;
	//이 외 나머지 null값 여부 확인할 변수  
	let isOtherValid=false;
	//폼 전체 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isFormValid=false;

	
	//폼에 submit이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm인 요소에 submit이벤트가 일어났을 때 실행할 함수 등록 
	$("#myForm").on("submit",function(){
				
		//생년월일, 이름이 모두 null이 아닐때 isOtherValid를 true로 바꾼다. 
		if($("#birth_year option:selected").val() != "" 
				&& $("#birth_month option:selected").val() != "" 
				&& $("#birth_day option:selected").val() != ""
				&& $("#name").val() != ""){
			isOtherValid = true;
		}
		
		//폼 전체의 유효성 여부를 얻어낸다. 
		isFormValid = isIdValid&isNickValid&isPwdValid&isEmailValid&isPhoneValid&isOtherValid;
		console.log('isIdValie'+isValidId);
		console.log('isNickValie'+isValidId);
		console.log('isPwdValie'+isValidId);
		console.log('isEmailValie'+isValidId);
		console.log('isPhoneValie'+isValidId);
		console.log('isOtherValie'+isValidId);
		
		//true가 아니면 모두 입력해주세요 라는 알림창과 함께 폼전송을 막는다. 
		if(!isFormValid){
			alert('모두 입력해주세요'); //알림창
			return false; //폼전송을 막는다. 
		}
		
	});
	
	//아이디 중복 & 유효성 검사
	$("#id").on("input", function(){
		//입력한 아이디을 읽어온다.
		let inputId=$("#id").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#id").removeClass("is-valid is-invalid");
		
		//아이디가 정규표현식에 매칭되지 않으면
		if(!reg_id.test(inputId)){
			//아이디가 유효하지 않는다고 표시하고
			$("#id").addClass("is-invalid");
			$("#form-id").children(".invalid-feedback").text("영소문자로 시작하고 영소문자, 대문자, 숫자만 사용해주세요 (5~15글자 이내)");
			//$(".invalid-feedback").text("영소문자로 시작하고 영소문자, 대문자, 숫자만 사용해주세요 (5~15글자 이내)");
			isIdValid=false;
			//함수를 여기서 종료한다.
			return;
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath }/users/checkid.do",
			method : "GET",
			data:"inputId="+inputId,
			success:function(responseData){
				console.log(responseData.isExist);
				if(responseData.isExist){//이미 존재하는 아이디인 경우
					$("#id").removeClass("is-valid is-invalid");
					$("#id").addClass("is-invalid");
					$("#form-id").children(".invalid-feedback").text("이미 존재하는 아이디입니다.");
					isIdValid=false;
				}else{ //존재하지 않는 아이디 즉 사용하지 않는 아이디인 경우
					$("#id").removeClass("is-valid is-invalid");
					$("#id").addClass("is-valid");
					//아이디가 유효하다고 표시한다.
					isIdValid=true;
				}
			}
		})
		
	
	});
	
	
	//닉네임 중복 & 유효성 검사
	$("#nick").on("input", function(){
		//입력한 닉네임을 읽어온다.
		let inputNick= $("#nick").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#nick").removeClass("is-valid is-invalid");
		
		//닉네임이 정규표현식에 매칭되지 않으면
		if(!reg_nick.test(inputNick)){
			//닉네임이 유효하지 않는다고 표시하고
			$("#nick").addClass("is-invalid");
			$("#form-nick").children(".invalid-feedback").text("5글자~15글자 이내로 입력해주세요.");
			isNickValid=false;
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
					//닉네임이 유효하다고 표시한다.
					isNickValid=true;
				}
			}
		})
	});
	
	//비밀번호 유효성 검사(정규식 & 두 비밀번호 일치여부)
	$("#pwd, #pwd2").on("input", function(){
		//입력한 두 비밀번호를 읽어온다.
		let pwd=$("#pwd").val();
		let pwd2=$("#pwd2").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#pwd, #pwd2").removeClass("is-valid is-invalid");
		
		//비밀번호가 정규표현식에 매칭되지 않으면
		if(!reg_pwd.test(pwd)){
			//비밀번호가 유효하지 않는다고 표시하고
			$("#pwd").addClass("is-invalid");
			$("#form-pwd").children(".invalid-feedback").text("영소문자+숫자 조합으로 5~15글자 이내로 입력해주세요.");
			isPwdValid=false;
			//함수를 여기서 종료한다.
			return;
		}else{
			//매칭되면
			$("#pwd").addClass("is-valid");
		}
		

		//두 비밀번호가 같은지 확인하고
		if(pwd==pwd2){//만일 같으면
			//유효하다는 클래스를 추가한다.
			$("#pwd2").addClass("is-valid");
			isPwdValid=true;
		}else{//다르면 
			//유효하지 않다는 클래스 추가
			$("#pwd2").addClass("is-invalid");
			isPwdValid=false;
		}
		
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