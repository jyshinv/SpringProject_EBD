<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Every Book Day</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	*{
		font-family: 'Gothic A1', sans-serif;
	}
	.search_form{
		margin-top:16px;
	}
	h4{
		color: #4F708B;
		text-align: center;
		font-weight:bold;
	}
	/*요소를 가운대로*/
	.center{
		text-align: center;
	}

	.wording-img{
		width: 140px;
      	height: 140px;
      	border-radius: 50%;
      	margin-bottom:20px;
	}
	.card .card-deck{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	.card{
		/*카드 배경색 줄지 말지 고민*/
		/*background-color: #FEFCF4;*/
		/*border:none;*/
	}
	#img{
		object-fit: cover;
		background-position:center;
	}
	.img-wrapper{
		height: 320px;
		
	}
	/* 프로필 이미지를 작은 원형으로 만든다 */
   	#profileImage{
      width: 25px;
      height: 25px;
      border-radius: 50%;
   	}
   /*조회수 아이콘*/
   .viewcnt{
    	color:grey;
    }
    /*BEST*/
   .badge-size{
   		font-size : 15px;
   		padding:10px;
   		margin-top: 10px;
   }
   #badge-color{
   
   	background-color:#6DB286;
   }
   .center-2{
		text-align: center;
		margin-top: 5px;
	}
	
	.best{
		animation: motion 0.4s linear 0s infinite alternate; margin-left: 0;
	}
	
	@keyframes motion {
		   0% {margin-left: 0px;}
		   100% {margin-left: 15px;}
		}
	
</style>
</head>
<body>
<%-- nav bar --%>
<jsp:include page="include/navbar.jsp"></jsp:include>
	
<%-- jumborton --%>
<jsp:include page="include/jumbotron.jsp"></jsp:include>

