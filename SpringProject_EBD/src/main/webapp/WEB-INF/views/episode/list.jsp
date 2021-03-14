<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<script src="${pageContext.request.contextPath }/resources/js/imgLiquid.js"></script>
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
		transform: scale(1.05);
	}
	
	.card .card-text{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	
	.heart-link{
		font-size : 2em;
	}
	
</style>
</head>
<body>
<jsp:include page="../include/navbar2.jsp"></jsp:include>
<div class="container">
	<a href="private/uploadform.do">에피소드 작성하러 가기</a>	
	<h1>에피소드 목록 입니다.</h1>
	<div class="row" id="galleryList">
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
		<%int isCheck=0; %>
		<!-- tmp는 GalleryDto type임 따라서 Dto의 필드명을 정확하게 명시해주어야한다. (tmp가 무슨타입인지 정확히 알고있어야한다.)-->
		<c:forEach var="tmp" items="${list }">
			<div class="col-6 col-md-4 col-lg-3">
				<div class="card mb-3">
					<a href="detail.do?num=${tmp.num }">
						<div class="img-wrapper">
							<!-- 아래 코드의 src 해석결과는 spring05/upload/xxx.jpg임! DB의 imagePath컬럼에 저장된 값을 확인해볼 것 -->
							<img class="card-img-top" src="${pageContext.request.contextPath }${tmp.imgPath}" />
						</div>
					</a>
					<div class="card-body">
						<p class="card-text">${tmp.title }</p>
						<p class="card-text">by <strong>${tmp.writer }</strong></p>
						<p><small>${tmp.regdate }</small></p>
						<c:if test="${empty id }">
							<c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
							<span>♥</span>
							<span class="heart-cnt${tmp.num }">(${heartCntList[i]})</span>
							</c:forEach>
						</c:if>
						<!-- 로그인이 된 사용자만 볼 수 있다. -->
						<c:if test="${not empty id }">
							<p>
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
									<span class="heart-cnt${tmp.num }">(${heartCntList[i]})</span>						
								</c:forEach>
							</p>
						</c:if><!-- 로그인 된 사용자만 볼 수 있는 곳 -->
						<span>조회수 : ${tmp.viewcnt }</span>						
					</div>
				</div>
			</div>
		<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->	
		<%isCheck++; %>			
		</c:forEach>
	</div>
	
	<!-- 페이징 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<%-- 시작페이지가 1과 같지 않다면 --%>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${startPageNum-1 }">Prev</a>
					</li>
				</c:when>
				<%-- 시작페이지가 1과 같다면 --%>
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
	
	<!-- 검색 -->
	<form action="list.do" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목+내용</option>
			<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
			<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
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
				url:"${pageContext.request.contextPath }/episode/saveheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){ //나중에 구현 : 하트 수를 반환
					$(".heart-cnt"+target_num).text("("+data.heartCnt+")");
				}
			});
			$(this).text("♥"); //하트 눌림으로 바뀐다.
			
			
		
		}else{//하트 눌림일 때 클릭하면 (하트를 해제한 효과)			
			//delete 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/episode/removeheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){
					$(".heart-cnt"+target_num).text("("+data.heartCnt+")");
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