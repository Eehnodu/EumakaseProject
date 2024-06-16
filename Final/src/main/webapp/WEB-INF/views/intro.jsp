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

<link rel="stylesheet"
	href="assets/css/intro.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<script>
	window.onload = function() {
		// 서버 측에서 전달된 에러 메시지를 확인
		let errorMessage = '<c:out value="${errorMessage}" />';
		if (errorMessage && errorMessage.trim().length > 0) { // 에러메세지가 null값이 아닌 경우
			alert(errorMessage);
		}
	}
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script src="assets/js/isotope.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"
	integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="assets/js/intro.js?ver=<%=System.currentTimeMillis()%>"></script>
<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="assets/js/tabs.js"></script>
<script src="assets/js/popup.js"></script>
<style>
.pink-text {
    color: pink; 
}

</style>
</head>
<body data-cpath="${cpath}">

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content" id="introWrap">

					<!-- ***** 페이지 내용 작성 ***** -->

					<div class="row">
						<div id="introImages" class="col-lg-8">
							<div class="featured-games header-text">
								<div class="heading-section">
									<h4>
										<span>Listen to Personalized</span> Playlist
									</h4>
								</div>
								<form id="getIntro" action="/getIntro" method="post" novalidate>
									<div class="plzShow">
										<canvas id="emotionChart" width="400" height="400"></canvas>
									</div>
									<div class="plzShow" id="topSongsByEmotion" width="400"
										height="400">
										<h3></h3>
									</div>
									<div class="plzShow">
										<canvas id="genreChart" width="400" height="400"></canvas>
									</div>
									<div class="plzShow" id="topSongsByGenre" width="400"
										height="400">
										<h3></h3>
									</div>
									<button id="prevChart" type="button">Previous</button>
									<button id="nextChart" type="button">Next</button>
								</form>


							</div>
						</div>



						<div class="col-lg-4">
							<div id="goAi" class="game-details mb-3">
								<a href="${cpath}/AIrecommend">
									<div class="content" id="aiBox">
										<div class="row">
											<div class="col-lg-12">
												<div>
													<h6 id="txtGoAI">
														<svg xmlns="http://www.w3.org/2000/svg"
															enable-background="new 0 0 160 160" viewBox="0 0 160 160"
															class="chef">
															<path
																d="M112.069,104.341l-14.373-4.365v-8.87c2.661-2.073,4.675-4.888,5.742-8.122l2.038-6.183c3.093-0.91,5.479-3.531,6.021-6.79l1.054-6.321c0.538-3.223-0.585-6.459-3.004-8.657l-0.11-0.101c0.054-0.262,0.097-0.525,0.144-0.788c0.541-0.616,0.88-1.414,0.88-2.298V37.631c5.369-1.527,9.313-6.475,9.313-12.327c0-7.065-5.748-12.813-12.813-12.813c-3.193,0-6.167,1.183-8.443,3.182C94.46,9.379,87.405,5.358,79.625,5.358c-7.594,0-14.515,3.811-18.624,9.897c-2.214-1.757-4.997-2.765-7.961-2.765c-7.065,0-12.813,5.748-12.813,12.813c0,5.852,3.944,10.8,9.313,12.327v14.215c0,0.886,0.34,1.686,0.883,2.303c0.047,0.261,0.089,0.522,0.143,0.782l-0.112,0.102c-2.418,2.197-3.542,5.434-3.005,8.656l1.054,6.322c0.543,3.259,2.93,5.88,6.021,6.79l2.039,6.183c1.066,3.234,3.079,6.049,5.742,8.122v8.87l-14.373,4.365c-13.767,4.181-23.017,16.657-23.017,31.045v15.757c0,1.933,1.567,3.5,3.5,3.5h103.172c1.933,0,3.5-1.567,3.5-3.5v-15.757C135.086,120.998,125.836,108.521,112.069,104.341z M90.696,102.535l-10.211,10.211c-0.996-0.367-1.912-0.94-2.685-1.713l-8.497-8.498v-7.067l0.711,0.426c2.79,1.673,5.984,2.558,9.237,2.558h1.496c3.253,0,6.447-0.885,9.237-2.558l0.711-0.426V102.535z M47.227,25.303c0-3.205,2.608-5.813,5.813-5.813c2.363,0,4.473,1.414,5.375,3.602c0.556,1.349,1.884,2.226,3.348,2.165c1.458-0.047,2.734-0.993,3.203-2.375c2.133-6.294,8.024-10.524,14.66-10.524c7,0,13.146,4.729,14.949,11.501c0.407,1.534,1.796,2.6,3.382,2.6c0.003,0,0.007,0,0.01,0c1.591-0.005,2.978-1.081,3.378-2.62c0.665-2.561,2.975-4.349,5.616-4.349c3.205,0,5.813,2.608,5.813,5.813s-2.608,5.813-5.813,5.813c-1.933,0-3.5,1.567-3.5,3.5v13.729h-9.085V39.65c0-1.381-1.119-2.5-2.5-2.5s-2.5,1.119-2.5,2.5v8.695h-18.75V39.65c0-1.381-1.119-2.5-2.5-2.5s-2.5,1.119-2.5,2.5v8.695H56.54V34.616c0-1.933-1.567-3.5-3.5-3.5C49.835,31.116,47.227,28.509,47.227,25.303z M57.254,70.189l-0.494-0.053c-0.684-0.073-1.241-0.598-1.354-1.276l-1.053-6.322c-0.144-0.865,0.158-1.734,0.807-2.324l1.65-1.499c0.939-0.853,1.331-2.142,1.05-3.369h44.28c-0.281,1.227,0.112,2.518,1.05,3.371l1.648,1.497c0.649,0.59,0.951,1.458,0.807,2.324l-1.054,6.323c-0.113,0.678-0.67,1.202-1.354,1.275l-0.483,0.052c-1.548,0.162-2.867,1.222-3.363,2.711l-2.602,7.892c-0.758,2.3-2.318,4.251-4.394,5.495l-6.011,3.604c-1.703,1.021-3.652,1.562-5.638,1.562h-1.496c-1.985,0-3.935-0.54-5.638-1.562l-6.011-3.604c-2.076-1.244-3.636-3.195-4.394-5.494l-2.601-7.888C60.122,71.418,58.802,70.352,57.254,70.189z M31.914,135.385c0-11.284,7.254-21.068,18.051-24.348l15.932-4.839l8.368,8.369c2.348,2.348,5.469,3.641,8.79,3.641h18.344c1.296,0,2.351,1.055,2.351,2.351v27.083H31.914V135.385z M128.086,147.642H108.75v-27.083c0-4.053-3.298-7.351-7.351-7.351H87.093l7.01-7.01l15.932,4.839c10.798,3.279,18.052,13.063,18.052,24.348V147.642z"
																fill="#ffffff" class="color000000 svgShape"></path>
															<path
																d="M94.625 122.072c-1.677 0-3.041 1.364-3.041 3.041 0 1.678 1.364 3.042 3.041 3.042 1.678 0 3.042-1.364 3.042-3.042C97.667 123.436 96.303 122.072 94.625 122.072zM94.625 138.938c-1.677 0-3.041 1.364-3.041 3.041 0 1.678 1.364 3.042 3.041 3.042 1.678 0 3.042-1.364 3.042-3.042C97.667 140.302 96.303 138.938 94.625 138.938z"
																fill="#ffffff" class="color000000 svgShape"></path></svg>
														<span>AI 추천 받으러 가기</span>&nbsp; <i
															class="fa-solid fa-arrow-right-long"></i>
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
										<h5 id="txtSeason">${seasonName}</h5>
										<div class="col-lg-12 playlistDetail right-info"
											id="playlistWrap">
											<div id="songList">
												<div class="col-lg-12 playlist">
													<c:forEach var="season" items="${seasonList}">
														<div class="item songDetail">
															<div>
																<img src="${season.albumCov}" alt=""
																	class="templatemo-item imgCover"> <span
																	class="songTitle">${season.title}</span> <span>${season.artist}</span>
															</div>
														</div>
													</c:forEach>
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
</body>
<script src="assets/js/chartIntro.js"></script>
<script src="assets/js/chartIntroFunction.js"></script>
<%@ include file="includeFooter.jsp"%>
</html>