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
								<span>이랏샤이마세! 어서오세요! 음악하세입니다!!</span>
							</p>
							<p>
								<span>맞춤 노래를 추천해드릴게요!!</span>
							</p>
						</div>
						<!-- QUESTION 1-->
						<div class="question q-one">
							<div class="q-wrap">
								<p class="locations">
									<span>${emotionQue.surDesc}</span>
								</p>
							</div>
							<div class="confirm-container">
								<c:forEach var="emotion" items="${emotionAns}">
									<p class="confirm-button" id="${emotion.surIdx}" data-response="${emotion.surDesc} 감정이 드는 날이네요"
										data-type="not-sure">${emotion.surDesc}</p>
								</c:forEach>
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
									<span>${situationQue.surDesc}</span>
								</p>
							</div>
							<div class="confirm-container">
								<c:forEach var="situation" items="${situationAns}">
									<p class="confirm-button" id="${situation.surIdx}" data-response="${situation.surDesc}중 이시군요~"
										data-type="not-sure">${situation.surDesc}</p>
								</c:forEach>
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
									<span>${placeQue.surDesc}</span>
								</p>
							</div>
							<div class="confirm-container">
								<c:forEach var="place" items="${placeAns}">
									<p class="confirm-button" id="${place.surIdx}" data-response="${place.surDesc}중 이시군요~"
										data-type="not-sure">${place.surDesc}</p>
								</c:forEach>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 3 END -->
						
						<!-- QUESTION 4-->
						<div class="question q-three">
							<div class="q-wrap">
								<p>
									<span>${peopleQue.surDesc}</span>
								</p>
							</div>
							<div class="confirm-container">
								<c:forEach var="people" items="${peopleAns}">
									<p class="confirm-button" id="${people.surIdx}" data-response="${people.surDesc}와 함께라면~"
										data-type="not-sure">${people.surDesc}</p>
								</c:forEach>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 4 END -->
						
						<!-- QUESTION 5-->
						<div class="question q-three">
							<div class="q-wrap">
								<p>
									<span>${genreQue.surDesc}</span>
								</p>
							</div>
							<div class="confirm-container">
								<c:forEach var="genre" items="${genreAns}">
									<p class="confirm-button" id="${genre.surIdx}" data-response="${genre.surDesc}가 듣고 싶은 날이네요~"
										data-type="not-sure">${genre.surDesc}</p>
								</c:forEach>
							</div>
							<!-- END confirm-container -->
							<p class="response">
								<span></span>
							</p>
						</div>
						<!-- QUESTION 4 END -->

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