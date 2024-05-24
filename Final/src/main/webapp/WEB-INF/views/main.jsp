<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<%@ include file="include.jsp"%>

</head>
<body>
	<button type="button" class="btn btn-success btn-sm">
		<a href="${cpath}/mypage" style="text-decoration: none; color: white;">마이페이지</a>
	</button>
	<form action="${cpath}/logout" method="post">
		<button type="submit" class="btn btn-dark btn-sm">로그아웃</button>
	</form>

	<div>${member.name}님을위한추천음악</div>
	<div>다른 사용자들의 플레이리스트</div>
	<div>~~음악 재생 플레이어~~</div>
	<div>
		<a href="#">AI 추천 받으러 가기!</a>
	</div>


</body>
</html>