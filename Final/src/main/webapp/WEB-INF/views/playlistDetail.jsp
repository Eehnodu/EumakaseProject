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
										<div class="col-lg-6">
											<div class="left-info">
												<div class="left">
													<h4>플레이리스트 제목</h4>
													<span>${input_tag}</span>
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
											<div class="main-border-button" id="buttonDownload">

												<a href="${cpath}/savePlaylist">이 플리 저장</a> <a href="#"
													id="redDiff">다른 플리 보여줘</a>

											</div>
										</div>
										<!-- ***** Gaming Library Start ***** -->
										<div class="col-lg-12">
											<div class="gaming-library" id="gaming-playlist">
												<div class="right-info">
													<c:forEach var="music" items="${musicList}">
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


	<script src="assets/js/isotope.min.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/owl-carousel.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/tabs.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/popup.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/custom.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/showplaylist.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>