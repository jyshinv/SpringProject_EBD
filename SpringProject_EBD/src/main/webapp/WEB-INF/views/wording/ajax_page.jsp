<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%int isCheck=0; %>
	<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
	<div id="wordingList">
		<c:forEach var="tmp" items="${list }">
			<c:if test="${not empty id }">
				<%isCheck=0; %>
				<c:forEach var="tmp2" items="${list2 }">
					<c:if test="${tmp.num eq tmp2.target_num }">
						<%isCheck=1;%>
		                <a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">하트눌림~</a>
					</c:if>
				</c:forEach>
				<%if(isCheck == 0) {%>
		                <a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">하트</a>							
				<%} %>				
			</c:if>
			<p>
				${tmp.num } ${tmp.writer } ${tmp.title } ${tmp.content } ${tmp.author } ${tmp.viewcnt } ${tmp.regdate }
			</p>
		</c:forEach>
		
	</div>
