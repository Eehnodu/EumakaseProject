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
<link rel="stylesheet" href="assets/css/userPlaylist.css">

<!-- Bootstrap Tags Input CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap Tags Input JS -->
<script
	src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>



</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<div class="game-details">
						<div class="row">

							<!-- ***** 페이지 플레이리스트 정보 ***** -->

							<!-- *** 플레이리스트 상세 정보 *** -->
							<div class="col-lg-12">
								<div class="heading-section">
									<h4>
										<em>플레이리스트</em> 정보
									</h4>
								</div>
								<div class="content">
									<div class="row">
										<div class="col-lg-3">
											<div class="image-grid">
												<div class="thumb">
													<img src="-" alt="">
												</div>
											</div>
										</div>
										<div class="col-lg-9">
											<div class="left-info">
												<div class="left" id="left">
													<h3 id="playlist">확인</h3>
													<h4>작성자</h4>
													<span>확인</span>
													<h4>작성일자</h4>

													<span>확인</span>
													<h4>확인</h4>

												</div>
											</div>
										</div>
									</div>

									<!-- *** 곡 상세 정보 Start *** -->
									<!-- 두 번째 페이지 HTML 구조 -->
									<div class="col-lg-12">
										<div class="gaming-library" id="gaming-playlist">
											<div class="right-info">
												<!-- 각 곡의 정보를 반복해서 출력 -->
												<c:forEach var="music" items="${recMusicList}"
													varStatus="status">
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<ul>
																<li><img src="${music.albumCov}" alt=""
																	class="templatemo-item"></li>
																<li>
																	<h4>${music.artist}</h4> <span>가수명</span>
																</li>
																<li>
																	<h4>${music.title}</h4> <span>곡명</span>
																</li>
																<li>
																	<h4>${music.album}</h4> <span>앨범명</span>
																</li>
																<li>
																	<h4>${music.genre}</h4> <span>장르</span>
																</li>
																<li>
																	<h4>${music.releasedAt}</h4> <span>발매일</span>
																</li>
															</ul>
														</div>
													</div>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
								<!-- *** 곡 상세 정보 End *** -->
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
	<script src="assets/js/showplaylist.js"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>