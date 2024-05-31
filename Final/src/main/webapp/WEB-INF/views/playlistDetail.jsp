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
<link rel="stylesheet" href="assets/css/playlistDetail.css">

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<div class="game-details">
						<div class="row">

							<!-- 페이지 플레이리스트 정보 -->
							<div class="col-lg-12">
								<div class="left-info">
									<h2>플레이리스트 정보</h2>
								</div>
							</div>

							<!-- 플레이리스트 정보 -->
							<div class="col-lg-12">
								<div class="content">
									<div class="row">
										<div class="col-lg-6">
											<div class="left-info">
												<div class="left">
													<h4>플레이리스트 제목</h4>
													<span>#신나는 #아이돌</span>
												</div>
												<ul>
													<li><i class="fa fa-star"></i> 4.8</li>
													<!-- 사용자 평점 -->
													<li><i class="fa fa-download"></i> 2.3M</li>
													<!-- 다운로드 횟수 -->
												</ul>
											</div>
										</div>
										<div class="col-lg-6">
											<div class="right-info">
												<div class="main-button">
													<a href="#">이 플리 저장</a> <a href="#">다른 플리 보기</a>
												</div>
											</div>
										</div>
										<div class="col-lg-6">
											<img src="assets/images/details-01.jpg" alt=""
												style="border-radius: 23px; margin-bottom: 30px;">
										</div>

										<!-- 추천하는 곡 리스트  -->
										<div class="col-lg-6 playlistDetail">
											<div class="right-info">
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<div>
															<img src="assets/images/song1.jpg" alt=""
																class="templatemo-item">
															<h4>Super Shy</h4>
															<span>New Jeans</span>
														</div>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>Attention</h4>
														<span>Doja Cat</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>같애 (feat. SHIRT)</h4>
														<span>같애</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>Cruel Summer</h4>
														<span>Taylor Swift</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<img src="assets/images/song1.jpg" alt=""
															class="templatemo-item">
														<h4>Perfect Night</h4>
														<span>LE SSERAFIM</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>Attention</h4>
														<span>Doja Cat</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>같애 (feat. SHIRT)</h4>
														<span>같애</span>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item">
														<img src="assets/images/game-01.jpg" alt=""
															class="templatemo-item">
														<h4>Cruel Summer</h4>
														<span>Taylor Swift</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- ***** Details End ***** -->



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