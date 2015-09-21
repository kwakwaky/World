<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<option value="">-- 선택하세요 --</option>
<c:forEach var="d" items="${districts}">
	<option value="${d}">${d}</option>
</c:forEach>

<!-- <option value="">-- 선택하세요 --</option> -->
<!-- <option value="KOR">대한민국</option> -->
<!-- <option value="USA">미국</option> -->
<!-- <option value="JPA">일본</option> -->