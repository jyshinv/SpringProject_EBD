<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/detail</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	.btnStyle{
		text-align: center;
		margin-bottom: 20px;
	}
</style>
</head>
<body>
<!-- 독후감 양식 파일 공유(업로드/다운로드) 디테일 -->
<div class="container">
	
	<div class="card mb-3">
		<!-- 프로필 이미지 -->
		
		<h5 class="card-title">${dto.writer }</h5>
		<img class="card-img-top" src="${pageContext.request.contextPath }${dto.imgpath}"
		  	alt="Card image cap">
		  	  	
		<div class="card-body">
	  		<p class="card-text">
	  			<strong>파일명</strong> ${dto.orgfname } <strong>|</strong> 
	  			<fmt:formatNumber value="${dto.fileSize }" pattern="#,###"/><strong>byte</strong>
	  			<a class="btn btn-secondary" href="download.do?num=${dto.num }">다운로드 </a>
	  		</p>
	  		<p class="card-text">${dto.title }</p>
		    <p class="card-text">${dto.content }</p>
		    <p class="card-text"><small class="text-muted">${dto.regdate }</small></p>
		</div>
		 
	 	<!-- 작성자만 보이게-->
	    <c:if test="${dto.writer eq nick }">
		    <div class="btnStyle">
		    	<a href="${pageContext.request.contextPath }/file/private/updateform.do?num=${dto.num}" class="btn btn-dark" >
			 		수정</a>
				<a href="${pageContext.request.contextPath }/file/private/delete.do?num=${dto.num}" class="btn btn-dark">
					삭제</a>
		    </div>
	    </c:if>		
	</div>
	
	<!-- 페이징 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${dto.prevNum ne 0 }">
					<li class="page-item mr-3">
						<a class="page-link" href="detail.do?num=${dto.prevNum }">&larr; Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled mr-3">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${dto.nextNum ne 0 }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${dto.nextNum }">Next &rarr;</a>
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
	
	<!-- 댓글 -->
	<!-- 원글에 댓글을 작성하는 form -->                <!-- 컨트롤러 통해서 요청 -->
	<form class="comment-form insert-form" action="private/cmt_insert.do" method="post">
		<!-- 원글의 글번호가 ref_group 번호가 된다. -->
		<input type="hidden" name="ref_group" value="${dto.num }"/>
		<!-- 원글의 작성자가 댓글의 수신자가 된다. -->
		<input type="hidden" name="target_nick" value="${dto.writer }"/>
		<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다</c:if></textarea>
		<button type="submit">등록</button>
	</form>
	
	<!-- 댓글 목록 -->
	<div class="comments">
		<ul>
			<!-- 댓글 목록 반복문 -->
			<c:forEach var="tmp" items="${cmtList }">
				<c:choose>
					<c:when test="${tmp.deleted eq 'yse' }">
						<li>삭제된 댓글 입니다.</li>
					</c:when>

					<c:otherwise>
						<li id="cmt${tmp.num }" <c:if test="${tmp.num ne tmp.cmt_group }">style="padding-left:50px;"</c:if>>
							<c:if test="${tmp.num ne tmp.cmt_group }"><svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
		  						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/></svg>
							</c:if>
						
							 <dl>
							 	<dt>
							 		<span>${tmp.writer }</span>
							 		<c:if test="${tmp.num ne tmp.cmt_group }">
							 			@<i>${tmp.target_id }</i>
							 		</c:if>
							 		
							 		<span>${tmp.regdate }</span>
							 		<a data-num="${tmp.num }" href="javascript:" class="reply-link">답글</a>
							 		<c:if test="${tmp.writer eq nick }">
							 			| <a data-num="${tmp.num }" href="javascript:" class="cmt-update-link">수정</a>
										| <a data-num="${tmp.num }" href="javascript:" class="cmt-delete-link">삭제</a>
							 		</c:if>
							 	</dt>
							 	<dd>
							 		<pre>${tmp.content }</pre>
							 	</dd>
							 </dl>
							 
							 <!-- 답글 폼 -->
							 <form class="comment-form re-insert-form"
							 	action="private/cmt_insert.do" method="post">
							 
							 </form>
						
							<!-- 만일 로그인된 닉네임과 댓글의 작성자가 동일하다면 수정 폼 출력 -->
							<c:if test="${tmp.writer eq nick }">
								<form class="comment-form update-form"
									action="private/cmt_update.do" method="post">
									<input type="hidden" name="num" value="${tmp.num }" />
									<textarea name="content">${tmp.content }</textarea>
									<button type="submit">수정</button>
								</form>
							</c:if>
							
						</li>
					</c:otherwise>
				</c:choose>			
			</c:forEach>
				
				
			
		
			
		</ul>
	</div>
