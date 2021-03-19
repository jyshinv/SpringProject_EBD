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
	/* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   /* 제목 간격 띄우기 */
   h1{
   		margin-top:30px;
   }
   .card-header{
   		background-color:rgba(0, 0, 0, 0);
   }
   /*카드 안쪽 내용 양옆 간격 조절*/	
   .card{
   	padding-left:20px;
   	padding-right:20px;
   }
   .centerimg img{
   	max-width: 100%;
   }
   .marg{
   	margin-bottom:20px;
   }
   #checkBtn{
   	padding-top:0px;
   	padding-bottom:10px;
   	padding-left:0px;
   	padding-right:0px;
   }  
   /*
   #publicck{
   		border:1px #FFE8B9 solid;
   		border-radius: 7%;
   }
   */
   .page-link:hover{
   		background-color:#FBEEE6;
   }
   .page-link{
   		background-color:#F7DC6F;
   }
   /* 모든 a링크의 hover 색깔 변경 (임시) */
   a:hover,
   .link>a:hover{
   		color:#F7DC6F;
   		text-decoration: none;
   }
   /* 뷰카운트, 날짜 글자색 변경 */
   #view-reg{
   		color:grey;
   }
   /* 구매처 링크 노란색 (버튼색과 다름) / 공개 비공개 체크 버튼에도 동일하게 구현 */
   .link>a,
   .page-link,
   .page-link:hover{
   		color:#212529;
   }
   .page-link{
   		border:none;
   }
   .page-link:hover{
   		text-decoration: none;
   }
   th{
   		color:grey;
   }
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<div class="container">
	<div class="card">
		<div class="row card-header">
			<span class="col-1">
				<c:choose>
			        <c:when test="${empty dto.profile }">
			           <!-- 비어있다면 기본이미지 -->
			           <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
			                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
			           </svg>
			        </c:when>
			        <c:otherwise>
			           <!-- 이미지를 업로드 했다면 업로드한 이미지를 불러온다.-->
			           <img id="profileImage" src="${pageContext.request.contextPath }${dto.profile}"/>
			        </c:otherwise>
			     </c:choose>
			</span>
			<span class="col" style="padding-top: 15px; padding-left: 0px;">
			    <b>${dto.writer }</b>
			</span>
		</div>
		<div class="text-center marg">
			<h1>${dto.title }</h1>
		</div>
		<div class="text-right marg" id="view-reg">
			<span>
				<small>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
					  <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
					  <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
					</svg> 
					<span>
						&nbsp;${dto.viewcnt }
					</span>
				</small>
			</span>
			&nbsp;&nbsp;
			<span>
				<small>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 0 16 16">
					  <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
					  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
					  <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
					</svg> 
					<span>&nbsp;${dto.regdate }</span>
				</small>
			</span>
		</div>
		<div class="marg">
			<center class="centerimg">
				<img src="${pageContext.request.contextPath }${dto.imgpath }"/>
			</center>
		</div>
		<div class="row" style="height:50px;">
			<div class="col text-left">
				<c:if test="${dto.writer eq nick }">
					&nbsp;
					<button class="btn btn-link" id="checkBtn">
						<a href="${pageContext.request.contextPath }/my_report/private/updateform.do?num=${dto.num}"/>
							<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-pencil icon" viewBox="0 0 16 16" style="color:#FFCA28;">
  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
</svg>
						</a>
					</button>
					<button class="btn btn-link" id="checkBtn">
						<a href="javascript:deleteConfirm()">
							<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-trash icon" viewBox="0 0 16 16" style="color:#FFCA28;">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
</svg>
						</a>
					</button>
				</c:if>
			</div>
			<div class="col text-right marg">
		        <form action="updatepublicck.do">
		      		<label for="publicck"></label>
		      		<select name="publicck" id="publicck" >
		      		<c:choose>
		      			<c:when test="${dto.publicck eq 'private' }">
		       			<option value="private">비공개</option>
		      				<option value="public">공개</option>
		      			</c:when>
		      			<c:otherwise>
		      				<option value="public">공개</option>
		      				<option value="private">비공개</option>
		      			</c:otherwise>
		      		</c:choose>
		      		</select>
		      		<label for="num"></label>
		      		<input type="hidden" value="${dto.num }" id="num" name="num"/>
		      		<button type="submit" class="btn btn-link" id="checkBtn">
		      			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16" style="color:#FFCA28;">
						  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
						  <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
						</svg>
		      		</button>
		      	</form>
		     </div>
		</div>
		<table class="table">
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
				<td class="link"><a href="${dto.link }"><b>${dto.booktitle } </b>네이버 도서로 바로가기</a></td>
			</tr>
		</table>
		<div class="marg">
			${dto.content }
		</div>
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