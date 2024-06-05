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

<title>틀</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>

<!-- ***** css 연결 ***** -->
<link rel="stylesheet" href="assets/css/AIrecommend.css">

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<!-- ***** 페이지 내용 작성 ***** -->
					<div class="box">
						<div class="intro">
							<p class="first">
								<span>Welcome to AI recommend!</span>
							</p>
							<p>
								<span>당신의 취향을 어쩌구....</span>
							</p>
						</div>
						<!-- QUESTION 1-->
						<div class="question q-one">
							<div class="q-wrap">
								<p class="locations">
									<span>지금 무엇을 하고 있나요?</span>
								</p>
							</div>
							<div class="confirm-container">
								<p class="confirm-button" data-response="출퇴근 중이시군요!"
									data-type="yes">출퇴근중</p>
								<p class="confirm-button" data-response="공부 중이시군요!"
									data-type="no">공부중</p>
								<p class="confirm-button" data-response="휴식 중이시군요!"
									data-type="not-sure">휴식중</p>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 1 END -->

						<!-- QUESTION 2-->
						<div class="question q-two">
							<div class="q-wrap">
								<p>
									<span>지금 나의 기분은 어떤 편인가요?</span>
								</p>
							</div>
							<div class="confirm-container">
								<p class="confirm-button" data-response="행복함을 느끼고 계시군요!"
									data-type="not-sure">행복함</p>
								<p class="confirm-button" data-response="짜증을 느끼고 계시군요!"
									data-type="no">짜증남</p>
								<p class="confirm-button" data-response="우울함을 느끼고 계시군요!"
									data-type="yes">우울함</p>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 2 END -->

						<!-- QUESTION 3-->
						<div class="question q-three">
							<div class="q-wrap">
								<p>
									<span>또 뭘 넣지</span>
								</p>
							</div>
							<div class="confirm-container">
								<p class="confirm-button" data-response="I don't know"
									data-type="not-sure">I don't know</p>
								<p class="confirm-button" data-response="No" data-type="no">No</p>
								<p class="confirm-button" data-response="Yes" data-type="yes">Yes</p>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 3 END -->

						<!-- RESULT -->
						<div class="result">
							<p class="now">
								<span>지금 상황에 맞는 플리를 추천해드릴게요!</span>
							</p>
							<p>
								<span>당신의 취향을 어쩌구....</span>
							</p>
						</div>
						<!-- RESULT END -->
					</div>
					<!-- BOX END -->
				</div>
			</div>
		</div>
	</div>



	<!-- Scripts -->

	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>
	<script src="assets/js/AIrecommend.js"></script>

	<%@ include file="includeFooter.jsp"%>

</body>
</html>