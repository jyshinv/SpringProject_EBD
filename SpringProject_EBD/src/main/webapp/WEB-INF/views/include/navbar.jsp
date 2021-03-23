<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.btn-border{
		border:none;
		
	}
	.round{
	 	
	 	
	}
</style>
<nav class="navbar navbar-light navbar-expand-sm fixed-top" style="background-color: #FEF9E7;" >
	<div class="container-fluid">

		<%-- 아래 href는 최상위 경로 요청이다. 링크를 클릭하면 최상위 경로 즉, index.jsp로 이동한다. --%>
	  	<%-- 브랜드 로고 svg --%>
		<a class="navbar-brand" href="${pageContext.request.contextPath }/">
			<img src="${pageContext.request.contextPath }/svg/ebd_logo.svg" width="60" height="60" alt="ebd로고" />
		</a>
		
		<%--화면을 줄이면 토글 버튼이 생긴다. data속성을 추가해 버튼을 클릭하면 사라진 링크가 뜰 수 있도록 한다.  --%>
		<%--눌렀을 때 동작을 결정하는 것은 자바스크립트가 한다. 따라서 jquery를 로딩해주어야한다.  --%>
		<button class="navbar-toggler navbar-light" data-toggle="collapse" data-target="#topNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<%--화면을 줄였을 때  링크가 사라지며 토글버튼이 생긴다. --%>
		<div class="collapse navbar-collapse" id="topNav">
			<%-- margin-right auto 속성값을 추가하면 ul태그 아래에 있는 속성들이 화면 우측으로 이동함 --%>
			<ul class="navbar-nav" >
				<%--thisPage에 저장된 값이 "public_report"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'public_report' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/public_report/list.do">독후감</a>
				</li>
				<%--thisPage에 저장된 값이 "gallery"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'wording' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/wording/list.do">조각글</a>
				</li>
				<%--thisPage에 저장된 값이 "episode"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'episode' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/episode/list.do">에피소드</a>
				</li>
				<%--thisPage에 저장된 값이 "market"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'market' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/market/list.do">북스마켓</a>
				</li>
				<%--thisPage에 저장된 값이 "file"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'file' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/file/list.do">양식공유</a>
				</li>
			</ul>
		</div>

		<div>
			<%-- 로그인/로그아웃/회원가입  --%>
			<c:choose>
				<%--session scope에 로그인 된 아이디가 있는지 찾아본다.--%>
				<c:when test="${empty sessionScope.id }">
					<a class="btn btn-light btn-sm btn-border" style=" background-color:#F7DC6F; border-radius:20px;"
					href="${pageContext.request.contextPath }/users/loginform.do">로그인</a>
					<a class="btn btn-secondary btn-sm ml-1 btn-border" style="background-color:#AF601A; border-radius:20px;"
					href="${pageContext.request.contextPath }/users/signupform.do">회원가입</a>
				</c:when>
				
				<%--로그인 된 아이디가 있을 때 아이디를 클릭하면 info.do요청을 하도록 한다. --%>
				<c:otherwise>
					<span class="navbar-text">
						 <dt class="nav-item dropdown">
					        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					          <img src="${pageContext.request.contextPath}/svg/ebd_icon.svg" width="25" height="25"/><span> ${sessionScope.nick }님</span>
					        </a>
					        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					          <a class="dropdown-item" href="${pageContext.request.contextPath }/my_report/private/list.do">나의 서재</a>
					          <a class="dropdown-item" href="${pageContext.request.contextPath }/users/private/info.do">나의 정보</a>
					          <a class="dropdown-item" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a>
					        </div>
					      </dt>	
					</span>
				</c:otherwise>
			</c:choose>
		</div>

	</div> <%--container --%>
</nav>     