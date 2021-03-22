<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>episode/detail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* 댓글 css */
	/* 글 내용을 출력할 div 에 적용할 css */
	.contents{
		width: 100%;
		border: 1px dotted #cecece;
	}
	/* 댓글 프로필 이미지를 작은 원형으로 만든다. */
	.profile-image{
		width: 50px;
		height: 50px;
		border-radius: 50%;
	}
	/* ul 요소의 기본 스타일 제거 */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 50px;
	}
	.comment-form textarea, .comment-form button{
		float: none;
	}
	.comments li{
		clear: left;
	}
	.comments ul li{
		border-top: 1px solid lightgrey;
	}
	.comment-form textarea{
		width: 100%;
		height: 100px;
	}
	.comment-form button{
		width: 15%;
		background-color:#F7DC6F;
	}
	/* 댓글 버튼 호버 시 색 변경 */
	.comment-form button:hover,
	.page-link:hover{
		background-color:#FBEEE6;
	}
	.page-link{
		background-color:#F7DC6F;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
	.comments .comment-form{
		display: none;
	}
	/* .reply_icon 을 li 요소를 기준으로 배치 하기 */
	.comments li{
		position: relative;
	}
	.comments .reply-icon{
		position: absolute;
		top: 1em;
		left: 1em;
		transform: rotate(180deg);
	}
	pre {
	  display: block;
	  padding: 9.5px;
	  margin: 0 0 10px;
	  font-size: 13px;
	  line-height: 1.42857143;
	  color: #333333;
	  word-break: break-all;
	  word-wrap: break-word;
	  background-color: none;
	}
	/* 글 내용중에 이미지가 있으면 최대 폭을 100%로 제한하기 */
	.contents img{
		max-width: 100%;
	}
	.loader{
		position: fixed; /* 좌하단 고정된 위치에 배치 하기 위해 */
		width: 100%;
		left: 0;
		bottom: 0;
		text-align: center; /* 이미지를 좌우로 가운데  정렬 */
		z-index: 1000;
		display: none; /* 일단 숨겨 놓기 */
	}	
	/* 답글 아이콘 180도 회전 */
   .reply-link{
   		transform: rotate(180deg);
   }
	/* 답글/수정/삭제 댓글알림글 색 변경 */
   .cmt-link,
   .cmt-regdate,
   .cmt-small{
   		color:grey;
   }
    /* 모든 a링크의 hover 색깔 변경 (임시) */
   a:hover,
   .link>a:hover{
   		color:#F7DC6F;
   		text-decoration: none;
   }
   .page-link:hover{
   		text-decoration: none;
   }
   .link>a,
   .page-link,
   .page-link:hover{
   		color:#212529;
   }	
   .page-link{
   		border:none;
   }
	/*하트의 크기와 색을 조절*/
	.heart-link,
	.heart-link:hover{
		font-size : 2em;
		color: red;
		text-decoration: none;
	}
	
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
	
		border-radius: 50%;
	}
    .card{
   		padding-left:20px;
   		padding-right:20px;
   }  
   .card-body{
   		padding-left:0px;
   		padding-right:0px;
   }   
   .card-header{
   		background-color:rgba(0, 0, 0, 0);
   }
      
   /* 이미지 카드 안에서 100% 보이게 하기 */
    .centerimg img{
    	max-width: 100%;
    }
   /* 뷰카운트, 날짜 글자색 변경 */
   #view-reg{
   		color:grey;
   }
   /* text-decoration 속성값을 none으로 설정하여 링크(link)가 설정된 텍스트의 밑줄을 제거하는데 자주 사용합니다. 
   		왜 적용 안됨 ㅋ 
   */
    /* 전체적으로 보기 좋게 하기 위해 간격 띄우기 */
    .marg{
    	margin-bottom:20px;
    }
    /* 제목과 헤더 사이 간격 띄우기 */
   h1{
   		margin-top:30px;
   }
    .bi-pencil,
	.bi-trash{
		color:#FFCA28;
		margin-left:5px;
		margin-bottom:10px;
	}  
	body{
		padding-top:120px;
		margin-bottom:30px;
	} 
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="episode" name="thisPage"/>
</jsp:include>
<div class="container">
	<div class="card mb-3 card-padding">
		<div class="row card-header">
			<span class="col-1">
				<!-- 프로필 이미지 -->
				<c:choose>
			         <c:when test="${empty dataDto.profile }">
			            <!-- 비어있다면 기본이미지 -->
			            <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
			                 <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
			            </svg>
			         </c:when>
			         <c:otherwise>
			            <!-- 이미지를 업로드 했다면 업로드한 이미지를 불러온다.-->
			            <img id="profileImage" src="${pageContext.request.contextPath }${dataDto.profile}"/>
			         </c:otherwise>
		      	</c:choose>
			</span>
	      	<span class="col" style="padding-top: 15px; padding-left: 0px;">
	      		<b>${dataDto.writer }</b>
	      	</span>
		</div>
		<!-- 제목 -->
		<div class="text-center marg">
			<h1>${dataDto.title }</h1>
		</div>
		<!-- 조회수 등록일 -->
		<div class="text-right marg" id="view-reg">
			<span>
				<small>
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
				  <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 1 0 1 0V6.435a4.9 4.9 0 0 1 .106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 0 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.035a.5.5 0 0 1-.416-.223l-1.433-2.15a1.5 1.5 0 0 1-.243-.666l-.345-3.105a.5.5 0 0 1 .399-.546L5 8.11V9a.5.5 0 0 0 1 0V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v5.34l-1.2.24a1.5 1.5 0 0 0-1.196 1.636l.345 3.106a2.5 2.5 0 0 0 .405 1.11l1.433 2.15A1.5 1.5 0 0 0 6.035 16h6.385a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"/>
				</svg>
				&nbsp;${dataDto.viewcnt } 
				</small>
			</span>
			&nbsp;&nbsp;
			<span>
				<small class="text-muted">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar2-check" viewBox="0 0 16 16">
					  <path d="M10.854 8.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
					  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
					  <path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4z"/>
					</svg> 
					<span>&nbsp;${dataDto.regdate }</span>
				</small> 
			</span>
		</div>
		<!-- 이미지 -->
		<center class="centerimg">
			<img src="${pageContext.request.contextPath }${dataDto.imgPath}"/>
		</center>
		<div class="card-body">
			<div class="row">
				<div class="col text-left">
					<c:if test="${empty id }">
						<span>♥</span>
						<span class="heart-cnt">${heartcnt }</span>
					</c:if>
					<!-- 로그인을 해야지만 하트를 누를 수 있다. -->
					<c:if test="${not empty nick }">
							<c:choose>
								<c:when test="${isheartclick eq true }">
									<a data-num="${dataDto.num }" href="javascript:" class="heart-link" href="list.do">♥</a>
								</c:when>
								<c:otherwise>
									<a data-num="${dataDto.num }" href="javascript:" class="heart-link" href="list.do">♡</a>
								</c:otherwise>
							</c:choose>
						<span class="heart-cnt">${heartcnt }</span>
						<!-- 작성자와 닉네임이 같으면 수정과 삭제를 출력 -->
						<c:if test="${dataDto.writer eq nick }">
					    	<a href="private/updateform.do?num=${dataDto.num }">
						 		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
								  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
								</svg>
				 			</a>
							<a href="private/delete.do?num=${dataDto.num }">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
								  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
								  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
								</svg>
							</a>
			   			</c:if>		
					</c:if>
				</div>
			</div>
			<p class="card-text">${dataDto.content }</p>
		</div>
		<!-- 하단 페이징 -->
		<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${dataDto.prevNum ne 0 }">
					<li class="page-item mr-3">
						<a class="page-link" href="detail.do?num=${dataDto.prevNum }">&larr; Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled mr-3">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${dataDto.nextNum ne 0 }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${dataDto.nextNum }">Next &rarr;</a>
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
	
	<div style="margin-top:20px;">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-text cmt-small" viewBox="0 0 16 16">
		  <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
		  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
		</svg>
		<small>
			<span class="cmt-small">
				Every Book Day는 선한 댓글 문화를 지향합니다.
			</span>
		</small>
	</div>
	<hr/>
	<!-- 댓글 관련 UI 시작 -->
	<!-- 원글에 댓글을 작성하는 form -->
	<form class="comment-form insert-form" action="private/comment_insert.do" method="post">
		<!-- 원글의 글번호가 ref_group 번호가 된다. -->
		<input type="hidden" name="ref_group" value="${dataDto.num }"/>
		<!-- 원글의 작성자가 댓글의 수신자가 된다. -->
		<input type="hidden" name="target_nick" value="${dataDto.writer }"/>
		<div class="row">
			<div class="col-12">
				<textarea class="form-control" name="content"><c:if test="${empty id }">로그인이 필요합니다</c:if></textarea>
			</div>
			<div class="col text-right">
				<button class="btn" type="submit">등록
					<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
						 width="20px" height="20px" viewBox="0 0 467.276 467.276" style="enable-background:new 0 0 467.276 467.276;"
						 xml:space="preserve">
							<g>
								<g>
									<path d="M379.281,51.144C348.254,24.297,309.565,13.46,269.577,8.672C163.068-25.3,68.062,44.959,26.578,142.38
										c-44.714,105.002-23.44,222.217,73.516,287.698c98.985,66.846,235.019,39.369,310.95-48.627
										C494.023,285.274,473.539,132.719,379.281,51.144z M196.847,432.703C140.695,424.71,86.21,390.16,57.756,340.898
										c-25.438-44.047-25.225-99.203-13.822-147.312c17.529-73.96,70.568-140.71,139.888-156.686c0.104,0.005,0.19,0.035,0.295,0.035
										c24.95,0.739,51.292,0.782,77.046,3.567c2.438,0.764,4.88,1.523,7.332,2.42c4.062,1.48,7.612,1.29,10.588,0.071
										c27.781,4.677,54.313,13.579,76.951,31.392c50.079,39.405,76.479,110.461,75.032,172.696
										C428.354,364.389,307.965,448.516,196.847,432.703z"/>
									<path d="M169.276,211.913c23.28,0,23.28-36.104,0-36.104C145.999,175.808,145.999,211.913,169.276,211.913z"/>
									<path d="M293.833,213.715c23.277,0,23.277-36.102,0-36.102C270.551,177.613,270.551,213.715,293.833,213.715z"/>
									<path d="M302.731,274.966c-43.25,42.975-99.046,38.689-142.352-1.808c-16.98-15.879-42.566,9.598-25.529,25.532
										c57.625,53.893,136.062,58.787,193.407,1.802C344.792,284.065,319.254,258.544,302.731,274.966z"/>
								</g>
						</svg>
				</button>
			</div>
		</div>
	</form>	
	<!-- 댓글 목록 -->
	<div class="comments">
		<ul>
			<c:forEach var="tmp" items="${commentList }">
				<c:choose>
					<c:when test="${tmp.deleted eq 'yes' }">
						<li>삭제된 댓글 입니다.</li>
					</c:when>
					<c:otherwise>
						<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.cmt_group }">style="padding-left:50px;"</c:if>>
							<!-- 댓글의 글번호가 그룹번호와 다르면 들여쓰기를 하겠다. 빨간 화살표 이미지와 함께 들여쓰기를 함-->
							<c:if test="${tmp.num ne tmp.cmt_group }"><svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<!-- 답글 아이콘 svg에서 색상을 변경할 때는 fill 요소를 사용할 것 -->
								<svg class="reply-link reply-icon" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
								 viewBox="0 0 512.001 512.001" style="enable-background:new 0 0 512.001 512.001; width:20px; height:20px; margin-top:20px; fill:#F7DC6F;" xml:space="preserve" >
									<g>
										<g>
											<path d="M324.104,156.152H76.526l91.949-91.949l-28.268-28.268L0,176.141l140.206,140.206l28.268-28.268L76.526,196.13h247.579
												c81.562,0,147.918,66.356,147.918,147.918c0,38.36-19.398,70.958-35.671,91.548l-12.393,15.682l31.366,24.788l12.393-15.682
												c20.202-25.563,44.284-66.497,44.284-116.336C512,240.441,427.71,156.152,324.104,156.152z"/>
										</g>
								</svg>
							</c:if>
							<dl>
								<dt>
									<div class="row">
										<div class="col">
											<span>${tmp.writer }</span>
											<c:if test="${tmp.num ne tmp.cmt_group }">
												@<i>${tmp.target_nick }</i>
											</c:if>
											<span>
												<small class="cmt-regdate">${tmp.regdate }</small>
											</span>
										</div>
										<div class="col text-right">
											<span>
												<small>
													<a data-num="${tmp.num }" href="javascript:" class="reply-link cmt-link">답글</a>
													<!-- 아이디와 댓글의 작성자가 같으면 수정과 삭제 버튼을 출력 -->
													<c:if test="${tmp.writer eq nick }">
														<span class="cmt-link">|</span> 
														<a data-num="${tmp.num }" href="javascript:" class="comment-update-link cmt-link">수정</a>
														<span class="cmt-link">|</span> 
														<a data-num="${tmp.num }" href="javascript:" class="comment-delete-link cmt-link">삭제</a>
													</c:if>
												</small>
											</span>
										</div>
									</div>
								</dt>
								<dd>
									<pre>${tmp.content }</pre>
								</dd>
							</dl>
							<!-- 댓글에 댓글을 다는 폼 comment_groupt번호를 추가로 보내주어야한다. -->
							<form class="comment-form re-insert-form" 
								action="private/comment_insert.do" method="post">
								<input type="hidden" name="ref_group"
									value="${dataDto.num }"/>
								<input type="hidden" name="target_nick"
									value="${tmp.writer }"/>
								<input type="hidden" name="cmt_group"
									value="${tmp.cmt_group }"/>
								<div class="row">
									<div class="col-12">
										<textarea class="form-control" name="content"></textarea>
									</div>
									<div class="col text-right">
										<button class="btn" type="submit">등록</button>
									</div>
								</div>
							</form>
							<!-- 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 -->
							<c:if test="${tmp.writer eq nick }">
								<form class="comment-form update-form" 
									action="private/comment_update.do" method="post">
									<input type="hidden" name="num" value="${tmp.num }"/>
									<div class="row">
										<div class="col-12">
											<textarea class="form-control" name="content">${tmp.content }</textarea>
										</div>
										<div class="col text-right">
											<button class="btn" type="submit">수정</button>
										</div>
									</div>
								</form>
							</c:if>
						</li>						
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</div>		
</div>
<div class="loader">
	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif"/>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<script>
	//하트를 클릭할 때마다 호출되는 함수 등록
	$(document).on("click",".heart-link",function(){
		//글 번호를 불러온다.
		var target_num=$(this).attr("data-num");
	
		if($(this).text()=="♡"){ //하트일때 클릭하면
			
			//insert 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/episode/saveheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){ //나중에 구현 : 하트 수를 반환
					$(".heart-cnt").text(data.heartCnt);
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
					$(".heart-cnt").text(data.heartCnt);
				} 				
			});
			
			$(this).text("♡");//하트로 바뀐다. 
		}
		
	});
	

	
	//여기서부터는 댓글관련 script 코드
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(document).on("click",".comment-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 
			읽어와서 id 선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");
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
			var selector="#comment"+data.num; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	//댓글 삭제 여부를 묻는 안내 
	$(document).on("click",".comment-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		var isDelete=confirm("댓글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+
			"/episode/private/comment_delete.do?num="+num+"&ref_group=${dataDto.num}";
		}
	});
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/episode/detail.do?num=${dataDto.num}";
		}
		
		var selector="#comment"+$(this).attr("data-num");
		$(selector)
		.find(".re-insert-form")
		.slideToggle();
		
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답들로 바꾼다.
		}	
	});
	$(document).on("submit",".insert-form", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/episode/detail.do?num=${dataDto.num}";
			return false; //폼 전송 막기 		
		}
	});
	//댓글삭제 아님!! 글 삭제에 대한 스크립트 코드임!!
	/*function deleteConfirm(){
		var isDelete=confirm("이 글을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="delete.do?num=${dataDto.num}";
		}
	}*/
	
	//페이지가 처음 로딩될때 1page 를 보여준다고 가정
	var currentPage=1;
	//전체 페이지의 수를 javascript 변수에 담아준다.
	var totalPageCount=${totalPageCount};
	
	//현재 로딩중인지 여부
	var isLoading=false;	
	console.log('new');
	/*
	페이지 로딩 시점에 document 의 높이가 window 의 실제 높이 보다 작고
	전체 페이지의 갯수가(totalPageCount) 현재페이지(currentPage)
	보다 크면 추가로 댓글을 받아오는 ajax 요청을 해야한다.
	*/
	
