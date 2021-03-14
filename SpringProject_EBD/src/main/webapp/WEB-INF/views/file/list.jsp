<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.card{
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	.heart-link{
      font-size : 2em;
   }
	
</style>
</head>
<body>
<jsp:include page="../include/navbar2.jsp"></jsp:include>
<div class="container">
	<br />
	<div class="row">
		<div class="col">
			<a href="${pageContext.request.contextPath }/file/private/insertform.do" class="btn btn-info">
			파일 업로드</a>
		</div>
		<div class="col">
			<form action="list.do" method="get">
				<!-- 검색 -->
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
		</div>
	</div>
	
	
	<c:forEach var="tmp" items="${list }">
	
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
      	<%int isCheck=0; %>
      	
      	<!-- 반복문 돌려서 목록 출력 --> 	
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
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<%-- 시작페이지가 1과 같지 않다면 --%>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${startPageNum-1 }">Prev</a>
					</li>
				</c:when>
				<%-- 시작페이지가 1과 같다면 --%>
				<c:otherwise>	
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }" step="1">
				<c:choose>
					<c:when test="${i eq requestScope.pageNum }">
						<li class="page-item active">
							<a class="page-link" href="list.do?pageNum=${i }">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="list.do?pageNum=${i }">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${endPageNum+1 }">Next</a>
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

</body>
</html>