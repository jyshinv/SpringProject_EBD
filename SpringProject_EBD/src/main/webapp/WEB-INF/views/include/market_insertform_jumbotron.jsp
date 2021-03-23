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

<%-- market insertform jumbotron --%>
<div class="jumbotron jumbotron-fluid">
  <div class="container text-center">
     <div>
        <img class="jumbotronImg" src="${pageContext.request.contextPath}/svg/ebd1.svg" alt="대문이미지" />
     </div>
     <br />
     <h1 class="display-4"><b>Books Books Market !</b></h1>
     <p class="lead">북스북스 회원들과 나누고, 교환하고, 판매하고 </p>
  </div>
</div>