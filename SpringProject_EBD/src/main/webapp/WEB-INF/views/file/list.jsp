<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>북클라우드</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
	.card-margin{
		margin-top: 30px;
		margin-bottom: 30px;
		border:none;
	}
	.card .card-text{
		/* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
		display:block;
		white-space : nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
		color:grey;
	}
	
	/* 하트 관련 */
	.heart-link,
	.heart-link:hover{
      font-size : 1.4em;
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
   
   .viewcnt{
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
    
    /*버튼 기본 노랑*/
    .btn{
    	background-color:#F7DC6F;
    	/*color:sienna;*/
    }
    /*버튼 호버시 연한 노랑*/
    .btn:hover{
    	background-color:#FBEEE6;
     }
    /* 버튼 링크 호버시 언더라인 삭제 */
    .btn-a:hover{
    	text-decoration:none;
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
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
<%-- jumborton --%>
<jsp:include page="../include/file_jumbotron.jsp"></jsp:include>
<div class="container">
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
				<input value="${keyword }" type="text" name="keyword" placeholder="검색어를 입력해주세요"
					 class="form-control" >
			</div>
			<span>
				<button class="btn" type="submit">검색</button>
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
	<div id="fileList">
		<!-- 바깥 forEach의 증가수 체크를 위한 isCheck -->
	    <%int isCheck=0; %>
		<!-- 반복문 돌려서 목록 출력 --> 	
		<c:forEach var="tmp" items="${list }">
			<div class="container" id="card-width">
				<div class="card card-margin">
					<ul class="list-group list-group-flush">
						<li class="list-group-item file-list">
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
					                <span class="viewcnt">
								    	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="grey" class="bi bi-eye" viewBox="0 0 16 16" style="margin-bottom: 5px;">
										  <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
										</svg>&nbsp;${tmp.viewcnt }
							    	</span>
							    </div>
							    <div class="col-md-6" style="padding-top:4px;">
							    	<div class="card-text">
							    		<c:choose> 
									   		<c:when test="${empty tmp.title}"><%-- 만일 타이틀이 없다면 제목없음으로 제목 지정 --%>
									      		<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}" style="color:black;"><strong>제목없음</strong></a>
									   		</c:when>
									   		<c:otherwise>
									    		<a href="${pageContext.request.contextPath }/file/detail.do?num=${tmp.num}" style="color:black;"><strong>${tmp.title }</strong></a>
									   		</c:otherwise>
										</c:choose>
							    	</div>
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
							      	<p class="reg-style" >
										<small>
											<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="grey" class="bi bi-calendar2-check" viewBox="0 0 16 16">
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
			
			</div><!-- fileList의 container -->
			
		<!-- 바깥 for문 빠져나가기 전 isCheck 증가 -->   
		<%isCheck++; %>
		</c:forEach>
	</div>
	

	<!-- 하단에 페이징 -->
	<nav>
		<ul class="pagination justify-content-center" style="margin-top: 32px;margin-bottom: 32px;">
			<c:choose>
				<c:when test="${startPageNum != 1 }">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedK }">Prev</a>
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
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedK }">Next</a>
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
            $(".heart-cnt"+target_num).text(data.heartCnt);
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