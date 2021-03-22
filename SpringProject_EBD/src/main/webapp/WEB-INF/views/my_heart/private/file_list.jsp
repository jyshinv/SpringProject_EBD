<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>	
	/*버튼 관련 css*/
	/*버튼 기본 노랑*/
    .btn{
    	background-color:#F7DC6F;
    	/*color:sienna;*/
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
    	/*color:sienna;*/
    }
    /*버튼안에 링크 걸려있을시 적용할 css*/
    .btn>a{
    	color:#212529;
    	/*color:sienna;*/
    }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn>a:hover{
    	color:#212529;
    	text-decoration:none;
    }  
    
    /*리스트 관련 css*/
    .card-margin{
		margin-top: 30px;
		margin-bottom: 30px;
		border:none;
	}
	
	.heart-link,
	.heart-link:hover{
      font-size : 1.5em;
      color: red;
      text-decoration: none;
   }
   
   	.heart-link-logout{
   		font-size : 1.5em;
   		color:grey;
   	}
   	.heart-cnt-logout{
   		color:grey;
   	}   
   
   /* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 25px;
      height: 25px;
      border-radius: 50%;
   }
   
    /* page-item active 색상 변경 */
    .page-item.active .page-link{
    	background-color:#F7DC6F;
    	border-color:#F7DC6F;
    } 
    .page-link:hover{
    	color:#212529;
    	background-color:#FBEEE6;
    	border-color:#FBEEE6;
    }
    .page-link{
    	color:#212529;
    }
       
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_heart" name="thisPage"/>
</jsp:include>
<div class="container">
	<form action="my_heart_category.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-8">
				<select class="form-control" name="condition" id="condition">
					<option value="wording">명언/글귀</option>
					<option value="episode">에피소드</option>
					<option value="market">마켓</option>
					<option value="file" selected>파일</option>
				</select>
			</div>
			<span>
				<button id="button" class="btn btn-light" style="background-color:#F7DC6F;">이동</button>
			</span>
		</div>
	</form>	

	<div id="fileList">
		<!-- 반복문 돌려서 목록 출력 --> 	
		<c:forEach var="tmp" items="${list }">
			<div class="card card-margin">
				<ul class="list-group list-group-flush">
					<li class="list-group-item" style="background-color: #FEFCF4; padding-top:20px;">
						<div class="row">
						    <div class="col-md-6">
						    	<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}" style="color:black;">
									<strong>${tmp.title }</strong></a>
								
						    </div>
						    <div class="col text-right">
						    	<!-- 프로필 이미지 -->
								<c:choose>
					               <c:when test="${empty tmp.profile }">
					                  <!-- 비어있다면 기본이미지 -->
					                  <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
					                       <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
					                  </svg>
					               </c:when>
					               <c:otherwise>
					                  <!-- 이미지를 업로드 했다면 업로드한 이미지를 불러온다.-->
					                  <img id="profileImage" src="${pageContext.request.contextPath }${tmp.profile}"/>
					               </c:otherwise>
			            		</c:choose>
						      	<strong>${tmp.writer }</strong>
						      	<p>
									<small>
										<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 0 16 16">
										  <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
										  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
										  <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
										</svg> 
										<span>&nbsp;${tmp.regdate }</span>
									</small> 
								</p>
						    </div>
						 </div>
					 </li>
				</ul>
			</div> <!-- card -->
			
		</c:forEach>
	</div>
	

	<!-- 하단에 페이징 -->
	<nav>
		<ul class="pagination justify-content-center" style="margin-top: 32px;margin-bottom: 32px;">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
					<li class="page-item">
						<a class="page-link" href="my_heart_category.do?pageNum=${startPageNum-1 }&condition=file">Prev</a>
					</li>
				</c:when>
				<c:otherwise>	
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<c:choose>
					<c:when test="${i eq requestScope.pageNum }">
						<li class="page-item active">
							<a class="page-link"
							href="my_heart_category.do?pageNum=${i }&condition=file">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link"
							href="my_heart_category.do?pageNum=${i }&condition=file">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="my_heart_category.do?pageNum=${endPageNum+1 }&condition=file">Next</a>
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