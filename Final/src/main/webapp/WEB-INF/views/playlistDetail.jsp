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
<link rel="stylesheet"
	href="assets/css/playlistDetail.css?ver=<%=System.currentTimeMillis()%>">

</head>
<body data-cpath="${cpath}">

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
					<div class="game-details">
						<div class="row">

							<!-- 페이지 플레이리스트 정보 -->

							<!-- 플레이리스트 정보 -->
							<div class="col-lg-12">
								<div class="heading-section">
									<h4>
										<em>지금 이 플리</em> 어때요?
									</h4>
								</div>
								<div class="content">
									<div class="row">
										<div class="col-lg-8">
											<div class="left-info">
												<div class="left">
													<!-- <h4>플레이리스트 제목</h4> -->
													<div class="form-container d-flex align-items-center">
														<div class="form-input">
															<input type="url" placeholder="Paste Your URL"
																id="video-url"> <label for="video-url">플레이리스트
																제목을 입력하세요</label>
														</div>
														<%-- 비회원은 플리저장 클릭 시 로그인 모달창 --%>
														<c:if test="${member==null}">
															<a class="btnSavePl" data-bs-toggle="modal"
																data-bs-target="#loginModal">이 플리 저장하기</a>
														</c:if>
														<%-- 로그인한 회원은 플리 저장 --%>
														<c:if test="${member!=null}">
															<a class="btnSavePl" href="#" id="savePlaylistLink">이
																플리 저장하기</a>
														</c:if>
													</div>
													<span>${input_tag}</span>
												</div>
											</div>
										</div>
										<div class="col-lg-4">
											<div class="main-border-button d-flex align-items-center"
												id="buttonDownload">
												<div class="wrapOtherGenre">
													<span class="d-block txtOtherGenre mb-4">다른 장르로 추천받기</span>
													<c:forEach var="genre" items="${preGenre}">
														<button id="redDiff" class="toggle-btn btnOtherGenre"
															value="${genre.surDesc}">${genre.surDesc}</button>
													</c:forEach>
													<button id="redDiff" class="toggle-btn btnOtherGenre"
														value="${input_genre}">기존 추천</button>
												</div>
											</div>
										</div>
										<!-- ***** Gaming Library Start ***** -->
										<div class="col-lg-12">
											<div class="gaming-library" id="gaming-playlist">
												<div class="right-info" id="playlistList">
													<c:forEach var="music" items="${musicList}">
														<div class="col-lg-12 playlist">
															<div class="item songDetail">
																<ul>
																	<li><img src="${music.albumCov}" alt=""
																		class="templatemo-item"></li>
																	<li>
																		<h4 class="songTitle">${music.title}</h4> <span>${music.artist}</span>
																	</li>
																	<li>
																		<h4 class="albumTitle">${music.album}</h4> <span>앨범명</span>
																	</li>
																	<li>
																		<h4>${music.genre}</h4> <span>장르</span>
																	</li>
																	<li><c:choose>
																			<c:when test="${music.releasedAt == '0001-01-01'}">
																				<h4>-</h4>
																			</c:when>
																			<c:otherwise>
																				<h4>${music.releasedAt}</h4>
																			</c:otherwise>
																		</c:choose> <span>발매일</span></li>
																</ul>
															</div>
														</div>

													</c:forEach>


												</div>
											</div>
										</div>
									</div>
									<!-- ***** Gaming Library End ***** -->
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


	<script
		src="assets/js/isotope.min.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/owl-carousel.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/tabs.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/popup.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/custom.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/showplaylist.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/intro.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/otherPlaylist.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/savePlaylist.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>