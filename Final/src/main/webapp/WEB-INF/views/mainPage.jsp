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
<link rel="stylesheet" href="assets/css/mainPage.css">
<link rel="stylesheet" href="assets/css/fourimg.css">


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
									<div class="top-streamers" id="top-AI">
										<div class="heading-section">
											<h6>Welcome To Cyborg</h6>
											<h4>
												<em>AI</em> <br> 음악 추천 서비스
											</h4>
											<div class="main-button">
												<a href="${cpath}/AIrecommend">Right Now</a>

											</div>
										</div>
									</div>
								</div>

								<!-- 최근에 재생한 플레이리스트 -->
								<div class="col-lg-8">
									<div class="featured-games header-text">
										<div class="heading-section">
											<h4>
												<em>가장 많이 </em>사랑받은 노래
											</h4>
										</div>
										<div class="owl-features owl-carousel owl-collection">
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-01.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													내가 지은 플리 이름<br> <span>플리에 대한 추가 설명</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-02.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													저녁 드라이브<br> <span>#시티팝</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-03.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													헬스장<br> <span>#외힙</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-01.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													여돌 모음집<br> <span>#여돌</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-02.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													퇴근길<br> <span>#신나는</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-03.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													여름 드라이브<br> <span>#신나는</span>
												</h4>
											</div>
											<div class="item">
												<div class="thumb">
													<img src="assets/images/featured-03.jpg" alt="">
													<div class="hover-effect">
														<h6>
															<a href="#"></a>지금 듣기
														</h6>
													</div>
												</div>
												<h4>
													여름 드라이브<br> <span>#신나는</span>
												</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- ***** Featured Games End ***** -->





							<!-- ***** 사용자한테 추천하는 플레이리스트 start ***** -->
							<div class="col-lg-12">
								<div class="featured-games header-text">
									<div class="heading-section">
										<h4>
											<em>오늘의</em> 추천 노래
										</h4>
									</div>

									<div class="owl-features owl-carousel">
										<div class="item">
											<div class="image-grid">
												<div class="thumb">
													<img src="assets/images/stream-05.jpg" alt="">
												</div>
												<div class="thumb">
													<img src="assets/images/stream-02.jpg" alt="">
												</div>
												<div class="thumb">
													<img src="assets/images/stream-03.jpg" alt="">
												</div>
												<div class="thumb">
													<img src="assets/images/stream-04.jpg" alt="">
												</div>
											</div>
											<h4>
												Island Rusty<br> <span>249K Downloads</span>
											</h4>
										</div>

										<div class="item">
											<div class="thumb">
												<img src="assets/images/stream-06.jpg" alt="">
											</div>
											<h4>
												Island Rusty<br> <span>249K Downloads</span>
											</h4>
										</div>

										<div class="item">
											<div class="thumb">
												<img src="assets/images/stream-05.jpg" alt="">
											</div>
											<h4>
												Island Rusty<br> <span>249K Downloads</span>
											</h4>
										</div>

										<div class="item">
											<div class="thumb">
												<img src="assets/images/stream-08.jpg" alt="">
											</div>
											<h4>
												Island Rusty<br> <span>249K Downloads</span>
											</h4>
										</div>

										<div class="item">
											<div class="thumb">
												<img src="assets/images/stream-08.jpg" alt="">
											</div>
											<h4>
												Island Rusty<br> <span>249K Downloads</span>
											</h4>
										</div>
									</div>
								</div>
							</div>
							<!-- ***** 사용자한테 추천하는 플레이리스트 End ***** -->






							<!-- ***** 사용자한테 추천하는 플레이리스트 start ***** -->
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
													</div>
													<h4>${otherIdx.plName}<br> <span>${otherSurDescList[status.index]}</span>
													</h4>
												</a>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>

							<!-- ***** 사용자한테 추천하는 플레이리스트 End ***** -->





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