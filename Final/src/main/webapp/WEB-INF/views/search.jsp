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

<!-- ***** css 연결 ***** -->
<link rel="stylesheet"
	href="assets/css/search.css?ver=<%=System.currentTimeMillis()%>">

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<div class="row">

						<div class="col-lg-12">
							<h4>
								<span class="txtPink">'태연'</span><em>에 대한 검색 결과입니다.</em>
							</h4>
						</div>

						<!-- ***** 곡 검색 목록 ***** -->
						<div class="col-lg-12 mb-5">
							<div class="gaming-library" id="gaming-playlist">
								<div class="right-info">
									<div class="heading-section">
										<h4>
											<em>곡</em>
										</h4>
									</div>
									<!-- 각 곡의 정보를 반복해서 출력 -->
									<div class="col-lg-12 playlist">
										<div class="item songDetail" style="display: block;">
											<ul>
												<li><a href="/controller/songDetail?musicIdx=5699">
														<img
														src="https://cdnimg.melon.co.kr/cm2/album/images/106/63/806/10663806_20210728144617_500.jpg?b66dd9b9e89cae4c0df2e02d62751af9/melon/resize/282/quality/80/optimize"
														alt="" class="templatemo-item">
												</a></li>

												<li>
													<h4 class="songTitle" title="곁에 있어줘 (Feat. 원슈타인)">곁에
														있어줘 (Feat. 원슈타인)</h4> <span>SOLE (쏠)</span>
												</li>

												<li>
													<h4 class="albumTitle" title="곁에 있어줘">곁에 있어줘</h4> <span>앨범명</span>
												</li>
												<li>
													<h4>R&amp;B/Soul</h4> <span>장르</span>
												</li>
												<li>
													<h4>2021-07-28</h4> <span>발매일</span>
												</li>
											</ul>
										</div>
									</div>

									<div class="col-lg-12 playlist">
										<div class="item songDetail" style="display: block;">
											<ul>
												<li><a href="/controller/songDetail?musicIdx=5699">
														<img
														src="https://cdnimg.melon.co.kr/cm2/album/images/106/63/806/10663806_20210728144617_500.jpg?b66dd9b9e89cae4c0df2e02d62751af9/melon/resize/282/quality/80/optimize"
														alt="" class="templatemo-item">
												</a></li>

												<li>
													<h4 class="songTitle" title="곁에 있어줘 (Feat. 원슈타인)">곁에
														있어줘 (Feat. 원슈타인)</h4> <span>SOLE (쏠)</span>
												</li>

												<li>
													<h4 class="albumTitle" title="곁에 있어줘">곁에 있어줘</h4> <span>앨범명</span>
												</li>
												<li>
													<h4>R&amp;B/Soul</h4> <span>장르</span>
												</li>
												<li>
													<h4>2021-07-28</h4> <span>발매일</span>
												</li>
											</ul>
										</div>
									</div>



								</div>
							</div>
						</div>




						<!-- ***** 플레이리스트 검색 목록 ***** -->
						<div class="col-lg-12">
							<div class="featured-games header-text">
								<div class="row">
									<div class="heading-section">
										<h4>
											<em>플레이리스트</em>
										</h4>
									</div>
									<div class="col-lg-3 col-sm-6">
										<div class="item" style="display: block;">
											<div class="thumb">
												<div class="image-grid">

													<img
														src="https://cdnimg.melon.co.kr/cm2/album/images/104/14/459/10414459_20200408150259_500.jpg?09093e2bd3b4832f7395dc0874503a97/melon/resize/282/quality/80/optimize"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/112/36/264/11236264_20230508184331_500.jpg?YUV420-90/melon/resize/282"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/112/21/404/11221404_20230411101938_500.jpg?88ac69b8898d071841a17a3230480227/melon/resize/282/quality/80/optimize"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/108/63/559/10863559_20220214160739_500.jpg?42c2b52a394ac94dad21d64aec2c577d/melon/resize/282/quality/80/optimize"
														alt=""> <a id="playlistbutton"
														href="/controller/userPlaylist?myplIdx=7"></a>
												</div>
												<div class="down-content">
													<h4>세상아 덤벼라</h4>
													<span>#댄스 #연인 #집 #휴가 #기쁨</span>
												</div>
											</div>
										</div>
									</div>


									<div class="col-lg-3 col-sm-6">
										<div class="item" style="display: block;">
											<div class="thumb">
												<div class="image-grid">

													<img
														src="https://cdnimg.melon.co.kr/cm2/album/images/104/14/459/10414459_20200408150259_500.jpg?09093e2bd3b4832f7395dc0874503a97/melon/resize/282/quality/80/optimize"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/112/36/264/11236264_20230508184331_500.jpg?YUV420-90/melon/resize/282"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/112/21/404/11221404_20230411101938_500.jpg?88ac69b8898d071841a17a3230480227/melon/resize/282/quality/80/optimize"
														alt=""> <img
														src="https://cdnimg.melon.co.kr/cm2/album/images/108/63/559/10863559_20220214160739_500.jpg?42c2b52a394ac94dad21d64aec2c577d/melon/resize/282/quality/80/optimize"
														alt=""> <a id="playlistbutton"
														href="/controller/userPlaylist?myplIdx=7"></a>
												</div>
												<div class="down-content">
													<h4>세상아 덤벼라</h4>
													<span>#댄스 #연인 #집 #휴가 #기쁨</span>
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
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>


</body>
<%@ include file="includeFooter.jsp"%>
</html>