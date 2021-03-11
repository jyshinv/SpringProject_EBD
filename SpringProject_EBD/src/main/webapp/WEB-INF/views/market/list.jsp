 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/market/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<script src="${pageContext.request.contextPath }/resources/js/imgLiquid.js"></script>
<style>

	.card{
		margin: 30px;
	}

	/* card 이미지 부모요소의 높이 지정 */
	.img-wrapper{
		
		height: 250px;
		
		position: center;
		size: cover;
		
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
	
	/* img  가  가운데 정렬 되도록 */
	.back-drop{
		/* 일단 숨겨 놓는다. */
		display:none;
	
		/* 화면 전체를 투명도가 있는 회색으로 덮기 위한  css*/
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		background-color: #cecece;
		padding-top: 300px;
		z-index: 10000;
		opacity: 0.5;
		text-align: center;
	}
	
	.heart-link{
      font-size : 2em;
   }
	
</style>
</head>
<body>
<jsp:include page="../include/navbar2.jsp"></jsp:include>
<div class="container">
	<br />
	<table>
		<td>
			<a href="private/insertform.do" class="btn btn-info">중고거래 글 쓰러가기</a>
		</td>
		<!-- 검색 -->
		<form action="list.do" method="get">
			<td>
				<label for="condition"><strong>검색 조건</strong></label>
			</td>
			<td>
				<select name="condition" id="condition">
					<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
				</select>
			</td>
			<td>
				<div class="input-group mb-3">
				  <input value="${keyword }" type="text" name="keyword" placeholder="검색어..."
				  	 class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2">
				  <div class="input-group-append">
				    <button class="btn btn-outline-secondary" type="submit">검색</button>
				  </div>
				</div>
			</td>
		</form>
	</table>
	<!-- 목록 -->
	<div class="row" id="galleryList">
	
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
      	<%int isCheck=0; %>
	
		<!-- 반복문 돌려서 목록 출력 --> 	
		<c:forEach var="tmp" items="${marketList }">
			<div class="card" style="width: 18rem;">
				
				<a href="detail.do?num=${tmp.num }">
				<div class="img-wrapper">
					<img class="card-img-top" src="${pageContext.request.contextPath }${tmp.imgpath }">
				</div>
				
				<div class="card-body">
					<h5 class="card-title">
						<a href="${pageContext.request.contextPath }/market/detail.do?num=${tmp.num}">${tmp.title }</a>
					</h5>
					<p class="card-text"><strong>by</strong> ${tmp.writer }</p>
					<p class="card-text">${tmp.salesType } <strong>|</strong> ${tmp.salesStatus }</p>
					<p class="card-text"><small class="text-muted">${tmp.regdate }</small></p>
				</div>
				
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
				
				<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->   
				<%isCheck++; %>
				
			</div>
		</c:forEach>
	</div>
	
	<!-- 하단에 페이징 -->
	<div class="page-display">
		<ul class="pagination pagination-sm justify-content-center">
		<c:if test="${startPageNum ne 1 }">
			<li class="page-item"><a class="page-link" href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">Prev</a></li>
		</c:if>
		<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
			<c:choose>
				<c:when test="${i eq pageNum }">
					<li class="page-item active"><a class="page-link" href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${endPageNum lt totalPageCount }">
			<li class="page-item"><a class="page-link" href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">Next</a></li>
		</c:if>
		</ul>
	</div>
	
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
            $(".heart-cnt"+target_num).text("("+data.heartCnt+")");
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