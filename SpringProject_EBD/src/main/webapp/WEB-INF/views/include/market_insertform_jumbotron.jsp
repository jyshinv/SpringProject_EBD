<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 폰트 링크 --%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&family=Noto+Serif+KR:wght@500&display=swap" rel="stylesheet">

<style>
   *{
      font-family: 'Gothic A1', sans-serif;
   }
   .jumbotron{
      background-color:white;
      margin-bottom:0px;
   }
   .jumbotronImg{
      height: 250px;
   }
</style>

<%-- market insertform jumbotron --%>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
     <div>
        <img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd_img3.svg"  
			  				alt="대문이미지"/>
     </div>
     <br />
     <h1 class="display-4"><b>Books Books Market !</b></h1>
     <p class="lead">북스북스 회원들과 나누고, 교환하고, 판매하고 </p>
  </div>
</div>