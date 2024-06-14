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

<!-- 부트스트랩 프레임워크를 상속받는 새로운 스타일러 문제시 삭제가능 쓸꺼면 나중에 includeHeader로 옮겨야함 그냥쓸땐 include header 아래에 넣어야함 mypage.jsp에선 막아둠
	-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.all.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="assets/css/mypage.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
#chartArea {
	position: relative;
}

#chartArea .col-lg-12 {
	position: relative;
}

#prevChart, #nextChart {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	z-index: 10; /* 차트보다 버튼이 앞에 오도록 설정 */
}

#prevChart {
	left: 10px; /* 왼쪽 버튼 위치 조정 */
}

#nextChart {
	right: 10px; /* 오른쪽 버튼 위치 조정 */
}

.btn-arrow {
	background-color: transparent;
	border: none;
	font-size: 2rem; /* 아이콘 크기 조정 */
	cursor: pointer;
}
</style>
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
					<div class="row" id="chartArea">
						<div class="col-lg-12">
							<div class="main-profile">
								<div class="row" id="chartArea">
									<div class="col-lg-12 position-relative">
										<div class="main-profile">
											<div class="row">
												<div class="col-lg-6">
													<!-- 차트 영역 -->
													<form id="chartjs" action="${cpath}/chartjs" method="post"
														novalidate>
														<canvas id="myChart1" width="400" height="400"></canvas>
													</form>
													<form id="getMusic" action="${cpath}/getMusic"
														method="post" novalidate>
														<canvas id="myChart2" width="400" height="400"></canvas>
													</form>
													<form id="getEmotion" action="${cpath}/getEmotion"
														method="post" novalidate>
														<canvas id="myChart3" width="400" height="400"></canvas>
													</form>
												</div>
												<div class="col-lg-6 align-self-center">
													<ul class="showLabelsContainer" id="firstLabelsContainer">
														<li id="labelsContainer1"></li>
														<li id="labelsContainerData1"></li>
													</ul>
													<br>
													<ul class="showLabelsContainer" id="secondLabelsContainer">
														<li id="labelsContainer2"></li>
														<li id="labelsContainerData2"></li>
													</ul>
													<ul class="showLabelsContainer" id="thirdLabelsContainer">
														<li id="labelsContainer3"></li>
														<li id="labelsContainerData3"></li>
													</ul>
												</div>
											</div>
										</div>
										<button id="prevChart" class="btn-arrow">
											<i class="fas fa-arrow-left"></i>
										</button>
										<button id="nextChart" class="btn-arrow">
											<i class="fas fa-arrow-right"></i>
										</button>
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
															<div class="thumb">
																<div class="image-grid">
																	<c:forEach var="cov" items="${myplayListalbumCov}"
																		begin="${loop.index * 4}"
																		end="${(loop.index * 4) + 3}">
																		<img src="${cov.albumCov}" alt="">
																	</c:forEach>
																	<a id="playlistbutton"
																		href="${cpath}/userPlaylist?myplIdx=${myply.myplIdx}"></a>
																</div>
																<div class="down-content">
																	<h4>${myply.plName}</h4>
																</div>
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
	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>
	<script src="assets/js/loadMore.js"></script>
	<script src="assets/js/chartGenre.js"></script>
	<script src="assets/js/chartPrefernce.js"></script>
	<script src="assets/js/chartfunction.js"></script>
	<script src="assets/js/chartEmotion.js"></script>

	<script
		src="assets/js/userPlaylist.js?ver=<%=System.currentTimeMillis()%>"></script>
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