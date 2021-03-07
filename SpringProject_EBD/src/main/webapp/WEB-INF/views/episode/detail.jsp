<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<div class="card mb-3">
		<img class="card-img-top" src="${pageContext.request.contextPath }${dataDto.imgPath}"/>
		<div class="card-body">
			<!-- 로그인을 해야지만 하트를 누를 수 있다. -->
			<c:if test="${not empty nick }">
				<p>
					<c:choose>
						<c:when test="${isheartclick eq true }">
							<a data-num="${dataDto.num }" href="javascript:" class="heart-link" href="list.do">하트눌림~</a>
						</c:when>
						<c:otherwise>
							<a data-num="${dataDto.num }" href="javascript:" class="heart-link" href="list.do">하트</a>
						</c:otherwise>
					</c:choose>
				</p>
				<p class="heart-cnt">(${heartcnt })</p>
			</c:if>
			<p class="card-text">${dataDto.title }</p>
			<p class="card-text">by <strong>${dataDto.writer }</strong></p>
			<p><small>${dataDto.regdate }</small></p>
		</div>
	</div>
	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${dataDto.prevNum ne 0 }">
					<li class="page-item mr-3">
						<a class="page-link" href="detail.do?num=${dataDto.prevNum }">&larr; Prev</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled mr-3">
						<a class="page-link" href="javascript:">Prev</a>
					</li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${dataDto.nextNum ne 0 }">
					<li class="page-item">
						<a class="page-link" href="detail.do?num=${dataDto.nextNum }">Next &rarr;</a>
					</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="javascript:">Next</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>		
</div>
<script>
	//하트를 클릭할 때마다 호출되는 함수 등록
	$(document).on("click",".heart-link",function(){
		//글 번호를 불러온다.
		var target_num=$(this).attr("data-num");
	
		if($(this).text()=="하트"){ //하트일때 클릭하면
			console.log("if문 들어왔다!"+target_num);
			//insert 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/episode/saveheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){ //나중에 구현 : 하트 수를 반환
					$(".heart-cnt").text("("+data.heartCnt+")");
				}
			});
			$(this).text("하트눌림~"); //하트 눌림으로 바뀐다.
			
			
		
		}else{//하트 눌림일 때 클릭하면 (하트를 해제한 효과)			
			//delete 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/episode/removeheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){
					$(".heart-cnt").text("("+data.heartCnt+")");
				} 				
			});
			
			$(this).text("하트");//하트로 바뀐다. 
		}
		
	});
	
	//페이지가 뒤로가기 하면 하트버튼과 하트수 갱신이 안된다. 이때 하트를 누르면 디비에 중복으로 값이 들어가진다.
	//방지하기 위해 페이지가 뒤로가기 할때마다 css로 클릭을 막고 새로고침을 통해 갱신된 하트버튼과 하트수가 나오도록 한다.
	$(window).bind("pageshow", function (event) {
		if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
			console.log('BFCahe로부터 detail 복원됨');
			$(".heart-link").css("pointer-events","none");
			location.reload();//새로고침하기
		}
		else {
			console.log('새로 열린 detail 페이지');
		}
		
	});
	
</script>
</body>
</html>