<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<a href="${pageContext.request.contextPath}/public_report/list.do">독후감 목록가기</a>
	<table class="table">
		<tr>
			<td>조회수 ${dto.viewcnt }</td>
			<td>날짜 ${dto.regdate }</td>
			<td>
            <form action="update.do">
          		<select name="publicck" id="publicck">
          		<c:choose>
          			<c:when test="${dto.publicck eq 'private' }">
	          			<option value="private" selected="selected">비공개</option>
          				<option value="public">공개</option>
          			</c:when>
          			<c:otherwise>
          				<option value="public" selected="selected">공개</option>
          				<option value="private">비공개</option>
          			</c:otherwise>
          		</c:choose>
          		</select>
          		<input type="submit" value="선택"/>
          	</form>
       		</td>
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
			<td><a href="${dto.link }"><b>${dto.booktitle } </b>네이버 도서로 바로가기</a></td>
		</tr>
		<tr>
			<th></th>
			<td>${dto.content }</td>
		</tr>
	</table>
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
</body>
</html>