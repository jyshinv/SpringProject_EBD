<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-light navbar-expand-sm" style="background-color: #e3f2fd;" >
	<div class="container">
		
		<%--화면을 줄이면 토글 버튼이 생긴다. data속성을 추가해 버튼을 클릭하면 사라진 링크가 뜰 수 있도록 한다.  --%>
		<%--눌렀을 때 동작을 결정하는 것은 자바스크립트가 한다. 따라서 jquery를 로딩해주어야한다.  --%>
		<button class="navbar-toggler navbar-dark" data-toggle="collapse" data-target="#topNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<%--화면을 줄였을 때  링크가 사라지며 토글버튼이 생긴다. --%>
		<div class="collapse navbar-collapse" id="topNav">
			<%-- margin-right auto 속성값을 추가하면 ul태그 아래에 있는 속성들이 화면 우측으로 이동함 --%>
			<ul class="navbar-nav mr-auto">
				<%--thisPage에 저장된 값이 "my_report"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'my_report' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/my_report/private/list.do">my_report</a>
				</li>
				<%--thisPage에 저장된 값이 "public_report"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'public_report' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/public_report/list.do">public_report</a>
				</li>
				<%--thisPage에 저장된 값이 "market"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'market' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/market/list.do">market</a>
				</li>
				<%--thisPage에 저장된 값이 "file"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'file' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/file/list.do">file</a>
				</li>
				<%--thisPage에 저장된 값이 "episode"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'episode' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/episode/list.do">episode</a>
				</li>
				<%--thisPage에 저장된 값이 "gallery"이면 active시켜라 포커싱된다. --%>
				<li class="nav-item ${param.thisPage eq 'wording' ? 'active':''}">
					<%--글 목록 링크를 누르면 href로 설정한 곳으로 이동(요청) --%>
					<a class="nav-link" href="${pageContext.request.contextPath }/wording/list.do">wording</a>
				</li>
			</ul>
		
	</div>
	
	
</nav>
