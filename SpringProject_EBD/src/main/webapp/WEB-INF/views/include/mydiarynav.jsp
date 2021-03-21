<%@page import="org.apache.ibatis.annotations.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	#profileImage1,
	#profileImage2{
		width: 200px;
	    height: 200px;
	    border: 1px solid #cecece;
	    border-radius: 50%;
		display:none;
	}
	#mdnavbar{
		border-top: 1px lightgrey solid;
		padding-top:0px;
	}
	/* 닉네임 프로필 사진 간격 조절 */
	.nick{
		margin-top: 16px;
		margin-bottom: 0px;
	}
	/* active 걸리는 쪽 위에 짙은 줄 효과 넣기 */
	.navbar-light .navbar-nav .active > .nav-link{
		border-top:2px solid black;
	}
</style>
<div class="container ">
	<div class="container text-center">
		<div class="container text-center">
			<!-- 
			<svg id="profileImage1" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
	  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
			</svg>
			-->
			<svg  id="profileImage1" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
		 width="96.433px" height="96.433px" viewBox="0 0 96.433 96.433" style="enable-background:new 0 0 96.433 96.433;"
		 xml:space="preserve">
			<g>
				<g>
					<path d="M24.82,48.678c5.422,0,9.832-6.644,9.832-14.811c0-8.165-4.41-14.809-9.832-14.809s-9.833,6.644-9.833,14.809
						C14.987,42.034,19.399,48.678,24.82,48.678z"/>
					<path d="M71.606,48.678c5.422,0,9.833-6.644,9.833-14.811c0-8.165-4.411-14.809-9.833-14.809c-5.421,0-9.831,6.644-9.831,14.809
						C61.775,42.034,66.186,48.678,71.606,48.678z"/>
					<path d="M95.855,55.806c-0.6-0.605-1.516-0.77-2.285-0.4C81.232,61.29,65.125,64.53,48.214,64.53
						c-16.907,0-33.015-3.24-45.354-9.123c-0.77-0.367-1.688-0.205-2.284,0.4c-0.599,0.606-0.747,1.526-0.369,2.29
						c5.606,11.351,25.349,19.277,48.008,19.277c22.668,0,42.412-7.929,48.012-19.279C96.603,57.332,96.453,56.411,95.855,55.806z"/>
				</g>
			</svg>
			<img id="profileImage2" src="">
		</div>
		<div>
			<p style="font-size:40px;" class="nick">${sessionScope.nick }</p>
			<p style="color:grey; font-size:20px;">${sessionScope.id }</p>
		</div>
	</div>
	<nav class="navbar navbar-expand-sm navbar-light" id="mdnavbar">
		<div class="container">
			<button class="navbar-toggler navbar-dark" data-toggle="collapse" data-target="#topNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="container collapse navbar-collapse justify-content-md-center" id="topNav">
				<ul class="navbar-nav">
					<li class="nav-item ${param.thisPage eq 'my_report' ? 'active':''}">
						<a class="nav-link" href="${pageContext.request.contextPath }/my_report/private/list.do"><b>나의 독후감</b></a>
					</li>
					<li class="nav-item ${param.thisPage eq 'my_heart' ? 'active':''}">
						<a class="nav-link" href="${pageContext.request.contextPath }/my_heart/private/list.do"><b>내가 누른 하트<b></b></a>
					</li>
					<li class="nav-item ${param.thisPage eq 'my_write' ? 'active':''}">
						<a class="nav-link" href="${pageContext.request.contextPath }/my_write/private/list.do"><b>내가 쓴 게시글</b></a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</div>
<script>
	$.ajax({
           url:"${pageContext.request.contextPath}/include/mydiarynav.do",
           method:"GET",
           success:function(responsedata){
           	console.log(responsedata.profile);
           	if(responsedata.profile == null){
           		$("#profileImage1").show();
           	}else{
           		$("#profileImage2").show();
           		$("#profileImage2").attr("src","${pageContext.request.contextPath}"+responsedata.profile);
           	}
           }
       });
</script>
