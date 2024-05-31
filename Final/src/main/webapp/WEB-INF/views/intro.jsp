<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>소개</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet" href="assets/css/intro.css">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<c:choose>
						<%-- 로그인 안 했을 시 로그인,회원가입 버튼 --%>
						<c:when test="${member==null}">
							<button type="button" class="btn btn-primary btn-sm"
								data-toggle="modal" data-target="#loginModal">로그인</button>
							<button type="button" class="btn btn-success btn-sm">
								<a href="${cpath}/join"
									style="text-decoration: none; color: white;">회원가입</a>
							</button>
						</c:when>
						<%-- 로그인 시 마이페이지,로그아웃 버튼 --%>
						<c:when test="${member!=null}">
							<button type="button" class="btn btn-success btn-sm">
								<a href="${cpath}/mypage" class="btnMypage">마이페이지</a>
							</button>
							<form action="${cpath}/logout" method="post">
								<button type="submit" class="btn btn-dark btn-sm">로그아웃</button>
							</form>
						</c:when>
					</c:choose>


					<div>소개이미지</div>
					<div>
						<a href="#">AI 추천 받으러 가기</a>
					</div>
					<div>여름 플레이리스트</div>


					<!-- 로그인 Modal -->
					<div class="modal" id="loginModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h4 class="modal-title">로그인</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>

								<!-- Modal body -->
								<div class="modal-body">
									<form action="${cpath}/login" method="post">
										<div>
											아이디 : <input type="text" name="memId">
										</div>
										<div>
											비밀번호 : <input type="password" name="memPw">
										</div>
										<div>
											<button type="submit" class="btn btn-primary btn-sm">로그인</button>
										</div>
									</form>
								</div>

								<!-- Modal footer -->
								<div class="modal-footer">
									<a href="${cpath}/join"> 회원가입 </a>
									<button type="button" class="btn btn-danger btn-sm"
										data-dismiss="modal">Close</button>
								</div>

							</div>
						</div>
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