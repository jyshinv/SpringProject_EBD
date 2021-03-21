<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%int isCheck=0; %>
<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
<div id="wordingList">
		<c:forEach var="tmp" items="${list }">
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
										<a href="private/updateform.do?num=${tmp.num }">| 수정</a>
										<a href="private/delete.do?num=${tmp.num }">| 삭제</a>	
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
