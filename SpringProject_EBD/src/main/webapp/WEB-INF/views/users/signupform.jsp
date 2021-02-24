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
	<h1>회원 가입 폼 입니다.</h1>
	<!-- 
		[ novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기 ]
		<input type="email" />  같은경우 웹브라우저가 직접 개입하기도 한다.
		해당기능 사용하지 않기 위해서는 novalidate 를 form 에 명시해야 한다. 
	 -->
	<form action="signup.do" method="post" id="myForm" novalidate>
		
		<label for="id"></label>
		<input type="text" name="id" id="id" placeholder="아이디" /><br />
		<label for="pwd"></label>
		<input type="password" name="pwd" id="pwd" placeholder="비밀번호" /><br />
		<label for="pwd2"></label>
		<input type="password" id="pwd2" placeholder="비밀번호 확인" /><br />
		<label for="name"></label>
		<input type="text" name="name" id="name" placeholder="이름" /><br />
		<label for="nick"></label>
		<input type="text" name="nick" id="nick" placeholder="닉네임" /><br />
		<fieldset>
			<legend>성별 정보 선택</legend>
			<label>
				<input type="radio" name="gender" value="male" checked/>남자
			</label>
			<label>
				<input type="radio" name="gender" value="female" />여자
			</label>
		</fieldset>
		<label for="birth_year"></label>
		<select name="birth_year" id="birth_year">
			<option value="birth_year">년도</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
			<c:forEach var="i" begin="1930" end="2021">
				<option value="${i }">${i }</option>
			</c:forEach>
		</select>
		<label for="birth_month"></label>
		<select name="birth_month" id="birth_month">
			<option value="">월</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
			<c:forEach var="i" begin="1" end="12">
				<option value="${i }">${i }</option>
			</c:forEach>
		</select>
		<label for="birth_day"></label>
		<select name="birth_day" id="birth_day">
			<option value="">일</option><!-- 아무것도 선택하지 않으면 빈 문자열이 서버로 전송된다. -->
			<c:forEach var="i" begin="1" end="31"><!-- 일단 31일까지 있다고 가정하고 나중에 구현하기!! -->
				<option value="${i }">${i }</option>
			</c:forEach>
		</select><br />
		<label for="email"></label>
		<input type="email" name="email" id="email" placeholder="이메일" /><br />
		<label for="phone"></label>
		<input type="text" name="phone" id="phone" placeholder="핸드폰 - 없이 입력.." /><br />
		<button type="submit">가입</button>
	</form>
</div>

</body>
</html>