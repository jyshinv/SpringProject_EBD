<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Detail</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.btnStyle{
		text-align: center;
		margin-bottom: 20px;
	}
</style>
</head>
<body>
<!-- 독후감 양식 파일 공유(업로드/다운로드) 디테일 -->
<div class="container">
	
	<div class="card mb-3">
		<!-- 프로필 이미지 -->
		
		<h5 class="card-title">${dto.writer }</h5>
		<img class="card-img-top" src="${pageContext.request.contextPath }${dto.imgpath}"
		  	alt="Card image cap">
		  	  	
		<div class="card-body">
	  		<p class="card-text">
	  			<strong>파일명</strong> ${dto.orgfname } <strong>|</strong> 
	  			<fmt:formatNumber value="${dto.fileSize }" pattern="#,###"/><strong>byte</strong>
	  			<a class="btn btn-secondary" href="download.do?num=${dto.num }">다운로드 </a>
	  		</p>
	  		<p class="card-text">${dto.title }</p>
		    <p class="card-text">${dto.content }</p>
		    <p class="card-text"><small class="text-muted">${dto.regdate }</small></p>
		</div>
		 
	 	<!-- 작성자만 보이게-->
	    <c:if test="${dto.writer eq nick }">
		    <div class="btnStyle">
		    	<a href="${pageContext.request.contextPath }/file/private/updateform.do?num=${dto.num}" class="btn btn-dark" >
			 		수정</a>
				<a href="${pageContext.request.contextPath }/file/private/delete.do?num=${dto.num}" class="btn btn-dark">
					삭제</a>
		    </div>
	    </c:if>		
	</div>
	
	<!-- 페이징 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${dto.prevNum ne 0 }">
					<li class="page-item mr-3">
						<a class="page-link" href="detail.do?num=${dto.prevNum }">&larr; Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled mr-3">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${dto.nextNum ne 0 }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${dto.nextNum }">Next &rarr;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
	
</div>
	<!-- 댓글 -->
	<!-- 댓글 페이징 -->


</body>
</html>