<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 명언/글귀</title>
<!-- kakao api를 사용하기 위한 sdk를 추가해주기 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
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
	
	.back-drop img{
		width: 100px;
		/* rotateAnimation 이라는 키프레임을 2초 동한 일정한 비율로  무한 반복하기 */
		animation: rotateAnimation 2s ease-out infinite;
	}
	
	/* 회전하는 rotateAnimation 이라는 이름의 키프레임 정의하기 */
	@keyframes rotateAnimation{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}
	
	.heart-link{
		font-size : 1.5em;
		color:red;
	}
	
	
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	
	/*부모요소의 items를 center로*/
    .row{
        align-items: center;
        height: 200px;
    }


    /*자식요소의 text-align를 center로*/
   div{
       text-align: center;
   }
   
   /*card의 모서리를 둥글게*/
   .card{
   		border-radius: 10px;
   }
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<jsp:include page="../include/wording_jumbotron.jsp"></jsp:include>
<div class="container">
	<!-- 검색 버튼과 form -->
	<form action="list.do" method="get">
		<div class="row justify-content-md-center">
			<div class="col-2">
				<select class="form-control" name="condition" id="condition">
					<option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목+내용</option>
					<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
					<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
				</select>
			</div>
			<div class="col-md-6">
				<input value="${keyword }" type="text" name="keyword" placeholder="검색어..."
				  	 class="form-control">
			</div>
			<span>
				<button class="btn btn-light" type="submit" style=" background-color:#F7DC6F ;">
				검색</button>
			</span>
		</div>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	<%int isCheck=0; %>
	<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
	<div id="wordingList">
			<c:forEach var="tmp" items="${list }">
				<div class="card" style="background-color: #FEFCF4; border:white">
					<div class="card-body">
						<div class="row">
							<div class="col-3">
								<p>
									<!-- 프로필 이미지 나오는 곳 -->
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

								</p>
								<p>
									<!-- 닉네임  -->
									${tmp.writer }
								</p>
								<p>
									<!-- 하트, 수정, 삭제  -->
									<c:if test="${empty id }">
										<c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
										<span>♥</span>
										<span class="heart-cnt${tmp.num }">${heartCntList[i]}</span>
										</c:forEach>
									</c:if>
									<c:if test="${not empty id }">
										<c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
											<!-- heartInfoList가 0이면 하트를 누르지 않은 것이다.  -->
											<c:choose>
												<c:when test="${heartInfoList[i] eq 0 }">
													<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">♡</a>										
												</c:when>
												<c:otherwise>
													<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">♥</a>
												</c:otherwise>
											</c:choose>
											<span class="heart-cnt${tmp.num }">${heartCntList[i]}</span>
										</c:forEach>
										<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
										<c:if test="${tmp.writer eq sessionScope.nick }">
											| <a href="private/updateform.do?num=${tmp.num }">수정</a>
											| <a id="delete" data-num="${tmp.num }" href="javascript:deleteConfirm()">삭제</a>	
										</c:if>	
									</c:if>
								</p>
							</div>
							<div class="col-7">
								<!-- 글귀와 제목, 작가 -->
								<p>
									<b>${tmp.content }</b>
								</p>
								<br />
								<p>
									${tmp.title }, ${tmp.author }
								</p>
							</div>
							<div class="col-2">
								<p>
									<!-- 카카오 이미지 링크 넣기 -->
									<a class="kakao-link" href="javascript:" data-profile="${tmp.profile }" data-title="${tmp.title }" data-content="${tmp.content }" data-author="${tmp.author }" >
											<svg id="Bold" enable-background="new 0 0 32 32" height="30" viewBox="0 0 32 32" width="30" xmlns="http://www.w3.org/2000/svg"><path d="m26 32h-20c-3.314 0-6-2.686-6-6v-20c0-3.314 2.686-6 6-6h20c3.314 0 6 2.686 6 6v20c0 3.314-2.686 6-6 6z" fill="#e3f8fa"/><path d="m14.308 14.204-.461 1.301h.922z" fill="#8ce1eb"/><path d="m16 8.667c-4.418 0-8 2.805-8 6.266 0 2.237 1.497 4.2 3.75 5.309-.866 2.966-.889 2.98-.742 3.066.184.108.423-.003 3.571-2.208.461.065.936.099 1.421.099 4.418 0 8-2.805 8-6.266s-3.582-6.266-8-6.266zm-3.962 8.015c0 .241-.207.438-.462.438s-.462-.196-.462-.438v-2.724h-.72c-.25 0-.453-.201-.453-.449 0-.247.203-.449.453-.449h2.363c.25 0 .453.201.453.449 0 .247-.203.449-.453.449h-.72v2.724zm3.586.432c-.48 0-.391-.377-.613-.797h-1.407c-.22.417-.133.797-.613.797-.462 0-.543-.281-.403-.714l1.104-2.887c.078-.22.314-.446.615-.453.301.007.538.233.616.453.729 2.261 1.769 3.602.701 3.601zm2.626-.061h-1.481c-.772 0-.302-1.043-.442-3.534 0-.253.211-.458.471-.458s.471.206.471.458v2.694h.981c.244 0 .442.189.442.42 0 .232-.198.42-.442.42zm3.613-.345c-.017.121-.081.229-.179.302-.637.481-1.107-.921-1.729-1.514l-.16.159v1c0 .253-.207.458-.462.459-.255 0-.462-.206-.462-.458v-3.136c0-.253.207-.458.462-.458s.462.206.462.458v.985c.851-.639 1.323-1.78 1.861-1.246.528.524-.565.982-1.018 1.614 1.069 1.475 1.272 1.511 1.225 1.835z" fill="#26c6da"/></svg>
									</a>
								</p>
							</div>
						</div>

					</div><!-- div card-body -->
				</div><!-- div card -->
				<%isCheck++; %><!-- 바깥 for문 빠져나가기 전에 isCheck증가시키기 -->
				<br />
			</c:forEach><!-- 바깥 for문 -->
