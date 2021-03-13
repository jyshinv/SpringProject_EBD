<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>비밀번호 수정 </h1>
	<form action="pwd_update.do" method="post" id="myForm" novalidate>
		<div class="form-group">
			<input class="form-control" type="password" name="pwd" id="pwd" placeholder="비밀번호" />
		</div>
		<div class="form-group" id="form-newPwd">
			<input class="form-control" type="password" name="newpwd" id="newPwd" placeholder="새 비밀번호" />
			<small class="form-text text-muted"><b>영소문자+숫자 </b>조합으로 <b>5~15글자</b> 이내로 입력해주세요</small>
			<div class="invalid-feedback">비밀번호를 확인 하세요 (영소문자+숫자 조합으로 5~15글자 이내로 입력해주세요)</div>
			<div class="valid-feedback">사용가능한 비밀번호 입니다.</div>
		</div>
		<div class="form-group" id="form-newPwd2">
			<input class="form-control" type="password" id="newPwd2" placeholder="새 비밀번호 확인" />
			<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
			<div class="valid-feedback">비밀번호가 일치합니다.</div>
		</div>
		<button type="submit" class="btn btn-outline-primary">수정</button>
		<button type="reset" class="btn btn-outline-danger" >취소</button>
	</form>
</div>
<script>

	//비밀번호를 검증할 정규 표현 식(영소문자+숫자 조합으로 5~15글자 이내)
	let reg_newPwd=/^(?=.*[0-9]+)[a-z][a-z0-9]{5,15}$/;
	
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여
	let isnewPwdValid=false;
	
	//폼에 submit이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm인 요소에 submit이벤트가 일어났을 때 실행할 함수 등록 
	$("#myForm").on("submit",function(){
		
		//true가 아니면 모두 입력해주세요 라는 알림창과 함께 폼전송을 막는다. 
		if(!isnewPwdValid){
			alert('입력 오류'); //알림창
			return false; //폼전송을 막는다. 
		}
		
	});
	
	//비밀번호 유효성 검사(정규식 & 두 비밀번호 일치여부)
	$("#newPwd, #newPwd2").on("input", function(){
		//입력한 두 비밀번호를 읽어온다.
		let newPwd=$("#newPwd").val();
		let newPwd2=$("#newPwd2").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#newPwd, #newPwd2").removeClass("is-valid is-invalid");
		
		//비밀번호가 정규표현식에 매칭되지 않으면
		if(!reg_newPwd.test(newPwd)){
			//비밀번호가 유효하지 않는다고 표시하고
			$("#newPwd").addClass("is-invalid");
			$("#form-newPwd").children(".invalid-feedback").text("영소문자+숫자 조합으로 5~15글자 이내로 입력해주세요.");
			isnewPwdValid=false;
			//함수를 여기서 종료한다.
			return;
		}else{
			//매칭되면
			$("#newPwd").addClass("is-valid");
		}
		

		//두 비밀번호가 같은지 확인하고
		if(newPwd==newPwd2){//만일 같으면
			//유효하다는 클래스를 추가한다.
			$("#newPwd2").addClass("is-valid");
			isnewPwdValid=true;
		}else{//다르면 
			//유효하지 않다는 클래스 추가
			$("#newPwd2").addClass("is-invalid");
			isnewPwdValid=false;
		}
		
	});
</script>
</body>
</html>