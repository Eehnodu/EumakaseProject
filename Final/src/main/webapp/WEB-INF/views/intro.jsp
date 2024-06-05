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

<title>소개합니다.....</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>

<link rel="stylesheet" href="assets/css/intro.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v3.0.6/css/line.css">
<script>
	window.onload = function() {
		// 서버 측에서 전달된 에러 메시지를 확인
		let errorMessage = '<c:out value="${errorMessage}" />';
		if (errorMessage && errorMessage.trim().length > 0) { // 에러메세지가 null값이 아닌 경우
			alert(errorMessage);
		}
	}
</script>

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<!-- ***** 페이지 내용 작성 ***** -->

					<div class="row">
						<div id="introImages" class="col-lg-8">
							<div class="featured-games header-text">
								<div class="heading-section">
									<h4>
										<span>Listen to Personalized</span> Playlist
									</h4>
								</div>
								<div class="owl-features owl-carousel">
									<div class="item">
										<div class="thumb">
											<img src="assets/images/intro1.jpg" height="550px" alt="">
										</div>
									</div>
									<div class="item">
										<div class="thumb">
											<img src="assets/images/intro2.jpg" height="550px" alt="">
										</div>
									</div>
									<div class="item">
										<div class="thumb">
											<img src="assets/images/intro3.jpg" height="550px" alt="">
										</div>
									</div>
									<div class="item">
										<div class="thumb">
											<img src="assets/images/intro2.jpg" height="550px" alt="">
										</div>
									</div>
								</div>
							</div>
						</div>



						<div class="col-lg-4">
							<div id="goAi" class="game-details mb-3">
								<a href="#">
									<div class="content">
										<div class="row">
											<div class="col-lg-12">
												<div>
													<h6 id="txtGoAI">
														AI 추천 받으러 가기&nbsp; <i class="fa-solid fa-arrow-right-long"></i>
													</h6>
												</div>
											</div>
										</div>
									</div>
								</a>
							</div>
							<div id="plSeason" class="game-details">
								<div class="content"">
									<div class=" row">
										<h5 id="txtSeason">Summer Music</h5>
										<div class="col-lg-12 playlistDetail right-info">
											<div>
												<div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<div>
																<img src="assets/images/game-01.jpg" alt=""
																	class="templatemo-item imgCover"> <span
																	class="songTitle">Super Shy</span><span>New
																	Jeans</span>
															</div>
														</div>
													</div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item imgCover"> <span
																class="songTitle">Attention</span><span>Doja Cat</span>
														</div>
													</div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item imgCover"> <span
																class="songTitle">같애 (feat. SHIRT)</span><span>같애</span>
														</div>
													</div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item imgCover"> <span
																class="songTitle">Cruel Summer</span><span>Taylor
																Swift</span>
														</div>
													</div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item imgCover"> <span
																class="songTitle">Perfect Night</span><span>LE
																SSERAFIM</span>
														</div>
													</div>
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item imgCover"> <span
																class="songTitle">Attention</span><span>Doja Cat</span>
														</div>
													</div>
												</div>

											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




	<!-- Scripts -->

	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>


	<script src="assets/js/intro.js?ver=<%=System.currentTimeMillis()%>"></script>




</body>
	<%@ include file="includeFooter.jsp"%>
</html>