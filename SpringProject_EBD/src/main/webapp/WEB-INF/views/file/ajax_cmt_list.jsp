<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- file --%>
 <c:forEach var="tmp" items="${cmtList }">
	<c:choose>
		<c:when test="${tmp.deleted eq 'yes' }">
			<li>삭제된 댓글 입니다.</li>
		</c:when>
		
		<c:otherwise>						<!-- num과 cmt_group가 같지 않다면 -->
			<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.cmt_group }">style="padding-left:50px;"</c:if>>
				<!-- num과 cmt_group가 같지 않다면 -->
				<c:if test="${tmp.num ne tmp.cmt_group }"><svg class="reply-icon" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-return-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
 						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
 						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/></svg>
				</c:if>
				<dl>
					<dt>
						<span>${tmp.writer }</span>
						<!-- num과 cmt_group가 같지 않다면 -->
						<c:if test="${tmp.num ne tmp.cmt_group }">
							@<i>${tmp.target_nick }</i>
						</c:if>
						
						<span>${tmp.regdate }</span>
						<a data-num="${tmp.num }" href="javascript:" class="reply-link">답글</a>
						<!-- 작성자와 닉네임이 같다면 -->
						<c:if test="${tmp.writer eq nick }">
							| <a data-num="${tmp.num }" href="javascript:" class="comment-update-link">수정</a>
							| <a data-num="${tmp.num }" href="javascript:" class="comment-delete-link">삭제</a>
						</c:if>
					</dt>
					<dd>
						<pre>${tmp.content }</pre>
					</dd>
				</dl>
				<form class="comment-form re-insert-form" action="private/cmt_insert.do" method="post">
					<input type="hidden" name="ref_group" value="${dto.num }"/>
					<input type="hidden" name="target_nick" value="${tmp.writer }"/>
					<input type="hidden" name="cmt_group" value="${tmp.cmt_group }"/>
					<textarea name="content"></textarea>
					<button type="submit">등록</button>
				</form>
				
				<!-- 로그인된 아이디와 댓글의 작성자가 같으면 수정 폼 출력 -->
				<c:if test="${tmp.writer eq id }">
					<form class="comment-form update-form" action="private/cmt_update.do" method="post">
						<input type="hidden" name="num" value="${tmp.num }"/>
						<textarea name="content">${tmp.content }</textarea>
						<button type="submit">수정</button>
					</form>
				</c:if>
			</li>						
		</c:otherwise>
	</c:choose>
</c:forEach> 