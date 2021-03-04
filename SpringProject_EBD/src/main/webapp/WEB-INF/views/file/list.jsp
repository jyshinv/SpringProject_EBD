<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>독후감 양식 파일 공유(업로드/다운로드) 리스트</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.card{
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
</style>
</head>
<body>

<div class="container">
	<a href="${pageContext.request.contextPath }">홈으로 돌아가기</a>
		
	<!-- 검색기능 추가 -->
	<form action="list.do" method="get">
		<a href="${pageContext.request.contextPath }/file/private/insertform.do" class="btn btn-info">
		파일 업로드</a>
		
		<label for="condition"><strong>검색 조건</strong></label>
		<select name="condition" id="condition">
			<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
			<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
		</select>
		
		<div class="input-group mb-3">
		  <input value="${keyword }" type="text" name="keyword" placeholder="검색어..."
		  	 class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2">
		  <div class="input-group-append">
		    <button class="btn btn-outline-secondary" type="submit">검색</button>
		  </div>
		</div>
		
	</form>
	
	<c:forEach var="tmp" items="${list }">
		<div class="card">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}">
					${tmp.title }</a>
					${tmp.writer }
				</li>
			</ul>
		</div>
	</c:forEach>
	
	<!-- 하단에 페이징 -->
	<div class="page-display">
		<ul class="pagination pagination-sm justify-content-center">
		<c:if test="${startPageNum ne 1 }">
			<li class="page-item"><a class="page-link" href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">Prev</a></li>
		</c:if>
		<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
			<c:choose>
				<c:when test="${i eq pageNum }">
					<li class="page-item active"><a class="page-link" href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${endPageNum lt totalPageCount }">
			<li class="page-item"><a class="page-link" href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">Next</a></li>
		</c:if>
		</ul>
	</div>
	
</div>

</body>
</html>