</div>
	
	
<script>
	
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".cmt-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#cmt"+$(this).attr("data-num");
		//구성된 id  선택자를 이용해서 원하는 li 요소에서 .update-form 을 찾아서 동작하기
		$(selector)
		.find(".update-form")
		.slideToggle();
	});
	
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정폼을 
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".update-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){
			//console.log(data);
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#cmt"+data.num; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	$(document).on("click",".cmt-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		var isDelete=confirm("댓글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/file/private/cmt_delete.do?num="+num+"&ref_group=${dto.num}";
		}
	});
	
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/file/detail.do?num=${dto.num}";
		}
		
		var selector="#cmt"+$(this).attr("data-num");
		$(selector)
		.find(".re-insert-form")
		.slideToggle();
		
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답들로 바꾼다.
		}	
	});
	
	// 로그인된 사람만 댓글 달수 ㅇㅇ
	$(document).on("submit",".insert-form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/file/detail.do?num=${dto.num}";
			return false; //폼 전송 막기 		
		}
	});
	
	// 댓글 삭제 컨펌 함수
	function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="delete.do?num=${dto.num}";
		}
	}
	
	//페이지가 처음 로딩될때 1page 를 보여준다고 가정
	var currentPage=1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	var totalPageCount=${totalPageCount};
	//현재 로딩중인지 여부
	var isLoading=false;
	
	/*
	페이지 로딩 시점에 document 의 높이가 window 의 실제 높이 보다 작고
	전체 페이지의 갯수가(totalPageCount) 현재페이지(currentPage)
	보다 크면 추가로 댓글을 받아오는 ajax 요청을 해야한다.
	*/
	var dH=$(document).height();//문서의 높이
	var wH=window.screen.height;//window 의 높이
	
	if(dH < wH && totalPageCount > currentPage){
		//로딩 이미지 띄우기
		$(".loader").show();
		
		currentPage++; //페이지를 1 증가 시키고 
		//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
		$.ajax({
			url:"ajax_cmt_list.do",
			method:"get",
			data:{pageNum:currentPage, ref_group:${dto.num}},
			success:function(data){
				console.log(data);
				//data 가 html 마크업 형태의 문자열 
				$(".comments ul").append(data);
				//로딩 이미지를 숨긴다. 
				$(".loader").hide();
			}
		});		
	}	
	
	//웹브라우저에 scoll 이벤트가 일어 났을때 실행할 함수 등록 
	$(window).on("scroll", function(){
		
		//위쪽으로 스크롤된 길이 구하기
		var scrollTop=$(window).scrollTop();
		//window 의 높이
		var windowHeight=$(window).height();
		//document(문서)의 높이
		var documentHeight=$(document).height();
		//바닥까지 스크롤 되었는지 여부
		var isBottom = scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){//만일 바닥까지 스크롤 했다면...
			if(currentPage == totalPageCount || isLoading){//만일 마지막 페이지 이면 
				return; //함수를 여기서 종료한다. 
			}
			//현재 로딩 중이라고 표시한다. 
			isLoading=true;
			//로딩 이미지 띄우기
			$(".loader").show();
			
			currentPage++; //페이지를 1 증가 시키고 
			//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
			$.ajax({
				url:"ajax_cmt_list.do",
				method:"get",
				data:{pageNum:currentPage, ref_group:${dto.num}},
				success:function(data){
					console.log(data);
					//data 가 html 마크업 형태의 문자열 
					$(".comments ul").append(data);
					//로딩 이미지를 숨긴다. 
					$(".loader").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
				}
			});
		}
	});			
	
</script>
</body>
</html>