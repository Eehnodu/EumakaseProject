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
<title>마이페이지</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet" href="assets/css/mypage.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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





					<!-- ***** Banner Start ***** -->
					<div class="row">
						<div class="col-lg-12">
							<div class="main-profile ">
								<div class="row">
									<div class="col-lg-6">
										<button id="prevChart" class="btn-arrow"><i class="fas fa-arrow-left"></i></button>
                                        <button id="nextChart" class="btn-arrow"><i class="fas fa-arrow-right"></i></button>
                                    
                                    <!-- 차트 영역 -->
                                    <form id="chartjs" action="${cpath}/chartjs" method="post" novalidate>
                                        <canvas id="myChart" width="200" height="200"></canvas>
                                    </form>
                                    <form id="getMusic" action="${cpath}/getMusic" method="post" novalidate>
                                        <canvas id="myChart1" width="200" height="200"></canvas>
                                    </form>
									</div>

									<div class="col-lg-6 align-self-center">
										<ul>
											<li>나의 선호도 <span>뉴진스</span> <br> <span>에스파</span> <br>
												<span>아이유</span>
											</li>
										</ul>
										<br>
										<ul>
											<li>선호하는 장르 <span>댄스</span></li>
											<li>좋아하는 가수<span>뉴진스</span></li>
											<li>자주 듣는 노래 <span>Bubble Gum</span></li>
										</ul>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="clips">
											<div class="row">
												<div class="col-lg-12">
													<div class="heading-section">
														<h4>
															<em>나의</em> playlist
														</h4>
													</div>
												</div>
												<c:forEach var="myply" items="${myplayList}" varStatus="loop">
													<div class="col-lg-3 col-sm-6">
														<div class="item">
															<div class="thumb">
																<c:forEach var="cov" items="${myplayListalbumCov}"
																	begin="${loop.index * 4}" end="${(loop.index * 4) + 3}">
																	<img src="${cov.albumCov}" alt=""
																		style="border-radius: 23px; width: 25%;">
																</c:forEach>
																<a href = "${cpath}/userPlaylist?myplIdx=${myply.myplIdx}">상세보기</a>
																<a href="https://www.youtube.com/watch?v=r1b03uKWk_M"
																	target="_blank"> <i class="fa fa-play"></i>
																</a>
															</div>
															<div class="down-content">
																<h4>${myply.plName}</h4>
															</div>
															<div class="moreInfoButtons mt-2">
																<button type="button" class="btn btn-sm btn-edit">수정</button>
																<button type="button" class="btn btn-sm btn-delete">삭제</button>
															</div>
														</div>
													</div>
												</c:forEach>

												<div class="col-lg-12">
													<div class="main-button" id="loadMore">
														<a href="profile.html">더보기</a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- ***** Banner End ***** -->

					<!-- ***** Gaming Library Start ***** -->
					<div class="gaming-library profile-library">
						<div class="col-lg-12">
							<div class="heading-section">
								<h4>
									<em>팬 맺은</em> 아티스트
								</h4>
							</div>
							<div class="item">
								<ul>
									<li><img src="assets/images/game-01.jpg" alt=""
										class="templatemo-item"></li>
									<li>
										<h4>뉴진스</h4> <span>여성/그룹</span>
									</li>
									<li>
										<h4>최근 발매일</h4> <span>24/08/2036</span>
									</li>
									<li>
										<h4>Hours Played</h4> <span>앨범명</span>
									</li>
									<li>
										<h4>댄스</h4> <span>장르</span>
									</li>
									<li>
										<div class="thumb">
											<a href="#" target="_blank"><i class="fa fa-play fa-lg"></i></a>
										</div>
									</li>
								</ul>
							</div>
							<div class="item">
								<ul>
									<li><img src="assets/images/game-02.jpg" alt=""
										class="templatemo-item"></li>
									<li>
										<h4>Fortnite</h4> <span>Sandbox</span>
									</li>
									<li>
										<h4>Date Added</h4> <span>22/06/2036</span>
									</li>
									<li>
										<h4>Hours Played</h4> <span>745 H 22 Mins</span>
									</li>
									<li>
										<h4>Currently</h4> <span>Downloaded</span>
									</li>
									<li>
										<div class="thumb">
											<a href="#" target="_blank"><i class="fa fa-play fa-lg"></i></a>
										</div>
									</li>
								</ul>
							</div>
							<div class="item last-item">
								<ul>
									<li><img src="assets/images/game-03.jpg" alt=""
										class="templatemo-item"></li>
									<li>
										<h4>CS-GO</h4> <span>Sandbox</span>
									</li>
									<li>
										<h4>Date Added</h4> <span>21/04/2022</span>
									</li>
									<li>
										<h4>Hours Played</h4> <span>632 H 46 Mins</span>
									</li>
									<li>
										<h4>Currently</h4> <span>Downloaded</span>
									</li>
									<li>
										<div class="thumb">
											<a href="#" target="_blank"><i class="fa fa-play fa-lg"></i></a>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- ***** Gaming Library End ***** -->
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
	<script src="assets/js/loadMore.js"></script>
	<script src="assets/js/chartGenre.js"></script>
	<script src="assets/js/chartPrefernce.js"></script>
	<script src="assets/js/chartfunction.js"></script>
	
	<%@ include file="includeFooter.jsp"%>
</body>
</html>