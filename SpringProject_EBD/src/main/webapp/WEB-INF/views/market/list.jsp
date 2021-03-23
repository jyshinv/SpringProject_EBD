 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>북스마켓</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style> 
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
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
		font-size: 1.4em;
		color: red;
		text-decoration: none;
   }
   	.heart-link-logout{
   		font-size : 1.4em;
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
    .btn-a{
    	/*color:sienna;*/
    }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn-a:hover{
    	/*color:sienna;*/
    	text-decoration:none;
    }
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="market" name="thisPage"/>
</jsp:include>
<%-- jumborton --%>
<jsp:include page="../include/market_jumbotron.jsp"></jsp:include>
<div class="container">
	<!-- 검색 -->
	<form action="list.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-2">
				<select class="form-control" name="condition" id="condition">
					<option value="salesType" ${condition eq 'salesType' ? 'selected' : '' }>거래 유형</option>
					<option value="salesStatus" ${condition eq 'salesStatus' ? 'selected' : '' }>거래 상태</option>
					<option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목+내용</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
				</select>
			</div>
			<div class="col-md-6">
				<input value="${keyword }" type="text" name="keyword" placeholder="검색어를 입력해주세요"
				  	 class="form-control">
			</div>
			<span>
				<button class="btn" type="submit">
				검색</button>
			</span>
		</div>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<!-- 검색키워드 투명하게 보이기 + 가운데 정렬 -->
		<div class="alert text-center">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
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
				<a href="detail.do?num=${tmp.num }">
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
						<div class="col text-right">
							<p class="card-text">
								<!-- 하트 -->
								<!-- 로그인이 된 사용자만 볼 수 있다. -->
								<c:if test="${not empty id }">
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
								</c:if>
								<c:if test="${empty id }"> <!-- 로그인이 안되어있는 사람 -->
				                     <c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
					                     <span class="heart-link-logout">♥</span>
					                     <span class="heart-cnt-logout heart-cnt${tmp.num }">${heartCntList[i]}</span>
				                     </c:forEach>
				                </c:if>
				
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
						<a class="page-link" href="list.do?pageNum=${startPageNum-1}&condition=${condition}&keyword=${encodedK}">Prev</a>
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
							href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link"  
							href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount}">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${endPageNum+1}&condition=${condition}&keyword=${encodedK}">Next</a>
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
         url:"${pageContext.request.contextPath }/market/saveheart.do",
         method:"GET",
         data: "target_num="+target_num,
         success:function(data){ //나중에 구현 : 하트 수를 반환
            $(".heart-cnt"+target_num).text(data.heartCnt);
         }
      });
      $(this).text("♥"); //하트 눌림으로 바뀐다.
      
      
   
   }else{//하트 눌림일 때 클릭하면 (하트를 해제한 효과)         
      //delete 요청을 한다.(컨트롤러에서 responsebody사용)
      $.ajax({
         url:"${pageContext.request.contextPath }/market/removeheart.do",
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
      $(".heart-link").css("pointer-events","none");
      location.reload();//새로고침 
      
   }
   else {
      console.log('새로 열린 페이지');
   }
});

</script>
</body>
</html>