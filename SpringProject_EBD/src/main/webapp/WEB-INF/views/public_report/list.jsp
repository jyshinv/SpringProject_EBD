<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/public_report/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
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
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="public_report" name="thisPage"/>
</jsp:include>
<div class="container">
	<form action="list.do" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="booktitle_author" ${condition eq 'booktitle_author' ? 'selected' : '' }>책제목+저자</option>
			<option value="booktitle" ${condition eq 'booktitle' ? 'selected' : '' }>책제목</option>
			<option value="author" ${condition eq 'author' ? 'selected' : '' }>저자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
		<button type="submit">검색</button>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	<div class="row row-cols-1 row-cols-md-3">
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
      	<%int isCheck=0; %><!-- 이중 for문에서 for문이 똑같은 숫자로 돌게 하기 위해 isCheck 사용 이해 안되면 노트에 적어보거나 따로 코딩해서 돌려보기 -->
		<c:forEach var="tmp" items="${requestScope.list }">
			<div class="col">
				<div class="card" style="width: 18rem;">
					<div style="height:255px;">
						<figure class="snip1273 hover">
							<img id="img" src="${pageContext.request.contextPath }${tmp.imgpath}" class="card-img-top img-wrapper" >
							<a href="${pageContext.request.contextPath}/public_report/detail.do?num=${tmp.num}">
							<figcaption class=" card-img-top img-wrapper" style="height:240px;">
								<!-- <h5 class="card-title">${tmp.booktitle }</h5> -->							
								<MARQUEE behavior="scroll" class="card-title">${tmp.booktitle }</MARQUEE>
							</figcaption>						
							</a>
						</figure>
					</div>
				 	<div class="card-body">
					    <div class="row">
					    <p class="card-text col"><strong>${tmp.writer }</strong></p>
					    <span class="col text-right">
						    <!-- 로그인이 된 사용자만 볼 수 있다. -->
			                  <c:if test="${not empty id }">
			                     <span style="margin-right:5px;">
			                        <!-- 안쪽 forEach i는 항상 n에서 n+1만큼만 돌다.-->
			                        <!-- list2[n]의 target_num이 0이면 하트를 클릭하지 않은 것 -->
			                        <c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
			                           <c:choose>
			                              <c:when test="${isHeartClickList[i] eq 0 }">
			                                 <a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">♡</a>                              
			                              </c:when>
			                              <c:otherwise>
			                                 <a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">♥</a>
			                              </c:otherwise>
			                           </c:choose>
			                           <span class="heart-cnt${tmp.num }">${heartCntList[i]}</span>                  
			                        </c:forEach>
			                     </span>
			                  </c:if><!-- 로그인 된 사용자만 볼 수 있는 곳 -->
					    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
  <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
  <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
</svg>
					    	<small>${tmp.viewcnt }</small>
					    </span>
					    <!-- <p><small>${tmp.regdate }</small></p> -->
					    </div>
				 	</div>
				</div>		
			</div>
		<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->   
      	<%isCheck++; %>
		</c:forEach>
	</div>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
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
	//하트를 클릭할 때마다 호출되는 함수 등록
	$(document).on("click",".heart-link",function(){
		//글 번호를 불러온다.
		   var target_num=$(this).attr("data-num");
	
	   if($(this).text()=="♡"){ //하트일때 클릭하면
	      console.log("if문 들어왔다!"+target_num);
	      //insert 요청을 한다.(컨트롤러에서 responsebody사용)
	      $.ajax({
	         url:"${pageContext.request.contextPath }/public_report/saveheart.do",
	         method:"GET",
	         data: "target_num="+target_num,
	         success:function(data){ //나중에 구현 : 하트 수를 반환
	            $(".heart-cnt"+target_num).text(data.heartCnt);
	         }
	      });
	      $(this).text("♥"); //하트 눌림으로 바뀐다.
	  
	   }else{//하트 눌림일 때 클릭하면 (하트를 해제한 효과)         
	      //delete 요청을 한다.(컨트롤러에서 responsebody사용)
	      console.log("else문 들어왔다!"+target_num);
	      $.ajax({
	         url:"${pageContext.request.contextPath }/public_report/removeheart.do",
	         method:"GET",
	         data: "target_num="+target_num,
	         success:function(data){
	            $(".heart-cnt"+target_num).text(data.heartCnt);
	         }             
	      });
	      
	      $(this).text("♡");//하트로 바뀐다. 
	   }
	   
	});

	//페이지가 뒤로가기 하면 하트버튼과 하트수 갱신이 안된다. 이때 하트를 누르면 디비에 중복으로 값이 들어가진다.
	//방지하기 위해 페이지가 뒤로가기 할때마다 css로 클릭을 막고 새로고침을 통해 갱신된 하트버튼과 하트수가 나오도록 한다.
	$(window).bind("pageshow", function (event) {
	   //파이어폭스와 사파리에서는 persisted를 통해서 뒤로가기 감지가 가능하지만 익스와 크롬에서는 불가  ||뒤의 코드를 추가한다. 
	   if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
	      console.log('BFCahe로부터 복원됨');
	      $(".heart-link").css("pointer-events","none");//클릭이 안되게 막는다.
	      location.reload();//새로고침 
	      
	   }
	   else {
	      console.log('새로 열린 페이지');
	   }
	});
	
	/* Demo purposes only */
	$(".hover").mouseleave(
	  function () {
	    $(this).removeClass("hover");
	  }
	);	
</script>
</body>
</html>