<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 독후감</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
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
	
	/*hover 기능 css*/  
	 
	.snip1273 {
	  width: 100%;
	  color: #ffffff;
	  text-align: justify;
	  background-color: #000000;
	  font-size: 16px;
	}
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
    #insertimg{
    	width:288px; 
    	height:250px;
    } 
    #svgfigure{
    	text-align:center;
    	margin-top:45px;
    } 
    .border1{
    	border:5px dashed moccasin;
    }
    .border{
    	border:none;
    }
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_report" name="thisPage"/>
</jsp:include>
<div class="container">
	<!-- 검색창 마진 띄우기 -->
	<form action="list.do" method="get">
		<div class="row justify-content-md-center" style="margin-top:10px;margin-bottom:32px;">
			<div class="col-2">
				<select class="form-control" name="condition" id="condition">
					<option value="booktitle_author" ${condition eq 'booktitle_author' ? 'selected' : '' }>책제목+저자</option>
					<option value="booktitle" ${condition eq 'booktitle' ? 'selected' : '' }>책제목</option>
					<option value="author" ${condition eq 'author' ? 'selected' : '' }>저자</option>
				</select>
			</div>
			<div class="col-md-6">
				<input class="form-control" type="text" name="keyword" placeholder="검색어를 입력해주세요" value="${keyword }"/>
			</div>
			<span>
				<button class="btn" type="submit">검색</button>
			</span>
		</div>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert text-center">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	<div class="row row-cols-1 row-cols-md-3">
			<div class="col" style="margin-bottom:15px;">
			<div class="card" style="width: 18rem;">
				<div class="border1" style="height:255px;">
					<figure id="svgfigure" class="hover">
						<a class="card-img-top img-wrapper" id="img" href="${pageContext.request.contextPath}/my_report/private/insertform.do">
						<svg enable-background="new 0 0 512 512" height="150" viewBox="0 0 512 512" width="150" xmlns="http://www.w3.org/2000/svg"><path d="m345.217 250.818v-194.613c0-14.466-11.727-26.194-26.194-26.194h-260.785c-14.466 0-26.194 11.727-26.194 26.194v419.601c0 14.466 11.727 26.194 26.194 26.194h260.784c14.466 0 26.194-11.727 26.194-26.194v-134.576" fill="#fff3da"/><path d="m479.955 449.885v-.532l-18.209-30.694-18.764 25.006-18.779-25.021-18.19 30.675v.532l36.983 52.149z" fill="#faf7f5"/><path d="m479.88 92.681-73.943-.034-.012-38.871c-.004-12.583 10.198-22.785 22.781-22.782l28.394.02c12.573.004 22.764 10.195 22.768 22.768z" fill="#ff7d97"/><path d="m479.88 92.681-73.942-.034.011 52.878h73.943z" fill="#ccf5fc"/><path d="m405.949 145.525.064 303.794 21.935-24.433 15.034 18.779 15.019-18.764 21.954 24.452-.063-303.828z" fill="#ffe6b4"/><path d="m345.22 306.21c-4.237 0-8.107-2.785-9.47-6.79-1.324-3.891-.067-8.299 3.099-10.919 3.125-2.585 7.625-3.001 11.179-1.055 3.614 1.979 5.701 6.149 5.076 10.23-.739 4.829-4.977 8.534-9.884 8.534z"/><path d="m281.623 129.086h-188.163c-5.523 0-10-4.478-10-10s4.477-10 10-10h188.163c5.522 0 10 4.478 10 10s-4.478 10-10 10z"/><path d="m281.623 241.349h-188.163c-5.523 0-10-4.478-10-10s4.477-10 10-10h188.163c5.522 0 10 4.478 10 10s-4.478 10-10 10z"/><path d="m281.623 305.362h-188.163c-5.523 0-10-4.478-10-10s4.477-10 10-10h188.163c5.522 0 10 4.478 10 10s-4.478 10-10 10z"/><path d="m220.354 369.377h-126.894c-5.523 0-10-4.478-10-10 0-5.523 4.477-10 10-10h126.894c5.523 0 10 4.477 10 10 0 5.522-4.477 10-10 10z"/><path d="m319.023 20.012h-25.222v-10.012c0-5.523-4.478-10-10-10s-10 4.477-10 10v10.012h-43.447v-10.012c0-5.523-4.477-10-10-10s-10 4.477-10 10v10.012h-43.447v-10.012c0-5.523-4.477-10-10-10s-10 4.477-10 10v10.012h-43.447v-10.012c0-5.523-4.477-10-10-10s-10 4.477-10 10v10.012h-25.222c-19.957 0-36.193 16.236-36.193 36.193v419.602c0 19.957 16.236 36.193 36.193 36.193h260.784c19.958 0 36.194-16.236 36.194-36.193v-134.577c0-5.522-4.477-10-10-10-5.522 0-10 4.478-10 10v134.576c0 8.929-7.265 16.193-16.194 16.193h-260.784c-8.929 0-16.193-7.265-16.193-16.193v-419.601c0-8.929 7.264-16.193 16.193-16.193h25.222v11.977c0 5.522 4.477 10 10 10s10-4.478 10-10v-11.977h43.447v11.977c0 5.522 4.477 10 10 10s10-4.478 10-10v-11.977h43.447v11.977c0 5.522 4.477 10 10 10s10-4.478 10-10v-11.977h43.447v11.977c0 5.522 4.478 10 10 10s10-4.478 10-10v-11.977h25.222c8.93 0 16.194 7.265 16.194 16.193v194.612c0 5.522 4.478 10 10 10 5.523 0 10-4.478 10-10v-194.612c0-19.957-16.237-36.193-36.194-36.193z"/><path d="m489.955 449.351-.087-395.572c-.006-18.061-14.704-32.759-32.761-32.765l-28.397-.02h-.01c-8.754 0-16.984 3.409-23.175 9.6-6.193 6.193-9.603 14.427-9.6 23.185l.087 395.542v.531c0 2.072.645 4.094 1.843 5.785l36.983 52.148c1.875 2.644 4.916 4.215 8.157 4.215s6.282-1.571 8.157-4.215l36.959-52.114c1.199-1.691 1.843-3.713 1.843-5.785v-.535zm-20.073-346.675.008 32.849h-53.942l-.008-32.874 26.644.012zm-53.931 52.849h53.942l.056 267.716-4.508-5.021c-1.962-2.186-4.758-3.397-7.724-3.315-2.936.083-5.689 1.454-7.524 3.747l-7.212 9.011-7.227-9.027c-1.836-2.293-4.588-3.663-7.524-3.746-.094-.003-.188-.004-.282-.004-2.835 0-5.542 1.204-7.441 3.319l-4.5 5.012zm3.716-110.79c2.413-2.412 5.621-3.741 9.029-3.741h.004l28.398.02c7.039.002 12.768 5.731 12.77 12.771l.009 28.892-26.597-.012-27.345-.013-.009-28.879c-.001-3.415 1.328-6.624 3.741-9.038zm23.329 439.979-24.415-34.426 8.93-9.947 7.664 9.574c1.898 2.37 4.771 3.75 7.807 3.75 3.037 0 5.909-1.38 7.808-3.751l7.648-9.557 8.948 9.965z"/></svg>
						</a>
					</figure>
				</div>
			</div>
		</div>
		<c:forEach var="tmp" items="${requestScope.list }">
		
			<div class="col" style="margin-bottom:15px;">
				<div class="card" style="width: 18rem;">
					<c:choose>
						<c:when test="${tmp.imgpath eq 'emptyImg' }">
							<div style="height:255px;">
								<figure class="snip1273 hover">
									<img src="${pageContext.request.contextPath}/resources/images/ebd_emptyimg.jpg" alt="EBD기본이미지" class="card-img-top img-wrapper" id="img"/>
									<a href="${pageContext.request.contextPath}/my_report/private/detail.do?num=${tmp.num }">
										<figcaption class=" card-img-top img-wrapper" style="height:240px;">
											<!-- <h5 class="card-title">${tmp.booktitle }</h5> -->							
											<MARQUEE behavior="scroll" class="card-title">${tmp.booktitle }</MARQUEE>
										</figcaption>							
									</a>
								</figure>
							</div>
						</c:when>
						<c:otherwise>
							<div style="height:255px;">
								<figure class="snip1273 hover">
									<img src="${pageContext.request.contextPath }${tmp.imgpath}" class="card-img-top img-wrapper" id="img"/>
									<a href="${pageContext.request.contextPath}/my_report/private/detail.do?num=${tmp.num }">
										<figcaption class=" card-img-top img-wrapper" style="height:240px;">
											<!-- <h5 class="card-title">${tmp.booktitle }</h5> -->							
											<MARQUEE behavior="scroll" class="card-title">${tmp.booktitle }</MARQUEE>
										</figcaption>							
									</a>
								</figure>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		
		</c:forEach>
	</div>
	<nav>
	<ul class="pagination justify-content-center" style="margin-top: 32px;margin-bottom: 32px;">
		<c:choose>
			<c:when test="${startPageNum ne 1 }">
				<li class="page-item">
					<a class="page-link" href="list.do?pageNum=${startPageNum-1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
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
						<a class="page-link" href="list.do?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${endPageNum lt totalPageCount }">
				<li class="page-item">
					<a class="page-link" href="list.do?pageNum=${endPageNum+1 }&condition=${condition}&keyword=${encodedK}">Next</a>
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
	$(".hover").removeClass("hover");
	/* Demo purposes only */
	$(".hover").mouseleave(
	  function () {
	    $(this).removeClass("hover");
	  }
	);
</script>
</body>
</html>