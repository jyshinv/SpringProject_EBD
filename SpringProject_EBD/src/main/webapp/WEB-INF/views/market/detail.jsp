<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/detail</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<div class="card mb-3">
		<!-- 프로필 이미지 -->
		
		<h5 class="card-title">${dto.writer }</h5>
		<img class="card-img-top" src="${pageContext.request.contextPath }${dto.imgpath}"
		  	alt="Card image cap">
		  	  	
		<div class="card-body">
	  		<p class="card-text">${dto.salesType } <strong>|</strong> ${dto.salesStatus }</p>
	  		<!-- 디테일 페이지에서 수정 할 수 있게 만들기 -->
	  		<c:if test="${dto.writer eq nick }">
	  			<p class="card-text">
		  			<form action="${pageContext.request.contextPath }/market/private/updateStatus.do" method="post">
		  				<input type="hidden" name="num" value="${dto.num }"/>
		  				<table>
		  					<td>
		  						
		  						<select class="form-control" name="salesStatus" id="salesStatus" >
									<option selected >${dto.salesStatus }</option>
									<option>판매 완료</option>
						 		</select>
		  					</td>
		  					<td>
		  						<button class="btn btn-secondary" type="submit">판매상태 저장 하기</button>
		  					</td>
		  				</table>
		  				<p class="card-text"><small class="text-muted">판매 유형을 변경 하고 싶으시면 변경해주세요</small></p>
		  			</form>
		  		</p>
	  		</c:if>
	  	
	  		<p class="card-text"><strong>${dto.title }</strong></p>
		    <p class="card-text">${dto.content }</p>
		    <p class="card-text"><small class="text-muted">${dto.regdate }</small></p>
		</div>	
	</div>
	
	<!-- 작성자만 보이게-->
	    <c:if test="${dto.writer eq nick }">
		    <div class="btnStyle">
		    	<a href="${pageContext.request.contextPath }/market/private/updateform.do?num=${dto.num}" class="btn btn-dark" >
			 		수정</a>
				<a href="${pageContext.request.contextPath }/market/private/delete.do?num=${dto.num}" class="btn btn-dark">
					삭제</a>
		    </div>
	    </c:if>	
</div>
</body>
</html>