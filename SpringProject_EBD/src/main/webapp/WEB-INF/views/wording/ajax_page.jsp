<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%int isCheck=0; %>
<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
<div id="wordingList">
	<c:forEach var="tmp" items="${list }">
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
				<span class="heart-cnt${tmp.num }">(${heartCntList[i]})</span>					
			</c:forEach>
			<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
			<c:if test="${tmp.writer eq sessionScope.nick }">
				| <a href="private/updateform.do?num=${tmp.num }">수정</a>
				| <a href="private/delete.do?num=${tmp.num }">삭제</a>	
			</c:if>	
		</c:if>
		<p>
			${tmp.num } ${tmp.writer } ${tmp.title } ${tmp.content } ${tmp.author } ${tmp.viewcnt } ${tmp.regdate }
		</p>
		<%isCheck++; %>
	</c:forEach>
	
</div>
