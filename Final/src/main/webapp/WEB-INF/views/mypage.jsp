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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
										<button id="prevChart" class="btn-arrow">
											<i class="fas fa-arrow-left"></i>
										</button>
										<button id="nextChart" class="btn-arrow">
											<i class="fas fa-arrow-right"></i>
										</button>

										<!-- 차트 영역 -->
										<form id="chartjs" action="${cpath}/chartjs" method="post"
											novalidate>
											<canvas id="myChart" width="200" height="200"></canvas>
										</form>
										<form id="getMusic" action="${cpath}/getMusic" method="post"
											novalidate>
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
												<c:forEach var="myply" items="${myplayList}"
													varStatus="loop">
													<div class="col-lg-3 col-sm-6">
														<div class="item">
														<a id="playlistbutton"
																		href="${cpath}/userPlaylist?myplIdx=${myply.myplIdx}">
															<div class="thumb image-grid">
																<c:forEach var="cov" items="${myplayListalbumCov}"
																	begin="${loop.index * 4}" end="${(loop.index * 4) + 3}">
																	<img src="${cov.albumCov}" alt="">
																</c:forEach>
																<div class="hover-effect2">
																	
																	<h6>지금 듣기</h6>
																</div>
															</div>
															</a>
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
														<a href="#">더보기</a>
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

				</div>
			</div>
		</div>
	</div>




	<!-- Scripts -->

	<script
		src="assets/js/isotope.min.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/owl-carousel.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/tabs.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/popup.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/custom.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/loadMore.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/chartGenre.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/chartPrefernce.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/chartfunction.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>