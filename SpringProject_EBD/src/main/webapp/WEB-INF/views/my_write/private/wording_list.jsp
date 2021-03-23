<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<!-- kakao api를 사용하기 위한 sdk를 추가해주기 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<style>
	/*버튼 관련 css*/
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
    
    
    /*리스트 관련 css*/
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
	

	
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 100px;
		height: 100px;
		border-radius: 50%;
	}
	
	/*부모요소의 items를 center로*/
    .row{
        align-items: center;
        height: 280px;
    }

    /*자식요소의 text-align를 center로*/
   #wording-container{
       text-align: center;
   }
   
   /*card의 모서리를 둥글게*/
   .card{
   		background-color:#FEF9E7;
   		border-radius: 50px;
   		border:none;
   		height:280px;
   }
   	/* 답글/수정/삭제 색 변경 */
	.cmt-link{
   		color:grey;
   }
   /* 모든 a링크의 hover 색깔 변경 (임시) */
   	a:hover{
   		color:#F7DC6F;
   		text-decoration: none;
   }
   	#writer{
    	font-size:0.9em;
    	padding-top: 13px;
    	margin-bottom: 0px;
    }
    #title{
    	color:grey;
    }
    #card-width{
    	width: 950px;
    	margin-bottom:30px;
    }
    #search{
    	height:100px;
    }
       
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<jsp:include page="../../include/mydiary_jumbotron.jsp"></jsp:include>
<jsp:include page="../../include/mydiarynav.jsp">
	<jsp:param value="my_write" name="thisPage"/>
</jsp:include>
<div class="container" id="wording-container">
	<form action="my_write_category.do" method="get">
		<div class="row justify-content-md-center" style="margin:10px; height:100px">
			<div class="col-8">
				<select class="form-control" name="condition" id="condition">
					<option value="wording" selected>명언/글귀</option>
					<option value="episode">에피소드</option>
					<option value="market">마켓</option>
					<option value="file">파일</option>
				</select>
			</div>
			<span>
				<button id="button" class="btn btn-light" style="background-color:#F7DC6F;">이동</button>
			</span>
		</div>
	</form>	
	
	<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
	<div id="wordingList">
			<c:forEach var="tmp" items="${list }">
				<div class="container" id="card-width">
					<div class="card">
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
									<!-- 닉네임  -->
									<p id="writer"><strong>${tmp.writer }</strong></p>
									<p>
										<!-- 수정, 삭제  -->
										<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
										<c:if test="${tmp.writer eq sessionScope.nick }">
											<a class="cmt-link" href="${pageContext.request.contextPath }/wording/private/updateform.do?num=${tmp.num }"><small>수정</small></a>
										<span class="cmt-link"><small>|</small></span>
											<a class="cmt-link" id="delete" data-num="${tmp.num }" href="javascript:deleteConfirm()"><small>삭제</small></a>	
										</c:if>	
									</p>
								</div>
								<div class="col-7">
									<!-- 글귀와 제목, 작가 -->
									<p><strong>${tmp.content }</strong></p>
									<br />
									<p id="title">
										<small>
											${tmp.title }, ${tmp.author }
										</small>
									</p>
								</div>
								<div class="col-2">
									<p>
										<!-- 카카오 이미지 링크 넣기 -->
										<a class="kakao-link" href="javascript:" data-profile="${tmp.profile }" data-title="${tmp.title }" data-content="${tmp.content }" data-author="${tmp.author }" >
												<svg enable-background="new 0 0 24 24" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg"><path d="m12 1c-6.627 0-12 4.208-12 9.399 0 3.356 2.246 6.301 5.625 7.963-1.678 5.749-2.664 6.123 4.244 1.287.692.097 1.404.148 2.131.148 6.627 0 12-4.208 12-9.399 0-5.19-5.373-9.398-12-9.398z" fill="#3e2723"/><g fill="#ffeb3b"><path d="m10.384 8.27c-.317-.893-1.529-.894-1.845-.001-.984 3.052-2.302 4.935-1.492 5.306 1.078.489 1.101-.611 1.359-1.1h2.111c.257.487.282 1.588 1.359 1.1.813-.371-.489-2.195-1.492-5.305zm-1.614 2.987.692-1.951.691 1.951z"/><path d="m5.365 13.68c-1.198 0-.49-1.657-.692-4.742-.429-.074-1.76.297-1.76-.673 0-.371.305-.673.679-.673 2.518.18 4.224-.47 4.224.673 0 .987-1.275.59-1.76.673-.2 3.075.505 4.742-.691 4.742z"/><path d="m13.154 13.579c-1.159 0-.454-1.565-.663-5.301 0-.91 1.413-.909 1.413 0v4.04c.669.089 2.135-.33 2.135.63-.001 1.007-1.576.503-2.885.631z"/><path d="m19.556 13.38-1.624-2.137-.24.239v1.5c0 .38-.31.688-.693.688-1.203 0-.482-1.732-.692-5.392 0-.379.31-.688.692-.688 1.045 0 .594 1.478.692 2.166 1.96-1.873 1.913-2.072 2.316-2.072.556 0 .897.691.527 1.058l-1.578 1.567 1.704 2.243c.556.725-.555 1.556-1.104.828z"/></g></svg>
										</a>
									</p>
								</div>
							</div>
	
						</div><!-- div card-body -->
					</div><!-- div card -->
				</div>
				<br />
			</c:forEach><!-- 바깥 for문 -->
	</div><!-- div wordingList -->
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
				url:"${pageContext.request.contextPath }/my_write/private/wording_ajax_page.do",
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
	

	Kakao.init('f2390c73f2911395fe314495c387c880'); // 초기화 + 카카오 디벨로퍼에 플랫폼까지 등록해주어야 한다.
	
	
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
	        mobileWebUrl: 'https://book.naver.com',
	        webUrl: 'https://book.naver.com',
	      },
	    })
		 
		
	});
	
	//삭제 요청 시 삭제 여부 확인하는 스크립트 코드
	function deleteConfirm(){
		let num=$("#delete").attr("data-num");
		let isDelete=confirm("삭제하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }/wording/private/delete.do?num="+num;
		}
	}
	
	
	
</script>
</body>
</html>