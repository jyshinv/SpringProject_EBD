<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 게시글-북클라우드</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>	
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
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
    /*파일 리스트 카드*/
     .file-list{
    	background-color: #FEFCF4; 
    	padding-top:20px;
    	padding-bottom:0px;
    }
	/*등록일 스타일*/
    .reg-style{
    	 color:gray;
    	 padding-top:3px;
    }
    
     #card-width{
    	width: 950px;
    	margin-bottom:30px;
    }
       
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_write" name="thisPage"/>
</jsp:include>
<div class="container">
	<form action="my_write_category.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-8">
				<select class="form-control" name="condition" id="condition">
					<option value="wording">조각글</option>
					<option value="episode">에피소드</option>
					<option value="market">북스마켓</option>
					<option value="file" selected>북클라우드</option>
				</select>
			</div>
			<span>
				<button id="button" class="btn" >이동</button>
			</span>
		</div>
	</form>	

	<div id="fileList">
		<!-- 반복문 돌려서 목록 출력 --> 	
		<c:forEach var="tmp" items="${list }">
			<div class="container" id="card-width">
				<div class="card card-margin">
					<ul class="list-group list-group-flush">
						<li class="list-group-item file-list">
							<div class="row">
								<div class="col-1 text-left">
									<span class="viewcnt">
								    	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="grey" class="bi bi-eye" viewBox="0 0 16 16" style="margin-bottom: 5px;">
										  <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
										</svg>&nbsp;${tmp.viewcnt }
							    	</span>
								</div>
							    <div class="col-md-6">
							    	<c:choose>
							    		<c:when test="${empty tmp.title }">
									    	<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}" style="color:black;">
												<strong>제목없음</strong></a>
							    		</c:when>
							    		<c:otherwise>
									    	<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}" style="color:black;">
												<strong>${tmp.title }</strong></a>
							    		</c:otherwise>
							    	</c:choose>
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
							      	<p class="reg-style">
										<small>
											<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="gray" class="bi bi-calendar2-check" viewBox="0 0 16 16">
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
			</div> <!-- fileList안의 container -->
		</c:forEach>
	</div>
	

	<!-- 하단에 페이징 -->
	<nav>
		<ul class="pagination justify-content-center" style="margin-top: 32px;margin-bottom: 32px;">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
					<li class="page-item">
						<a class="page-link" href="my_write_category.do?pageNum=${startPageNum-1 }&condition=file">Prev</a>
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
							href="my_write_category.do?pageNum=${i }&condition=file">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link"
							href="my_write_category.do?pageNum=${i }&condition=file">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="my_write_category.do?pageNum=${endPageNum+1 }&condition=file">Next</a>
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