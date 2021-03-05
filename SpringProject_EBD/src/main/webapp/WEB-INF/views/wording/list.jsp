<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 명언/글귀</title>
<jsp:include page="../include/resource.jsp"></jsp:include>

<style>
	.back-drop{
		/* 일단 숨겨 놓는다. */
		display:none;
	
		/* 화면 전체를 투명도가 있는 회색으로 덮기 위한  css*/
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		background-color: #cecece;
		padding-top: 300px;
		z-index: 10000;
		opacity: 0.5;
		text-align: center;
	}
	
	.back-drop img{
		width: 100px;
		/* rotateAnimation 이라는 키프레임을 2초 동한 일정한 비율로  무한 반복하기 */
		animation: rotateAnimation 2s ease-out infinite;
	}
	
	/* 회전하는 rotateAnimation 이라는 이름의 키프레임 정의하기 */
	@keyframes rotateAnimation{
		0%{
			transform: rotate(0deg);
		}
		100%{
			transform: rotate(360deg);
		}
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<h1>책/명언 페이지 입니다.</h1>
<a href="private/insertform.do">책 명언/글귀 작성하러 가기</a>

<div class="container">
	<!-- 검색 버튼과 form -->
	<form action="list.do" method="get">
			<label for="condition">검색조건</label>
			<select name="condition" id="condition">
				<option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목+내용</option>
				<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
				<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
			</select>
			<label for="keyword"></label>
			<input type="text" id="keyword" name="keyword" placeholder="검색어..." value="${keyword }"/>
			<button type="submit">검색</button>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<c:if test="${not empty keyword }">
		<div class="alert alert-success">
			<strong>${totalRow }</strong> 개의 자료가 검색되었습니다.
		</div>
	</c:if>
	<%int isCheck=0; %>
	<!-- 명언/글귀 목록 select했을 때 해당 id가 누른 번호가 있다면 heartck="하트눌림~", 그게 아니라면 heartck="하트"가 나오게 한다.-->
	<div id="wordingList">
		<c:forEach var="tmp" items="${list }">
			<c:if test="${not empty id }">
				<c:forEach var="i" begin="<%=isCheck %>" end="<%=isCheck %>">
					<c:if test="${list2[i].num eq list2[i].target_num }">
						<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">하트눌림~</a>
					</c:if>
					<c:if test="${list2[i].num ne list2[i].target_num }">
							<a data-num="${tmp.num }" href="javascript:" class="heart-link" href="list.do">하트</a>										
					</c:if>					
				</c:forEach>
				<!-- 로그인이 되어있고 작성자가 같을 때만 수정과 삭제버튼이 보이게 한다. -->
				<c:if test="${tmp.writer eq sessionScope.nick }">
					<a href="private/updateform.do?num=${tmp.num }">| 수정</a>
					<a href="private/delete.do?num=${tmp.num }">| 삭제</a>	
				</c:if>	
			</c:if>
			<p>
				${tmp.num } ${tmp.writer } ${tmp.title } ${tmp.content } ${tmp.author } ${tmp.viewcnt } ${tmp.regdate }
			</p>
			<%isCheck++; %>
		</c:forEach>
		
	</div>
</div>
<div class="back-drop">
	<!-- cpath/ 에서 '/'는 webapp을 의미한다. 웹앱 폴더의 svg폴더 안에 spinner-solid.svg가 들어있다.  -->
	<img src="${pageContext.request.contextPath }/svg/spinner-solid.svg"/> 

</div>
<script>
	
	//페이지가 처음 로딩될 때 1page를 보여주기 때문에 초기값을 1로 지정한다.
	let currentPage=1;
	//현재 페이지가 로딩중인지 여부를 저장할 변수이다.
	let isLoading=false;
	
	//웹브라우저의 창을 스크롤 할 때 마다 호출되는 함수 등록
	$(window).on("scroll",function(){
		//위로 스크롤된 길이
		let scrollTop=$(window).scrollTop();
		//웹브라우저의 창의 높이
		let windowHeight=$(window).height();
		//문서 전체의 높이
		let documentHeight=$(document).height();
		//바닥까지 스크롤 되었는 지 여부를 알아낸다.
		let isBottom=scrollTop+windowHeight + 10 >= documentHeight;
		if(isBottom){
			//만일 현재 마지막 페이지라면
			if(currentPage == ${totalPageCount } || isLoading){
				return; //함수를 여기서 끝낸다.
			}
			//현재 로딩 중이라고 표시한다.
			isLoading=true;
			//로딩바를 띄우고
			$(".back-drop").show();
			//요청할 페이지 번호를 1 증가시킨다.
			currentPage++;
			//추가로 받아올 페이지를 서버에 ajax 요청을 하고 (/wording/list.do요청과 /wording/ajax_page.do 요청처리 해주어야함)
			$.ajax({
				url:"ajax_page.do",
				method:"GET",
				data:"pageNum="+currentPage,
				//ajax_page.jsp의 내용이 data로 들어온다.
				success:function(data){
					console.log(data);
					//응답된 문자열은 html 형식이다.(wording/private/ajax_page.jsp에 응답내용이 있다.)
					//해당 문자열을 #wordingList div에 html로 해석하라고 추가한다.
					$("#wordingList").append(data);
					//로딩바를 숨긴다.
					$(".back-drop").hide();
					//로딩중이 아니라고 표시한다.
					isLoading=false;
				}
				
			});
		}; //end of if(isBottom)
	});
	
	//하트를 클릭할 때마다 호출되는 함수 등록
	$(document).on("click",".heart-link",function(){
		//글 번호를 불러온다.
		var target_num=$(this).attr("data-num");

		if($(this).text()=="하트"){ //하트일때 클릭하면
			console.log("if문 들어왔다!"+target_num);
			//insert 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/wording/saveheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){ //나중에 구현 : 하트 수를 반환
				}
			});
			$(this).text("하트눌림~"); //하트 눌림으로 바뀐다.
			
			
		
		}else{//하트 눌림일 때 클릭하면 (하트를 해제한 효과)			
			//delete 요청을 한다.(컨트롤러에서 responsebody사용)
			$.ajax({
				url:"${pageContext.request.contextPath }/wording/removeheart.do",
				method:"GET",
				data: "target_num="+target_num,
				success:function(data){
				} 				
			});
			
			$(this).text("하트");//하트로 바뀐다. 
		}
		
	});
	
</script>


</body>
</html>