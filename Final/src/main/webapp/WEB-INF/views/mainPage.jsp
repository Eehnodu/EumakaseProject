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


<title>음악하세</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>

<!-- Owl Carousel CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

<!-- Owl Carousel JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<!-- ***** css 연결 ***** -->
<link rel="stylesheet"
	href="assets/css/mainPage.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="assets/css/fourimg.css?ver=<%=System.currentTimeMillis()%>">


</head>
<body>

	<!-- ***** Preloader Start ***** -->
	<div id="js-preloader" class="js-preloader">
		<div class="preloader-inner">
			<span class="dot"></span>
			<div class="dots">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->


	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<!-- AI 추천 및 최근에 재생한 플레이리스트 -->
					<div class="row">
						<div class="col-lg-4">
							<a href="${cpath}/AIrecommend">
								<div class="top-streamers" id="top-AI">
									<div class="heading-section aiHeading">
										<div class="main-button">
											<span class="btnLP">AI 음악추천<br>시작하기
											</span>
										</div>
									</div>
								</div>
							</a>
						</div>


						<!-- ***** 가장 많이 사랑받은 노래 start ***** -->
						<div class="col-lg-8">
							<div class="featured-games header-text" id="songsLoved">
								<div class="heading-section">
									<h4>
										<em>가장 많이 </em>사랑받은 노래
									</h4>
								</div>
								<div class="owl-features owl-carousel owl-collection">
									<c:forEach var="popular" items="${popularMusic}">
										<div class="item">
											<div class="thumb">
												<a
													href="<c:url value='/songDetail?musicIdx=${popular.musicIdx}'/>">
													<img src="${popular.albumCov}" alt="">
												</a>
												<div class="hover-effect">
													<h6>
														<a
															href="<c:url value='/songDetail?musicIdx=${popular.musicIdx}'/>">
															상세 보기 </a>
													</h6>
												</div>
											</div>
											<h4>
												${popular.title}<br> <span>${popular.artist}</span>
											</h4>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
						<!-- ***** 가장 많이 사랑받은 노래 end ***** -->


						<!-- ***** 사용자한테 추천하는 플레이리스트 start ***** -->
						<div class="col-lg-12">
							<div class="featured-games header-text">
								<div class="heading-section">
									<h4>
										<em>장르별</em> 플레이리스트
									</h4>
								</div>

								<div class="owl-features owl-carousel">

									<c:forEach var="genreEntry" items="${indexList}"
										varStatus="status">
										<a href="${cpath}/recPlayList?genreIndex=${genreEntry.key}">
											<div class="item">
												<div class="thumb">
													<img class="genreAlbumCov"
														src="assets/images/genre-${status.index + 1}.png" alt="">
												</div>
												<h4 class="genreTag">${recSurvey[genreEntry.key]}</h4>
											</div>
										</a>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<!-- ***** 사용자한테 추천하는 플레이리스트 End ***** -->

					<!-- ***** 다른 사람의 플레이리스트 start ***** -->
					<div class="col-lg-12">
						<div class="featured-games header-text">
							<div class="heading-section">
								<h4>
									<em>다른 사람은</em> 뭐 듣지?
								</h4>
							</div>

							<div class="owl-features owl-carousel">
								<c:forEach var="otherIdx" items="${otherIdxList}"
									varStatus="status">
									<div class="item">
										<a href="${cpath}/userPlaylist?myplIdx=${otherIdx.myplIdx}">
											<div class="image-grid">
												<c:forEach var="albumCov"
													items="${otherAlbumCovList[status.index]}">
													<div class="thumb">
														<img src="${albumCov}" alt="">
													</div>
												</c:forEach>
												<div class="hover-effect2">
													<h6>상세 보기</h6>
												</div>
											</div>
											<h4><span>${otherIdx.plName}</span></h4><br> <span>${otherSurDescList[status.index]}</span>
											</h4>
										</a>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<!-- ***** 다른 사람의 플레이리스트 End ***** -->
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

</body>

<%@ include file="includeFooter.jsp"%>
</html>