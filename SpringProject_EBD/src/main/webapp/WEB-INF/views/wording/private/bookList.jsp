<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 검색결과입니다.</title>
</head>
<body>
	<form action="bookList.do">
		<input type="text" name="keyword" />
		<input type="submit" value="검색" />
	</form>
	<table>
        <tr>
            <td colspan="7" width="100%" bgcolor="pink"></td>
        </tr>
        <c:forEach items="${bookList}" var ="b">
            <tr>
                <td rowspan="2"><img src="${b.image}"></td>
                <td rowspan="4" width="800">"${b.title}"</td>
                <td width="200">${b.author}</td>
            </tr>
            <tr>
            	<td width="200"><a href="${b.link }">링크클릭</a></td>
                <td width="200">${b.price }</td>
                <td width="200">${b.discount }</td>
                <td width="200">${b.publisher }</td>
                <td width="200">${b.pubdate }</td>
                <td width="200">${b.isbn }</td>
            </tr>
            <tr>
                <td colspan="7">${b.description}</td>
                <td>
		  			<form action="insertform.do">
		  				<label for="title"></label>
		  				<input type="hidden" id="title" name="title" value="${b.title }" /> 
		  				<label for="author"></label>
		  				<input type="hidden" id="author" name="author" value="${b.author }" /> 
		  				<input type="submit" value="선택" />
		  			</form>
                </td>
            </tr>
            <tr>
                <td colspan="7" width="100%" bgcolor="pink"></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>