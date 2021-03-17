<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/home.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Serif KR', serif;
	}
	.search_form{
		margin-top:16px;
	}
	
	h4{
		color: brown;
	}
	
	.wording-img{
		width: 140px;
      	height: 140px;
      
      	border-radius: 50%;
	}
</style>
</head>
<body>
<%-- nav bar --%>
<jsp:include page="include/navbar.jsp"></jsp:include>
<%-- 검색 기능 --%>
<div style="background-color: #e3f2fd;">
	<div class="mx-auto mt-3" style="width: 400px;" >
		 <form>
		 
		  <div class="form-row">
		    <div class="col-7">
		      <input class="form-control mr-sm-2" type="search" placeholder="Search..." aria-label="Search">
		    </div>
		    <div class="col">
		      <button class="btn btn-outline-dark my-2 my-sm-0" type="submit">
		     	Search
		      </button>
		    </div>
		  </div>
		  
		</form>
	</div>
</div>
	
<%-- jumborton --%>
<jsp:include page="include/jumbotron.jsp"></jsp:include>

<div class="container">

	<%-- 명언 BEST --%>
	<h4>Every Book Day TOP 3 명언 </h4>
	<p>좋은 구절을 추천 해주세요!  
	 	<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<div class="container marketing">
	    <!-- Three columns of text below the carousel -->
	    <div class="row">
	      <div class="col-lg-4 text-center">
			<img class="card-img-top wording-img" src="https://i.pinimg.com/originals/95/a5/10/95a51074afed9b72b537b78b94f0a041.jpg" alt="Card image cap">
	        <h5>Book Title 1</h5>
	        <p>Some representative placeholder content for the three columns of text below the carousel. This is the first column.</p>
	      	<p> <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
	      </div>
	      <div class="col-lg-4 text-center">
			<img class="card-img-top wording-img" src="https://i.pinimg.com/originals/95/a5/10/95a51074afed9b72b537b78b94f0a041.jpg" alt="Card image cap">
	        <h5>Book Title 2</h5>
	        <p>Another exciting bit of representative placeholder content. This time, we've moved on to the second column.</p>
	      	 <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
	      </div>
	      <div class="col-lg-4 text-center">
			<img class="card-img-top wording-img" src="https://i.pinimg.com/originals/95/a5/10/95a51074afed9b72b537b78b94f0a041.jpg" alt="Card image cap">
	        <h5>Book Title 3</h5>
	        <p>And lastly this, the third column of representative placeholder content.</p>
	       	 <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
	      </div>
	    </div><!-- /.row -->
	</div>	
	
	  <br />
    <%-- 독후감 BEST --%>
    <h4>TOP 3 독후감</h4>
	<p>북스님들에게 가장 많은 좋아요를 받은 독후감
		<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<br />
    <div class="card-deck">    	
		  <div class="card">
		    <img class="card-img-top" src="https://freight.cargo.site/t/original/i/3aaeb6e85db4d1a64043744a47249c05c1c3a58fb9989447cbc5241765359ba3/Mockup.jpg" alt="Card image cap">
		    <div class="card-body">
		      <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
		      <p class="card-text"><footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://freight.cargo.site/t/original/i/3aaeb6e85db4d1a64043744a47249c05c1c3a58fb9989447cbc5241765359ba3/Mockup.jpg" alt="Card image cap">
		    <div class="card-body">
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		      <p class="card-text"><footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://freight.cargo.site/t/original/i/3aaeb6e85db4d1a64043744a47249c05c1c3a58fb9989447cbc5241765359ba3/Mockup.jpg" alt="Card image cap">
		    <div class="card-body">
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
		      <p class="card-text"><footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer></p>
		    </div>
		  </div>
	</div>
	
	<br />
	<%-- 독후감 양식 NEW --%>
	<h4>TOP 5 다운로드</h4>
	<p>북스님들이 공유해주신 독후감 양식
		<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<div class="card">
	  <ul class="list-group list-group-flush">
	    <li class="list-group-item">Download Title 1</li>
	    <li class="list-group-item">Download Title 2</li>
	    <li class="list-group-item">Download Title 3</li>
	    <li class="list-group-item">Download Title 4</li>
	    <li class="list-group-item">Download Title 5</li>
	  </ul>
	</div>
	<br />
	<h4>TOP 3 도서 매물</h4>
	<p>따끈따끈한 도서 매물 구경하러가기
		<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<div class="card-deck">    	
		  <div class="card">
		    <img class="card-img-top" src="https://lh3.googleusercontent.com/proxy/Ir6E468i6aoEsyBznjgsN1EGhLBRv3rZPaehXGDSMPmFQFe6XY8nzZJzHZLUiwWwaOL1OaoEHI6EaFQNc-SMX-KCr1vXeS_hplaMwj0HHVHbY_CwtGOjw-HjDsZV1eO1" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://lh3.googleusercontent.com/proxy/Ir6E468i6aoEsyBznjgsN1EGhLBRv3rZPaehXGDSMPmFQFe6XY8nzZJzHZLUiwWwaOL1OaoEHI6EaFQNc-SMX-KCr1vXeS_hplaMwj0HHVHbY_CwtGOjw-HjDsZV1eO1" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://lh3.googleusercontent.com/proxy/Ir6E468i6aoEsyBznjgsN1EGhLBRv3rZPaehXGDSMPmFQFe6XY8nzZJzHZLUiwWwaOL1OaoEHI6EaFQNc-SMX-KCr1vXeS_hplaMwj0HHVHbY_CwtGOjw-HjDsZV1eO1" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
		    </div>
		  </div>
	</div>
	<br />
	<h4>TOP 3 에피소드</h4>
	<p>책과 관련된 재밌는 이야기 작성하러 가기
		<a class="btn btn-outline-secondary btn-sm" href="#">더 보러가기</a></p>
	<div class="card-deck">    	
		  <div class="card">
		    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
		    </div>
		  </div>
		  <div class="card">
		    <img class="card-img-top" src="https://pds.joins.com/news/component/htmlphoto_mmdata/202005/05/8264b551-8356-4cb4-a5df-9ae1a050c973.jpg" alt="Card image cap">
		    <div class="card-body">
		      <h6 class="card-title">Card title</h6>
		      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content.</p>
		    </div>
		  </div>
	</div>
		
    <br />
    <div class="card">
	  <div class="card-body">
	    <blockquote class="blockquote mb-0">
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
	      <footer class="blockquote-footer">Someone famous in <cite title="Source Title">Source Title</cite></footer>
	    </blockquote>
	  </div>
	</div>
	
</div>



</body>
</html>
