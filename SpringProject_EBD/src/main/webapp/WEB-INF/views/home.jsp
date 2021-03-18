<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/home.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Serif KR', serif;
	}
	.search_form{
		margin-top:16px;
	}
	
	h4{
		color: brown;
		text-align: center;
	}
	
	/*요소를 가운대로*/
	#center{
		text-align: center;
	}
	
	.wording-img{
		width: 140px;
      	height: 140px;
      
      	border-radius: 50%;
	}
	
	.card .card-deck{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
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
	<h4>Every Book Day 좋아요 TOP 3 명언 </h4>
	<p id="center">좋은 구절을 추천 해주세요!  
	 	<!--<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>-->
	 	<a href="#"><u style="color: gray">More</u></a>
	<br />
	<!-- 명언 BEST 내용 -->
	<div class="container marketing">
		<div class="row">
			<c:forEach var="i" begin="0" end="2">
				<!-- 글이 없으면 기본 문구 삽입, 글이 있으면 글을 삽입  -->
				<c:choose>
					<c:when test="${empty wordingBestList[i] }">
						<div class="col-lg-4 text-center">
							<p>BEST ${i+1 }</p>
							<img class="card-img-top wording-img" src="https://i.pinimg.com/originals/95/a5/10/95a51074afed9b72b537b78b94f0a041.jpg" alt="Card image cap">
					        <h5>아직 준비가 되지 않았어요! </h5>
					        <p>여러분들의 참여 부탁드립니당!</p>
					       	 <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
						</div>
					</c:when>
					<c:otherwise>
						 <div class="col-lg-4 text-center">
							<p>BEST ${i+1 }</p>
					      	<p>♥ ${wordingBestList[i].heartcnt }</p>
							<img class="card-img-top wording-img" src="${pageContext.request.contextPath }${wordingBestList[i].profile}" alt="Card image cap">
					        <h5>${wordingBestList[i].title }</h5>
					        <p>${wordingBestList[i].writer }</p>
					      	<p> <footer class="blockquote-footer">${wordingBestList[i].content } ,<cite title="Source Title">${wordingBestList[i].author }</cite></footer></p>
					     </div>
					</c:otherwise>
				</c:choose>
			</c:forEach>			     
		</div>
	</div>	
	<br /><br /><br />
    <%-- 독후감 BEST 제목 --%>
    <h4>좋아요 TOP 3 독후감</h4>
	<p id="center">북스님들에게 가장 많은 좋아요를 받은 독후감
			<br /><br /><a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<br />
	<!-- 독후감 BEST3 내용-->
	<div class="card-deck" >
		<c:forEach var="i" begin="0" end="2">
			<!-- reportBestList가 없다면 기본문구를 삽입하고 글이 있으면 글을 삽입 -->
			<c:choose>
			  	<c:when test="${ empty reportBestList[i] }">
			  		<div class="card">
			  			<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <p class="card-text">아직 준비가 되지 않았어요! 여러분들의 참여 부탁드립니다!</p>
					      <p class="card-text"><footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
					    </div>
					 </div>
			  	</c:when>
			  	<c:otherwise>
					<div class="card">	
						<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="${pageContext.request.contextPath }${reportBestList[i].imgpath}" alt="Card image cap">
					    <div class="card-body">
					      <p class="card-text">♥${reportBestList[i].heartcnt }</p>
					      <p class="card-text">${reportBestList[i].content }</p>
					      <p class="card-text"><footer class="blockquote-footer">${reportBestList[i].booktitle }, <cite title="Source Title">${reportBestList[i].author }</cite></footer></p>
						</div>
				  	</div>
			  	</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<br /><br /><br />
	<%-- 독후감 양식 BEST 제목 --%>
	<h4>독후감 양식 조회수 TOP 5 다운로드</h4>
	<p id="center">북스님들이 공유해주신 독후감 양식
		<br /><a href="#"><u style="color: gray">More</u></a></p>
	<!-- 독후감 양식 BEST 내용 -->	
	<div class="card">
		<ul class="list-group list-group-flush">
			<c:forEach var="i" begin="0" end="4">
				<!-- 글이 없다면 기본문구를 삽입, 글이 있다면 글을 삽입 -->
				<c:choose>
					<c:when test="${empty fileBestList[i] }">
						<p>BEST ${i+1 }</p><li class="list-group-item">아직 준비되지 않았어요! 여러분들의 참여를 부탁드립니다~</li>	
					</c:when>
					<c:otherwise>						
					    <p>BEST ${i+1 }</p><li class="list-group-item">viewcnt : ${fileBestList[i].viewcnt} <a href="${pageContext.request.contextPath }/file/detail.do?num=${fileBestList[i].num }">${fileBestList[i].title }</a></li>
					</c:otherwise>
				</c:choose>				
			</c:forEach>
		</ul>
	</div>
	<br /><br /><br />
	<!-- 도서매물 BEST 제목 -->
	<h4>최신 TOP 3 도서 매물</h4>
	<p id="center">따끈따끈한 도서 매물 구경하러가기</p>
	<!-- 도서매물 BEST 내용 -->
	<div class="card-deck">
		<c:forEach var="i" begin="0" end="2">
			 <c:choose>
				 <c:when test="${empty marketList[i] }">
				 	<div class="card">
				 		<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">아직 준비가 안됐어요!</h6>
					      <p class="card-text">여러분들의 참여를 부탁드립니다~</p>
					    </div>
			   		</div>
				 </c:when>
				 <c:otherwise>
				 	 <div class="card">
				 	 	<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="${pageContext.request.contextPath }${marketList[i].imgpath}" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">${marketList[i].title }</h6>
					      <p class="card-text">${marketList[i].content }</p>
					      <p class="card-text">${marketList[i].regdate }</p>
					    </div>
					 </div>
				 </c:otherwise>
			 </c:choose>
		</c:forEach>
	</div>
	<br />
	<p id="center">
		<a class="btn btn-outline-secondary btn-sm" href="#">♥ 더 보러가기</a>
	</p>
	<br /><br /><br />
	<!-- 에피소드 BEST 제목 -->
	<h4>조회수 TOP 3 에피소드</h4>
	<p id="center">책과 관련된 재밌는 이야기 작성하러 가기
		<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<!-- 에피소드 BEST 내용-->
	<div class="card-deck"> 
		<c:forEach var="i" begin="0" end="2">
			<!-- 글이 없다면 기본문구를 삽입, 있다면 글을 삽입 -->
			<c:choose>
				<c:when test="${empty episodeBestList[i] }">
					<div class="card">
						<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">아직 준비가 안됐어요!</h6>
					      <p class="card-text">여러분들의 참여를 부탁드립니다!</p>
					    </div>
			  		</div>	
				</c:when>
				<c:otherwise>
					<div class="card">
						<p>BEST ${i+1 }</p>
					    <img class="card-img-top" src="${pageContext.request.contextPath }${episodeBestList[i].imgPath}" alt="Card image cap">
					    <div class="card-body">
					      <h6 class="card-title">조회수 : ${episodeBestList[i].viewcnt }</h6>
					      <h6 class="card-title">${episodeBestList[i].title }</h6>
					      <p class="card-text">${episodeBestList[i].content }</p>
					    </div>
				  	</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
		
    <br /><br /><br />
    <div class="card">
	  <div class="card-body">
	    <blockquote class="blockquote mb-0">
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
	      <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
	    </blockquote>
	  </div>
	</div>
	
</div><!-- div class="container" -->




</body>
</html>