</div><!-- div container -->
<div class="back-drop">
	<!-- cpath/ 에서 '/'는 webapp을 의미한다. 웹앱 폴더의 svg폴더 안에 spinner-solid.svg가 들어있다.  -->
	<img src="${pageContext.request.contextPath }/svg/spinner-solid.svg"/> 

</div>
<script>
	
	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage=1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
	let isLoading=false;
	
	//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
	$(window).on("scroll",function(){
		//위로 스크롤된 길이
		let scrollTop=$(window).scrollTop();
		//웹브라우저의 창의 높이
		let windowHeight=$(window).height();
		//문서 전체의 높이
		let documentHeight=$(document).height();
		//바닥까지 스크롤 되었는 지 여부를 알아낸다.
		let isBottom=scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){
			//만일 현재 마지막 페이지라면
			if(currentPage == ${totalPageCount } || isLoading){
				return; //함수를 여기서 끝낸다.
			}
			//현재 로딩 중이라고 표시한다.
			isLoading=true;
			//로딩바를 띄우고
			$(".back-drop").show();
			//요청할 페이지 번호를 1 증가시킨다.
			currentPage++;
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고 (/wording/list.do요청과 /wording/ajax_page.do 요청처리 해주어야함)
			$.ajax({
				url:"ajax_page.do",
				method:"GET",
				data:"pageNum="+currentPage,
				//ajax_page.jsp의 내용이 data로 들어온다.
				success:function(data){
					console.log(data);
					//응답된 문자열은 html 형식이다.(wording/private/ajax_page.jsp에 응답내용이 있다.)
					//해당 문자열을 #wordingList div에 html로 해석하라고 추가한다.
					$("#wordingList").append(data);
					//로딩바를 숨긴다.
					$(".back-drop").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
				}
				
			});
		}; //end of if(isBottom)
	});
	
	//하트를 클릭할 때마다 호출되는 함수 등록
	$(document).on("click",".heart-link",function(){
		//글 번호를 불러온다.
		var target_num=$(this).attr("data-num");
	
		if($(this).text()=="♡"){ //하트일때 클릭하면
			console.log("if문 들어왔다!"+target_num);
			//insert 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/wording/saveheart.do",
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
				url:"${pageContext.request.contextPath }/wording/removeheart.do",
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
			//Kakao.init: Already initialized 에러를 막기위해 페이지가 새로 열렸을 때만 initialized되도록 한다. 
			Kakao.init('f2390c73f2911395fe314495c387c880'); // 초기화 + 카카오 디벨로퍼에 플랫폼까지 등록해주어야 한다.
		}
	});
	
	//카카오톡 공유하기 버튼을 클릭할 경우 
	$(document).on("click",".kakao-link",function(){
		//보낼 내용을 불러온다. 
		let title=$(this).attr("data-title");
		let content=$(this).attr("data-content");
		let author=$(this).attr("data-author");
		let msg = '['+title+']\n\n'+content+' by'+author; 
		

	    Kakao.Link.sendDefault({
	      objectType: 'text',
	      text: msg,
	      link: {
	        mobileWebUrl: 'https://developers.kakao.com/docs/js/kakaotalklink#텍스트-템플릿-보내기',
	        webUrl: 'https://developers.kakao.com/docs/js/kakaotalklink#텍스트-템플릿-보내기',
	      },
	    })
		 
		
	});
	
	//삭제 요청 시 삭제 여부 확인하는 스크립트 코드
	function deleteConfirm(){
		let num=$("#delete").attr("data-num");
		let isDelete=confirm("삭제하시겠습니까?");
		if(isDelete){
			location.href="private/delete.do?num="+num;
		}
	}
	
	
	
</script>



</body>
</html>