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
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet" href="assets/css/main.css">
</head>
<body>

	<div class="container">ㅇㅇ
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<button type="button" class="btn btn-success btn-sm">
						<a href="${cpath}/mypage" class="btnMypage">마이페이지</a>
					</button>
					<form action="${cpath}/logout" method="post">
						<button type="submit" class="btn btn-dark btn-sm">로그아웃</button>
					</form>

					<div>${member.name}님을위한 추천 음악</div>
					<div>다른 사용자들의 플레이리스트</div>
					<div>음악 재생 플레이어</div>
					<div>
						<a href="#">AI 추천 받으러 가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Scripts -->
	<!-- Bootstrap core JavaScript -->
	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>