<div class="container">
	<%-- 명언 BEST 제목 --%>
	<h4>하트 TOP 3  조각글 </h4>
	<p class="center">북스님들에게 가장 많은 하트를 받은 조각글</p>
	<br />
	<!-- 명언 BEST 내용 -->
	<div class="container marketing">
		<div class="row">
			<c:forEach var="i" begin="0" end="2">
				<!-- 글이 없으면 기본 문구 삽입, 글이 있으면 글을 삽입  -->
				<c:choose>
					<c:when test="${empty wordingBestList[i] }">
						<div class="col-lg-4 text-center">
							<p>
								<span class="badge badge-pill badge-secondary badge-size">
								BEST ${i+1 }</span>
							</p>
							<p>♡</p>
							<img class="card-img-top wording-img" src="https://i.pinimg.com/originals/95/a5/10/95a51074afed9b72b537b78b94f0a041.jpg" alt="Card image cap">
					        <h5>아직 준비가 되지 않았어요! </h5>
					        <p>여러분들의 참여 부탁드립니당!</p>
					       	 <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
						</div>
					</c:when>
					<c:otherwise>
						 <div class="col-lg-4 text-center">
						 	<p class="best">
								<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
								BEST ${i+1 }</span>
							</p>
					      	<p>♥ ${wordingBestList[i].heartcnt }</p>
							<img class="card-img-top wording-img" src="${pageContext.request.contextPath }${wordingBestList[i].profile}" alt="Card image cap">
					      	<p><strong>${wordingBestList[i].writer }</strong></p>
					        <a href="${pageContext.request.contextPath }/wording/detail.do?num=${wordingBestList[i].num }"></a>
					        <p>${wordingBestList[i].content } </p>
					      	<p> <footer class="blockquote-footer">${wordingBestList[i].title } ,<cite id="font" title="Source Title">${wordingBestList[i].author }</cite></footer></p>
					     </div>
					</c:otherwise>
				</c:choose>
			</c:forEach>			     
		</div>
	</div>
	<br />
	<p class="center">
		<a class="btn btn-outline-secondary btn-sm" style="border-radius:20px;" href="${pageContext.request.contextPath }/wording/list.do">
		더 보러가기 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
		  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
		</svg>
		</a>
	</p>
	<br /><br /><br />
    <%-- 독후감 BEST 제목 --%>
    <h4>하트 TOP 3  독후감</h4>
	<p class="center">북스님들에게 가장 많은 하트를 받은 독후감</p>
	<br />
	<!-- 독후감 BEST3 내용-->
	<div class="card-deck" >
		<c:forEach var="i" begin="0" end="2">
			<!-- reportBestList가 없다면 기본문구를 삽입하고 글이 있으면 글을 삽입 -->
			<c:choose>
			  	<c:when test="${ empty reportBestList[i] }">
			  		<div class="card">
					    <img class="card-img-top img-wrapper" id="img"
					    	src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <p class="card-text">아직 준비가 되지 않았어요! 여러분들의 참여 부탁드립니다!</p>
					      <p class="card-text"><footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
					    </div>
					 </div>
			  	</c:when>
			  	<c:otherwise>
					<div class="card">	
						<p class="center-2 best">
							<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
							BEST ${i+1 }</span>
						</p>
						<!-- 이미지 클릭하면 이동 이미지가 비어있으면 기본이미지가 보여진다.  -->
						<a href="${pageContext.request.contextPath }/public_report/detail.do?num=${reportBestList[i].num }">
							<c:choose>
								<c:when test="${reportBestList[i].imgpath eq 'emptyImg' }">
									<img class="card-img-top img-wrapper" id="img"
								    src="${pageContext.request.contextPath}/resources/images/ebd_emptyimg.jpg" alt="EBD기본이미지">
								</c:when>
								<c:otherwise>
									<img class="card-img-top img-wrapper" id="img"
								    src="${pageContext.request.contextPath }${reportBestList[i].imgpath}" alt="Card image cap">
								</c:otherwise>
							</c:choose>
						</a>
					    <div class="card-body">
					      <p class="card-text">♥${reportBestList[i].heartcnt }</p>
					      <p class="card-text"><strong>${reportBestList[i].title }</strong></p>
					      <hr />
					      <p class="card-text">${reportBestList[i].booktitle }</p>
					      <p class="card-text"><footer class="blockquote-footer"><cite id="font" title="Source Title">${reportBestList[i].author }</cite></footer></p>
						</div>
				  	</div>
			  	</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<br />
	<p class="center">
		<a class="btn btn-outline-secondary btn-sm" style="border-radius:20px;" href="${pageContext.request.contextPath }/public_report/list.do">
		더 보러가기 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
		  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
		</svg>
		</a>
	</p>
	<br /><br /><br />
	<%-- 독후감 양식 BEST 제목 --%>
	<h4>조회수 TOP 5  북클라우드</h4>
	<p class="center" >북스님들에게 가장 높은 조회수를 기록한 북클라우드</p>
	<!-- 독후감 양식 BEST 내용 -->	
	<div class="card" style="border:none;">
		<c:forEach var="i" begin="0" end="4">
		  	<div class="card-body" style="padding-top: 5px; padding-bottom: 5px;">
				<!-- 글이 없다면 기본문구를 삽입, 글이 있다면 글을 삽입 -->
				<c:choose>
					<c:when test="${empty fileBestList[i] }">
						<p>
							<span class="badge badge-pill badge-secondary badge-size">
							BEST ${i+1 }</span>
						</p>
						<li class="list-group-item">아직 준비되지 않았어요! 여러분들의 참여를 부탁드립니다~</li>	
					</c:when>
					<c:otherwise>						
					    <p class="best">
							<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
							BEST ${i+1 }</span>
						</p>
					    <li class="list-group-item">
						   <div class="row">
							   <div class="col-1">
							  	 <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="grey" class="bi bi-eye" viewBox="0 0 16 16">
							  	   <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
								 </svg><small><span class="viewcnt">&nbsp;${fileBestList[i].viewcnt}&nbsp;&nbsp;</span></small>
							   	</div>
							   	<div class="col-md-6">
							   		<c:choose>
							   			<c:when test="${empty fileBestList[i].title }">
									   		<a href="${pageContext.request.contextPath }/file/detail.do?num=${fileBestList[i].num }" style="color:black">
									   		제목없음</a>
							   			</c:when>
							   			<c:otherwise>
									   		<a href="${pageContext.request.contextPath }/file/detail.do?num=${fileBestList[i].num }" style="color:black">
									   		${fileBestList[i].title }</a>
							   			</c:otherwise>
							   		</c:choose>
							   	</div>
							   	<div class="col text-right">
							   		<span class="text-right">by. <strong>${fileBestList[i].writer }</strong></span>
							   	</div>
						   </div>
						</li>
					</c:otherwise>
				</c:choose>		
			</div>			
		</c:forEach>
	</div>
	<br />
	<p class="center">
		<a class="btn btn-outline-secondary btn-sm" style="border-radius:20px;" href="${pageContext.request.contextPath }/file/list.do">
		더 보러가기 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
		  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
		</svg>
		</a>
	</p>
	<br /><br /><br />
	<!-- 도서매물 BEST 제목 -->
	<h4>최신 TOP 3  북스 마켓의 도서 매물</h4>
	<p class="center">북스님들이 갓 올린 따끈따끈한 북스 마켓의 도서 매물들</p>
	<br />
	<!-- 도서매물 BEST 내용 -->
	<div class="card-deck">
		<c:forEach var="i" begin="0" end="2">
			 <c:choose>
				 <c:when test="${empty marketList[i] }">
				 	<div class="card">
				 		<p class="center-2">
							<span class="badge badge-pill badge-secondary badge-size">
							BEST ${i+1 }</span>
						</p>
					    <img class="card-img-top img-wrapper" id="img"
					    src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">아직 준비가 안됐어요!</h6>
					      <p class="card-text">여러분들의 참여를 부탁드립니다~</p>
					    </div>
			   		</div>
				 </c:when>
				 <c:otherwise>
				 	 <div class="card">
				 	 	<p class="center-2 best">
							<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
							BEST ${i+1 }</span>
						</p>
				 	 	<!-- 이미지 클릭하면 이동 -->
				 		<a href="${pageContext.request.contextPath }/market/detail.do?num=${marketList[i].num }">
				 			<c:choose>
				 				<c:when test="${marketList[i].imgpath eq 'emptyImg' }">
						 			<img class="card-img-top img-wrapper" id="img"
							    	src="${pageContext.request.contextPath}/resources/images/ebd_emptyimg.jpg" alt="EBD기본이미지">				 				
				 				</c:when>
				 				<c:otherwise>
						 			<img class="card-img-top img-wrapper" id="img"
							    	src="${pageContext.request.contextPath }${marketList[i].imgpath}" alt="Card image cap">				 				
				 				</c:otherwise>
				 			</c:choose>
				 		</a> 
					    <div class="card-body">
					      <p class="card-text text-muted">
					       <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 0 16 16">
							  <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
							  <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
							</svg><span>&nbsp;&nbsp;${marketList[i].regdate }</span>
						  </p>
						  <hr />
					      <h6 class="card-title">${marketList[i].title }</h6>
					      <p class="card-text">by. <strong>${marketList[i].writer }</strong></p>
					    </div>
					 </div>
				 </c:otherwise>
			 </c:choose>
		</c:forEach>
	</div>
	<br />
	<p class="center">
		<a class="btn btn-outline-secondary btn-sm" style="border-radius:20px;" href="${pageContext.request.contextPath }/market/list.do">
		더 보러가기 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
		  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
		</svg>
		</a>
	</p>
	<br /><br /><br />
	<!-- 에피소드 BEST 제목 -->
	<h4>조회수 TOP 3  에피소드</h4>
	<p class="center">북스님들에게 가장 높은 조회수를 기록한 에피소드</p>
	<br />
	<!-- 에피소드 BEST 내용-->
	<div class="card-deck"> 
		<c:forEach var="i" begin="0" end="2">
			<!-- 글이 없다면 기본문구를 삽입, 있다면 글을 삽입 -->
			<c:choose>
				<c:when test="${empty episodeBestList[i] }">
					<div class="card">
						<p class="center-2">
							<span class="badge badge-pill badge-secondary badge-size">
							BEST ${i+1 }</span>
						</p>
					    <img class="card-img-top img-wrapper" id="img"
					    src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">아직 준비가 안됐어요!</h6>
					      <p class="card-text">여러분들의 참여를 부탁드립니다!</p>
					    </div>
			  		</div>	
				</c:when>
				<c:otherwise>
					<div class="card">
						<p class="center-2 best">
							<span class="badge badge-pill badge-secondary badge-size" id="badge-color">
							BEST ${i+1 }</span>
						</p>
						<!-- 이미지 클릭하면 이동 -->
						<a href="${pageContext.request.contextPath }/episode/detail.do?num=${episodeBestList[i].num }">
							<c:choose>
								<c:when test="${episodeBestList[i].imgPath eq 'emptyImg' }">
									<img class="card-img-top img-wrapper" id="img"
							    	src="${pageContext.request.contextPath}/resources/images/ebd_emptyimg.jpg" alt="EBD기본이미지">
								</c:when>
								<c:otherwise>
									<img class="card-img-top img-wrapper" id="img"
							    	src="${pageContext.request.contextPath }${episodeBestList[i].imgPath}" alt="Card image cap">
								</c:otherwise>
							</c:choose>
						</a>
					    <div class="card-body">
						    <h6 class="card-title"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="grey" class="bi bi-eye" viewBox="0 0 16 16">
								  <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
								</svg><span class="viewcnt">&nbsp;&nbsp;${episodeBestList[i].viewcnt }</span>
							</h6>
							<hr />
					      <h6 class="card-title">${episodeBestList[i].title }</h6>
					      <p class="card-text">by. <strong>${episodeBestList[i].writer }</strong></p>
					    </div>
				  	</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<br />
	<p class="center">
		<a class="btn btn-outline-secondary btn-sm" style="border-radius:20px;" href="${pageContext.request.contextPath }/episode/list.do">
		더 보러가기 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
		  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
		</svg>
		</a>
	</p>
    <br /><br /><br />
    
 	<div class="card">
	  <div class="card-body">
	  	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
		  <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
		</svg>
	    <a href="map.do">전국 서점 보러가기</a>
	  </div>
	</div>
	<br /><br /><br />
	
</div><!-- div class="container" -->




</body>
</html>
