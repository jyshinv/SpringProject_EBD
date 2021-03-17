<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	/* 답글/수정/삭제 색 변경 */
	.cmt-link
	.cmt-regdate{
   		color:grey;
   }
   /* 모든 a링크의 hover 색깔 변경 (임시) */
   	a:hover{
   		color:brown;
   }
   /* 답글 아이콘 180도 회전 */
   .reply-link{
   		transform: rotate(180deg);
   }
</style>    
<c:forEach var="tmp" items="${commentList }"><%--댓글목록을 이용 --%>
	<c:choose>
		<c:when test="${tmp.deleted eq 'yes' }">
			<li>삭제된 댓글 입니다.</li><%-- li만 출력 --%>
		</c:when>
		<c:otherwise>
			<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.cmt_group }">style="padding-left:50px;"</c:if>>
				<c:if test="${tmp.num ne tmp.cmt_group }">
				<!-- 
				답글 아이콘
				svg에서 색상을 변경할 때는 fill 요소를 사용할 것 
				-->
				<svg class="reply-link reply-icon" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 512.001 512.001" style="enable-background:new 0 0 512.001 512.001; width:20px; height:20px; margin-top:20px; fill:grey;" xml:space="preserve" >
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
								<!-- 댓글 날짜 작게하기 글자 회색으로 만드는 클래스 추가 -->
									<span>
										<small class="cmt-regdate">
											${tmp.regdate }
										</small>
									</span>
							</div>
							<div class="col text-right">
								<span>
									<small>
										<a data-num="${tmp.num }" href="javascript:" class="reply-link cmt-link">답글</a>
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
				<form class="comment-form re-insert-form" 
					action="private/comment_insert.do" method="post">
					<input type="hidden" name="ref_group"
						value="${dto.num }"/>
					<input type="hidden" name="target_nick"
						value="${tmp.writer }"/>
					<input type="hidden" name="cmt_group"
						value="${tmp.cmt_group }"/>
					<div class="row">
						<div class="col-12">
							<textarea class="form-control" name="content"></textarea>
						</div>
						<div class="col text-right">
							<button class="btn btn-primary" type="submit">답글등록</button>
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
								<button class="btn btn-primary" type="submit">수정등록</button>
							</div>
						</div>
					</form>
				</c:if>
			</li>						
		</c:otherwise>
	</c:choose>
</c:forEach>