/*	
	var dH=$(document).height();//문서의 높이
	var wH=window.screen.height;//window 의 높이
	
	if(dH < wH && totalPageCount > currentPage){
		
		//로딩 이미지 띄우기
		$(".loader").show();
		
		currentPage++; //페이지를 1 증가 시키고 
		//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
		$.ajax({
			url:"ajax_comment_list.do",
			method:"get",
			data:{ pageNum:currentPage, ref_group:${dataDto.num} },
			success:function(data){
				console.log('성공했다');
				console.log(data);
				//data 가 html 마크업 형태의 문자열 
				$(".comments ul").append(data);
				//로딩 이미지를 숨긴다. 
				$(".loader").hide();
			}
		});		
	}	
*/	
	//웹브라우저에 scoll 이벤트가 일어 났을때 실행할 함수 등록 
	$(window).on("scroll", function(){
		console.log("들어옴2");
		//위쪽으로 스크롤된 길이 구하기
		var scrollTop=$(window).scrollTop();
		//window 의 높이
		var windowHeight=$(window).height();
		//document(문서)의 높이
		var documentHeight=$(document).height();
		//바닥까지 스크롤 되었는지 여부
		var isBottom = scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){//만일 바닥까지 스크롤 했다면...
			console.log(currentPage+','+totalPageCount+','+isLoading);
			if(currentPage == totalPageCount || isLoading){//만일 마지막 페이지 이면 
				console.log('종료할거임')
				return; 
			}
			//현재 로딩 중이라고 표시한다. 
			isLoading=true;
			//로딩 이미지 띄우기
			$(".loader").show();
			
			currentPage++; //페이지를 1 증가 시키고 
			
			//해당 페이지의 내용을 ajax  요청을 해서 받아온다. 
			$.ajax({
				url:"ajax_comment_list.do",
				method:"get",
				data:{pageNum:currentPage, ref_group:${dataDto.num}},
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
	
	
	//페이지가 뒤로가기 하면 하트버튼과 하트수 갱신이 안된다. 이때 하트를 누르면 디비에 중복으로 값이 들어가진다.
	//방지하기 위해 페이지가 뒤로가기 할때마다 css로 클릭을 막고 새로고침을 통해 갱신된 하트버튼과 하트수가 나오도록 한다.
	$(window).bind("pageshow", function (event) {
		if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
			console.log('BFCahe로부터 detail 복원됨');
			$(".heart-link").css("pointer-events","none");
			location.reload();//새로고침하기
		}
		else {
			console.log('새로 열린 detail 페이지');
		}
		
	});
	
	
</script>
</body>
</html>