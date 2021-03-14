<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 
	메인 nav tab 만들기
	
	브랜드로고(svg로 만들기):홈으로 이동  | 검색창  | 닉네임:마이페이지이동/로그인:로그인페이지이동/회원가입:회원가입페이지이동
	
--%>
 
  
<nav class="navbar navbar-light navbar-expand-sm fixed-top" style="background-color: #e3f2fd;" >
	<div class="container">
		
		<%-- 브랜드 로고 svg --%>
		<a class="navbar-brand" href="${pageContext.request.contextPath }/">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
				<path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811V2.828zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492V2.687zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783z"/>
			</svg> EveryBookDay
		</a>
		
		<%-- 검색 창을 가운대로 옮겨야함 --%>
		<form class="form-inline mr-auto">
			<input class="form-control mr-sm-2" type="search" placeholder="도서명을 입력해주세요" aria-label="Search">
			<button class="btn btn-outline-dark my-2 my-sm-0" type="submit">Search</button>
		</form>
		
		<%-- 로그인/로그아웃/회원가입  --%>
		<c:choose>
			<%--session scope에 로그인 된 아이디가 있는지 찾아본다.--%>
			<c:when test="${empty sessionScope.id }">
				<a class="btn btn-secondary btn-sm" 
				href="${pageContext.request.contextPath }/users/loginform.do">로그인</a>
				<a class="btn btn-secondary btn-sm ml-1" 
				href="${pageContext.request.contextPath }/users/signupform.do">회원가입</a>
			</c:when>
			
			<%--로그인 된 아이디가 있을 때 아이디를 클릭하면 info.do요청을 하도록 한다. --%>
			<c:otherwise>
				<span class="navbar-text">
					<%-- 그림을 누르면 마이다이어리 리스트로 이동 --%>
					<a href="${pageContext.request.contextPath }/my_report/private/list.do">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
						  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811V2.828zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492V2.687zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783z"/>
						</svg>
					</a>
					<a href="${pageContext.request.contextPath }/users/private/info.do">${sessionScope.nick }</a>
					<a class="btn btn-info btn-sm" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a>
				</span>
			</c:otherwise>
		</c:choose>
		
		
			
		
	</div>
	
	
</nav>




