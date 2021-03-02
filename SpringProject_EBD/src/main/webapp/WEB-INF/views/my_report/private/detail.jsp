<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/my_report/private/detail.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	img{
		width:800px;
	}
</style>
</head>
<body>
<div class="container">
	<a href="${pageContext.request.contextPath}/my_report/private/list.do">독후감 목록가기</a>
	<table class="table">
		<tr>
			<td>조회수 ${dto.viewcnt }</td>
			<td>날짜 ${dto.regdate }</td>
		</tr>
		<center>
			<img src="${pageContext.request.contextPath }${dto.imgpath }"/>
		</center>
		<tr>
			<th>제목</th>
			<td>${dto.title }</td>
		</tr>
		<tr>
			<th>도서명</th>
			<td>${dto.booktitle }</td>
		</tr>
		<tr>
			<th>저자명</th>
			<td>${dto.author }</td>
		</tr>
		<tr>
			<th>장르</th>
			<td>${dto.genre }</td>
		</tr>
		<tr>
			<th>별점</th>
			<td>${dto.stars }</td>
		</tr>
		<tr>
			<th>구매처 링크</th>
			<td>${dto.link }</td>
		</tr>
		<tr>
			<th></th>
			<td>${dto.content }</td>
		</tr>
	</table>
	<c:if test="${dto.writer eq nick }">
		<button>
			<a href="${pageContext.request.contextPath }/my_report/private/updateform.do?num=${dto.num}"/>수정</a>
		</button>
		<button>
			<a href="javascript:deleteConfirm()">삭제</a>
		</button>
	</c:if>
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
<script>
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/my_report/private/delete.do?num=${dto.num}";
		}
	}
</script>	
</body>
</html>