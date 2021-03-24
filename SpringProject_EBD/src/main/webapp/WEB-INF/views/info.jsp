<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Every Book Day</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	/*전체 페이지 폰트 적용*/
	*{
		font-family: 'Gothic A1', sans-serif;
	}
</style>
</head>
<body>
<%-- nav bar --%>
<jsp:include page="include/navbar.jsp"></jsp:include>
	
<div class="container">
	<div class="card">
		<div class="card-body text-center">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/nPFe7I8ma2s" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
	</div>
</div>
</body>
</html>