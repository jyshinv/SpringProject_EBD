<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   .jumbotron{
      background-color:white;
      margin-bottom:0px;
   }
   .jumbotronImg{
      height: 250px;
   }
</style>

<%-- wording insertform jumbotron --%>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
     <div>
        <img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd1.svg" alt="대문이미지" />
     </div>
     <br />
    <h1 class="display-4"><b>Books Books Wording</b></h1>
    <p class="lead">아직 읽지 않은 책은 숨겨진 보물 입니다 <br />
   		 			북스북스 회원들이 내놓은 보물, <br />
   		 			지금 만나 보세요! </p>
  </div>
</div>