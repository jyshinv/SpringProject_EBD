<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.card-margin{
		margin-top: 15px;
		margin-bottom: 15px;
	}
	
	.heart-link{
      font-size : 1.5em;
      color: red;
   }
   
   /* 프로필 이미지를 작은 원형으로 만든다 */
   #profileImage{
      width: 25px;
      height: 25px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
	
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
<div class="container">
	<br />
	
	<div class="col">
		<a href="${pageContext.request.contextPath }/file/private/insertform.do" style="color:brown;">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-plus-circle-fill" viewBox="0 0 16 16">
			  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
			</svg> UPLOAD
		</a>
	</div>
	<!-- 검색 -->
	<form action="list.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px;">
			<div class="col-2">
				<select class="form-control" name="condition" id="condition">
					<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
				</select>
			</div>
			<div class="col-md-6">
				<input value="${keyword }" type="text" name="keyword" placeholder="검색어..."
					 class="form-control" >
			</div>
			<span>
				<button class="btn btn-outline-secondary" type="submit">검색</button>
			</span>
		</div>
	</form>
	
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	
	
	<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
    <%int isCheck=0; %>
	<!-- 반복문 돌려서 목록 출력 --> 	
	<c:forEach var="tmp" items="${list }">
		<div class="card card-margin">
			<ul class="list-group list-group-flush">
				<li class="list-group-item">
					<div class="row">
					    <div class="col-2 text-left">
					      	<!-- 하트 -->
							<!-- 로그인이 된 사용자만 볼 수 있다. -->
							<c:if test="${not empty id }">
								<!-- 안쪽 forEach i는 항상 n에서 n+1만큼만 돌다.-->
								<!-- list2[n]의 target_num이 0이면 하트를 클릭하지 않은 것 -->
								<c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
									<c:choose>
										<c:when test="${isHeartClickList[i] eq 0 }">
											<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do" style="color:red;">
											♡</a>                              
										</c:when>
										<c:otherwise>
											<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do" style="color:red;">
											♥</a>
										</c:otherwise>
									</c:choose>
									<span class="heart-cnt${tmp.num }">${heartCntList[i]}</span>                  
								</c:forEach>
							</c:if>
					    	<c:if test="${empty id }"> <!-- 로그인이 안되어있는 사람 -->
			                     <c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
			                     <span>♥</span>
			                     <span class="heart-cnt${tmp.num }">${heartCntList[i]}</span>
			                     </c:forEach>
			                </c:if>
					    </div>
					    <div class="col-md-6">
					      <a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}">
							${tmp.title }</a>
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
					    </div>
					 </div>
				 </li>
			</ul>
		</div> <!-- card -->
		
	<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->   
	<%isCheck++; %>
	</c:forEach>

	
		
	  	
	  				
	  		
		
	
	<!-- 하단에 페이징 -->
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
         url:"${pageContext.request.contextPath }/file/saveheart.do",
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
         url:"${pageContext.request.contextPath }/file/removeheart.do",
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