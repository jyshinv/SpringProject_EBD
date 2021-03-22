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
    
    /*마켓 리스트 관련 css*/
    /* card 이미지 부모요소의 높이 지정 */
	.img-wrapper{
		height: 315px;
		/* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
		transition: transform 0.3s ease-out;
	}
	
	/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
	.img-wrapper:hover{
		opacity: 0.3;
	}
	
	.card .card-text{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
		color:grey;
	}
	#text-writer{
		color:black;
	}
	
	#img{
		object-fit: cover;
		background-position:center;
	}
	
	/* card */
	.card{
		margin: 30px;
	}
	
	.card-title{
		padding-top:10px;
		padding-left:5px;
	}
	
	/* 하트 */
	.heart-link,
	.heart-link:hover{
		font-size: 1.8em;
		color: red;
		text-decoration: none;
   }
   	.heart-link-logout{
   		font-size : 1.8em;
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
   
   .badge{
   		padding: 5px;
   		margin-right: 5px;
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
    .card-head{
	    margin-left: 0px;
	    margin-right: 0px;
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
	<!-- 카테고리 이동 -->
	<form action="my_heart_category.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-8">
				<select class="form-control" name="condition" id="condition">
					<option value="report">공개독후감</option>
					<option value="wording">명언/글귀</option>
					<option value="episode">에피소드</option>
					<option value="market" selected>마켓</option>
					<option value="file">파일</option>
				</select>
			</div>
			<span>
				<button id="button" class="btn btn-light" style="background-color:#F7DC6F;">이동</button>
			</span>
		</div>
	</form>	
		
	<!-- 목록 -->
	<div class="row">
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
      	<%int isCheck=0; %>
		<!-- 반복문 돌려서 목록 출력 --> 	
		<c:forEach var="tmp" items="${marketList }">
			<div class="card" style="width: 20rem;">
				<div class="card-title">
					<div class="row card-head">
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
	            		<p class="card-text col" id="text-writer">
	            			<strong>${tmp.writer } <!-- 작성자 --></strong>
	            		</p>
					</div>
				</div><!-- card title -->
				
				<!-- 이미지를 누르면 디테일 페이지 이동 -->
				<a href="${pageContext.request.contextPath }/market/detail.do?num=${tmp.num }">
					<!-- 이미지 -->
					<div>	
						<img class="card-img-top img-wrapper" src="${pageContext.request.contextPath }${tmp.imgpath }" id="img">
					</div>
				</a>
				<div class="card-body">
					<div class="row">
						<div class="col" style="padding-top: 10px;">
							<p class="card-text">
								<!-- 판매 유형 -->
								<span class="badge badge-pill badge-warning" style="background-color:#F8C471; ">${tmp.salesType }</span>
								<!-- 판매 상태 -->
								<c:choose>
									<c:when test="${tmp.salesStatus eq '판매 완료'}">
										<span class="badge badge-pill badge-secondary" style="background-color:#8D8D8D;" >${tmp.salesStatus }</span>
									</c:when>
									<c:when test="${tmp.salesStatus eq '나눔 완료'}">
										<span class="badge badge-pill badge-secondary" style="background-color:#8D8D8D;">${tmp.salesStatus }</span>
									</c:when>
									<c:when test="${tmp.salesStatus eq '교환 완료'}">
										<span class="badge badge-pill badge-secondary" style="background-color:#8D8D8D;">${tmp.salesStatus }</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-pill badge-success" style="background-color:#DC7633; ">${tmp.salesStatus }</span>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
					<hr />
					<p class="card-text text-center">
						${tmp.title }
					</p>
				</div><!-- card-body -->
			</div>
			<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->   
			<%isCheck++; %>
		</c:forEach>
	</div>
	
	<!-- 하단에 페이징 -->
	<nav>
		<ul class="pagination justify-content-center" style="margin-top: 32px;margin-bottom: 32px;">
			<c:choose>
				<c:when test="${startPageNum != 1}">
					<li class="page-item">
						<a class="page-link" href="my_heart_category.do?pageNum=${startPageNum-1}&condition=market">Prev</a>
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
							href="my_heart_category.do?pageNum=${i }&condition=market">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link"  
							href="my_heart_category.do?pageNum=${i }&condition=market">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount}">
					<li class="page-item">
						<a class="page-link" href="my_heart_category.do?pageNum=${endPageNum+1}&condition=market">Next</a>
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