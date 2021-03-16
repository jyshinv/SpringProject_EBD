<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container ">
	<div class="container text-center">
		<div>
			<c:choose>
				<c:when test="${empty dto.profile}">
					<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
			  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
					</svg>
				</c:when>
				<c:otherwise>
					<img id="profileImage" src="${pageContext.request.contextPath}${dto.profile}">
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<p style="font-size:30px;">${sessionScope.nick }</p>
			<p style="color:grey">${sessionScope.id }</p>
		</div>
	</div>
	<nav class="navbar navbar-expand-sm" style="border-bottom:1px black solid; border-top: 1px black solid;">
		<div class="container">
			<button class="navbar-toggler navbar-dark" data-toggle="collapse" data-target="#topNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="container collapse navbar-collapse justify-content-md-center" id="topNav">
				<ul class="nav">
					<li class="nav-item ${param.thisPage eq 'my_report' ? 'active':''}">
						<a class="nav-link" href="${pageContext.request.contextPath }/my_report/private/list.do">나의 독후감</a>
					</li>
					<li class="nav-item ${param.thisPage eq '' ? 'active':''}">
						<a class="nav-link" href="#">내가 누른 하트</a>
					</li>
					<li class="nav-item ${param.thisPage eq 'market' ? 'active':''}">
						<a class="nav-link" href="#">내가 쓴 게시글</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</div>
