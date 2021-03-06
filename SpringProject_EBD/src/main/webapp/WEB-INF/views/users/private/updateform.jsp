<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
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
		
		border-radius: 50%;
	}
	/* 프로필 업로드 폼을 화면에 안보이게 숨긴다 */
	#profileForm{
		display: none;
	}
	
	.h-style{
		margin-top:50px;
		margin-bottom:20px;
	}
	
	/* 수정 완료 버튼 */
	.btn-style{
		margin-top:20px;
	}
	
	/* 수정 완료 버튼 */
	.update-style{
		margin-top:10px;
		margin-bottom:20px;
	}
	
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<%-- jumborton --%>
<jsp:include page="../../include/updateform_jumbotron.jsp"></jsp:include>
<div class="container">
	<div class="text-center" >
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
	</div>
	<div class="text-center btn-style">
		<button class="btn btn-light" id="profileLink" href="javascript:" 
		style="background-color:#F7DC6F; border:none;">프로필 수정</button>
	</div>
	<form action="profile_upload.do" method="post" 
		enctype="multipart/form-data" id="profileForm">
		<label for="image">프로필 이미지 선택</label>
		<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		<button type="submit">업로드</button>
	</form>
	<br />
	<!-- 개인정보 수정 -->
	<form action="update.do" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id" value="${id }" placeholder="아이디" disabled/>
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" name="name" id="name" value="${dto.name }" placeholder="이름"/>
			<div class="invalid-feedback">이름을 다시 입력해주세요.</div>
		</div>
		<div class="form-group">
			<label for="nick">닉네임</label>
			<input class="form-control" type="text" name="nick" id="nick" value="${nick }" placeholder="닉네임" />
			<small class="form-text text-muted">한글, 영소문자, 대문자, 숫자, 사용가능 (<b>1~6글자</b> 이내로 입력해주세요)</small>
			<div class="invalid-feedback">이미 존재하거나 사용할 수 없는 닉네임 입니다.</div>
		</div>
		<div class="form-group">
			<fieldset>
				<p>성별</p>
				<c:choose>
					<c:when test="${dto.gender eq '남' }">
						<label>
							<input type="radio" name="gender" value="남" checked/>남자&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" name="gender" value="여" />여자&nbsp;&nbsp;
						</label>
					</c:when>
					<c:otherwise>
						<label>
							<input type="radio" name="gender" value="남"/>남자&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" name="gender" value="여" checked/>여자&nbsp;&nbsp;
						</label>
					</c:otherwise>
				</c:choose>
			</fieldset>
		</div>
		<p>생년월일</p>
		<div class="row">
			<div class="col">
				<div class="form-group">	
					<select class="form-control" name="birth_year" id="birth_year">
						<option value="">년도</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
						<%
						Calendar cal = Calendar.getInstance();
						int year=cal.get(Calendar.YEAR);
						%>
						<c:forEach var="i" begin="1930" end="<%=year %>">
							<option value="${i }" <c:if test="${dto.birth_year eq i }">selected</c:if>>${i }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col">
				<div class="form-group">
					<select class="form-control" name="birth_month" id="birth_month">
						<option value="">월</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
						<c:forEach var="i" begin="1" end="12">
							<option value="${i }" <c:if test="${dto.birth_month eq i }">selected</c:if>>${i }</option>
						</c:forEach>
					</select>
				</div>				
			</div>
			<div class="col">
				<div class="form-group">
					<input class="form-control" type="text" name="birth_day" id="birth_day" value="${dto.birth_day }" placeholder="일" />
					<div class="invalid-feedback">생년월일을 확인해주세요</div>
					<div class="valid-feedback">생년월일을 확인해주세요</div>
				</div>
			</div>
		</div>		
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="email" name="email" id="email" value="${dto.email }" placeholder="이메일 예)ebd@acorn.com" />
			<div class="invalid-feedback">이메일 형식을 확인해주세요.</div>
		</div>
		<div class="form-group">
			<label for="email">연락처</label>
			<input class="form-control" type="text" name="phone" id="phone" value="${dto.phone }" placeholder="연락처를 - 없이 입력해주세요" />
			<div class="invalid-feedback">숫자만 입력해주세요.</div>
		</div>		
		<div class="text-center update-style" style="margin-top:30px; margin-bottom:30px;">
			<button type="submit" class="btn btn-light" style="background-color:#F7DC6F; border:none;">
			수정</button>
		</div>
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
	//닉네임을 검증할 정규 표현식 (한글, 영소문자, 대문자 숫자 사용가능 1~6글자 이내 (공백 불가))
	let reg_nick=/^[A-Z|a-z|0-9|가-힣|ㄱ-ㅎ|ㅏ-ㅣ]{1,6}$/;
	//이메일을 검증할 정규 표현식(@가 포함되어 있는 지 검증, 이메일을 제대로 입력해주세요.)
	let reg_email=/@/; 
	//핸드폰을 검증할 정규 표현식(-를 제외하고 숫자만 입력해주세요)
	let reg_phone=/[0-9]$/;
	//이름을 검증할 정규 표현식
	let reg_name=/^[A-Z|a-z|가-힣]{1,20}$/;
	

	//닉네임 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isNickValid=true;
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isEmailValid=true;
	//핸드폰 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isPhoneValid=true;
	//폼 전체 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isFormValid=true;
	//생년월일 중 일자를 관리할 변수 만들고 초기값 부여
	let isBirthValid=true;
	//이름 유효성 여부를 관리할 변수를 만들고 초기값 부여
	let isNameValid=true;
	
	//넘어온 값은 모두 저장 가능한 값이므로 모든 폼을 valid로 만들어준다. 
	$("#nick, #name, #birth_day, #email, #phone").removeClass("is-valid is-invalid");
	$("#nick, #name, #birth_day, #email, #phone").addClass("is-valid");

	//폼에 submit이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm인 요소에 submit이벤트가 일어났을 때 실행할 함수 등록 
	$("#myForm").on("submit",function(){
		
		//폼 전체의 유효성 여부를 얻어낸다. 
		isFormValid = isNickValid&isEmailValid&isPhoneValid&isFormValid&isNameValid;
		
		//true가 아니면 모두 입력해주세요 라는 알림창과 함께 폼전송을 막는다. 
		if(!isFormValid){
			alert('모두 입력해주세요'); //알림창
			return false; //폼전송을 막는다. 
		}
		
	});
	
	//생년월일일 중 년,월에 따라 일을 올바르게 입력했는 지 검사하는 함수 
	function isValidDate(year, month, day) {
      
            if (month < 1 || month > 12) {
                return false;
            }
            var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
            var maxDay = maxDaysInMonth[month - 1];
            // 윤년 체크
            if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
                maxDay = 29;
            }
            if (day <= 0 || day > maxDay) {
                return false;
            }
            return true;
    }
	
	//생년월일 중 일자를 입력할 때 유효성 검사하기 
	$("#birth_day").on("input",function(){
		
		var year=$("#birth_year option:selected").val();
		var month=$("#birth_month option:selected").val();
		
		//월과 일을 먼저 쓰도록 한다. 
		if(year == "" || month == ""){
			$("#birth_day").val("");
			alert('년, 월을 먼저 입력해주세요!');
		}
		var day=$("#birth_day").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#birth_day").removeClass("is-valid is-invalid");
		
		
		//생년월일 검사 후 false면 isBirthValid를 false로 만들어주고 함수를 끝내준다. 
		if(!isValidDate(year, month, day)){
			$("#birth_day").addClass("is-invalid");
			isBirthValid=false;
			return;
		}else{
			//검사가 true이면 isBirthValid를 true로 바꾸고 검증클래스를 추가한다.
			$("#birth_day").addClass("is-valid");
			isBirthValid=true;			
		}
		
        
		 
		
	});

	//닉네임 중복 & 유효성 검사
	$("#nick").on("keyup", function(){
		//입력한 닉네임을 읽어온다.
		let inputNick= $("#nick").val();
		let inputBeforeNick="${nick }";
		let ischeck=0;
		
		//일단 모든 검증 클래스를 제거하고
		$("#nick").removeClass("is-valid is-invalid");
		
		//닉네임이 정규표현식에 매칭되지 않으면
		if(!reg_nick.test(inputNick)){
			//닉네임이 유효하지 않는다고 표시하고
			$("#nick").addClass("is-invalid");
			isNickValid=false;
			//함수를 여기서 종료한다.
			return;
		}
		
		//입력을 했으나 기존의 닉네임의 경우네는 기존의 닉네임이라고 알려준다. 
		if(inputNick==inputBeforeNick){
			$("#nick").addClass("is-valid");
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
					$("#nick").addClass("is-invalid");
					isNickValid=false;
				}else{ //존재하지 않는 닉네임 즉 사용하지 않는 닉네임인 경우
					//닉네임이 유효하다고 표시한다.
					$("#nick").addClass("is-valid");
					isNickValid=true;
				}
			}
		})
			
		
	});
	
	//이름 유효성 검사 
	$("#name").on("input", function(){
		//입력한 이름를 읽어온다.
		let name=$("#name").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#name").removeClass("is-valid is-invalid");
		
		//이름이 정규표현식에 매칭되지 않으면
		if(!reg_name.test(name)){
			//이름이 유효하지 않는다고 표시하고
			$("#name").addClass("is-invalid");
			isNameValid=false;
			//함수를 여기서 종료한다.
			return;
		}else{
			isNameValid=true;
			$("#name").addClass("is-valid");
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


