<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%int isCheck=0; %>
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
										<!-- 하트, 수정, 삭제  -->
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
											</c:forEach>
											<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
											<c:if test="${tmp.writer eq sessionScope.nick }">
											<span class="cmt-link"><small>|</small></span>
												<a class="cmt-link" href="private/updateform.do?num=${tmp.num }"><small>수정</small></a>
											<span class="cmt-link"><small>|</small></span>
												<a class="cmt-link delete-link" data-num="${tmp.num }" href="javascript:"><small>삭제</small></a>	
											</c:if>	
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
				<%isCheck++; %><!-- 바깥 for문 빠져나가기 전에 isCheck증가시키기 -->
				<br />
			</c:forEach><!-- 바깥 for문 -->
	</div><!-- div wordingList -->