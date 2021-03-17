<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my_report/private/list.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/* card 이미지 부모요소의 높이 지정 */
	.img-wrapper{
		height: 250px;
		/* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
		transition: transform 0.3s ease-out;
		
	}
	/* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
	.img-wrapper:hover{
		/* 원본 크기의 1.1 배로 확대 시키기*/
		/*transform: scale(1.05);*/
		opacity: 0.3;
	}
	.card .card-title{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: clip;
		overflow: auto;
		color:white;
	}
	.card{
		margin:5px;
		border:0px;
	}
	.card-body{
	    padding-top: 10px;
	    padding-bottom: 10px;
	    height: 50px;
	}
	#img{
		object-fit: cover;
		background-position:center;
		
	}
	.heart-link{
	/*
      font-size : 2em;
    */  
   	}
   	
	/*hover 기능 css*/  
	 
	.snip1273 {
	  width: 100%;
	  color: #ffffff;
	  text-align: justify;
	  background-color: #000000;
	  font-size: 16px;
	}
	
	/*
	.snip1273 * {
	  -webkit-box-sizing: border-box;
	  box-sizing: border-box;
	  -webkit-transition: all 0.4s ease-in;
	  transition: all 0.4s ease-in;
	}
	*/
	/*
	.snip1273 img {
	  position: relative;
	  max-width: 100%;
	  vertical-align: top;
	}
	*/
	.snip1273 figcaption {
	  position: absolute;
	  top: 0;
	  right: 0;
	  width: 100%;
	  height: 100%;
	  z-index: 1;
	  opacity: 0;
	  padding: 20px 30px;
	}
	/* 이미지 경계선에 효과가 들어오는 css */
	.snip1273 figcaption:before,
	.snip1273 figcaption:after {
	  width: 5px;
	  height: 0;
	}	
	.snip1273 figcaption:before {
	  right: 0;
	  top: 0;
	}
	.snip1273 figcaption:after {
	  left: 0;
	  bottom: 0;
	}
	
	.snip1273 h5{
	  line-height: 5em;
	}
	
	.snip1273 h5 {
	  margin: 0 0 5px;
	  font-weight: 700;
	  text-transform: uppercase;
	}
	.snip1273:before,
	.snip1273:after,
	.snip1273 figcaption:before,
	.snip1273 figcaption:after {
	  position: absolute;
	  content: '';
	  background-color: #ffffff;
	  z-index: 1;
	  -webkit-transition: all 0.4s ease-in;
	  transition: all 0.4s ease-in;
	  opacity: 0.8;
	}
	.snip1273:before,
	.snip1273:after {
	  height: 1px;
	  width: 0%;
	}
	.snip1273:before {
	  top: 0;
	  left: 0;
	}
	.snip1273:after {
	  bottom: 0;
	  right: 0;
	}
	.snip1273:hover img,
	.snip1273.hover img {
	  opacity: 0.4;
	}
	.snip1273:hover figcaption,
	.snip1273.hover figcaption {
	  opacity: 1;
	}
	.snip1273:hover figcaption:before,
	.snip1273.hover figcaption:before,
	.snip1273:hover figcaption:after,
	.snip1273.hover figcaption:after {
	  height: 100%;
	}
	.snip1273:hover:before,
	.snip1273.hover:before,
	.snip1273:hover:after,
	.snip1273.hover:after {
	  width: 100%;
	}
	.snip1273:hover:before,
	.snip1273.hover:before,
	.snip1273:hover:after,
	.snip1273.hover:after,
	.snip1273:hover figcaption:before,
	.snip1273.hover figcaption:before,
	.snip1273:hover figcaption:after,
	.snip1273.hover figcaption:after {
	  opacity: 0.1;
	}	
	/* 프로필 이미지를 작은 원형으로 만든다 */
    #profileImage{
      width: 100px;
      height: 100px;
      border: 1px solid #cecece;
      border-radius: 50%;
    }	
</style>
</head>
<body>
<jsp:include page="../../include/mydiarynav.jsp"></jsp:include>
<div class="container">
	<form action="list.do" method="get">
			<div class="row justify-content-md-center" style="margin:10px;">
				<span>
					<button class="btn btn-primary">
						<a href="${pageContext.request.contextPath}/my_report/private/insertform.do" style="color:white">새 독후감 작성</a>
					</button>
				</span>
				<div class="col-2">
					<select class="form-control" name="condition" id="condition">
						<option value="booktitle_author" ${condition eq 'booktitle_author' ? 'selected' : '' }>책제목+저자</option>
						<option value="booktitle" ${condition eq 'booktitle' ? 'selected' : '' }>책제목</option>
						<option value="author" ${condition eq 'author' ? 'selected' : '' }>저자</option>
					</select>
				</div>
				<div class="col-md-6">
					<input class="form-control" type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
				</div>
				<span>
					<button class="btn btn-primary" type="submit">검색</button>
				</span>
			</div>
		</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	<div class="row row-cols-1 row-cols-md-3">
		<c:forEach var="tmp" items="${requestScope.list }">
		<div class="col">
			<div class="card" style="width: 18rem;">
				<div style="height:255px;">
					<c:if test="${nick eq tmp.writer }">
						<figure class="snip1273 hover">
							<img src="${pageContext.request.contextPath }${tmp.imgpath}" class="card-img-top img-wrapper" id="img"/>
							<a href="${pageContext.request.contextPath}/my_report/private/detail.do?num=${tmp.num }">
								<figcaption class=" card-img-top img-wrapper" style="height:240px;">
									<!-- <h5 class="card-title">${tmp.booktitle }</h5> -->							
									<MARQUEE behavior="scroll" class="card-title">${tmp.booktitle }</MARQUEE>
								</figcaption>							
							</a>
						</figure>
					</c:if>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
	<nav>
	<ul class="pagination justify-content-center">
		<c:choose>
			<c:when test="${startPageNum != 1 }">
				<li class="page-item">
					<a class="page-link" href="list.do?pageNum=${startPageNum-1 }">Prev</a>
				</li>
			</c:when>
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
<script>
	/* Demo purposes only */
	$(".hover").mouseleave(
	  function () {
	    $(this).removeClass("hover");
	  }
	);
</script>
</body>
</html>