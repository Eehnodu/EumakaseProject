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
							<c:choose>
								<c:when test="${searching_music == null}">
									<h4>
										<span class="txtPink">'${keyword}'</span><em>에 대한 검색 결과가
											없습니다.</em>
									</h4>
								</c:when>
								<c:otherwise>
									<h4>
										<span class="txtPink">'${keyword}'</span><em>에 대한 검색
											결과입니다.</em>
									</h4>
								</c:otherwise>
							</c:choose>
						</div>

						<!-- ***** 곡 검색 목록 ***** -->
						<div class="col-lg-12 mb-5">
							<div class="gaming-library" id="gaming-playlist">
								<div class="right-info">
									<div class="heading-section">
										<c:choose>
											<c:when test="${empty searching_music}">
												<h4>
													<span class="txtItalics">검색된 곡이 없습니다.</span>
												</h4>
											</c:when>
											<c:otherwise>
												<h4>
													<em>곡</em>
												</h4>
											</c:otherwise>
										</c:choose>

									</div>
									<!-- 각 곡의 정보를 반복해서 출력 -->
									<c:forEach items="${searching_music}" var="music">
										<div class="col-lg-12 playlist">
											<div class="item songDetail">
												<ul>
													<li><a
														href="${cpath}/songDetail?musicIdx=${music.musicIdx}">
															<img src="${music.albumCov}" alt=""
															class="templatemo-item">
													</a></li>

													<li>
														<h4 class="songTitle" title="${music.title}">${music.title}</h4>
														<span>${music.artist}</span>
													</li>

													<li>
														<h4 class="albumTitle" title="${music.album}">${music.album}</h4>
														<span>앨범명</span>
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




						<!-- ***** 플레이리스트 검색 목록 ***** -->
						<div class="col-lg-12">
							<div class="featured-games header-text">
								<div class="row">
									<div class="heading-section">
										<c:choose>
											<c:when test="${empty myplaylist}">
												<h4>
													<span class="txtItalics">플레이리스트가 없습니다.</span>
												</h4>
											</c:when>
											<c:otherwise>
												<h4>
													<em>플레이리스트</em>
												</h4>
											</c:otherwise>
										</c:choose>
									</div>

									<c:forEach items="${myplaylist}" var="myplay" varStatus="loop">
										<div class="col-lg-3 col-sm-6">
											<div class="item" style="display: block;">
												<div class="thumb">
													<div class="image-grid">
														<c:forEach var="cov" items="${albumCovList}"
															begin="${loop.index * 4}" end="${(loop.index * 4) + 3}">
															<img src="${cov}" alt="">
														</c:forEach>
													</div>
													<div class="down-content">
														<h4 class="pinkPlTitle">${myplay.plName}</h4>
														<span> <c:forEach items="${contextList}"
																var="context" begin="${loop.index}" end="${loop.index}">
															    #${context.surDesc1}
															    #${context.surDesc2}
															    #${context.surDesc3}
															    #${context.surDesc4}
															    #${context.surDesc5}
															</c:forEach>

														</span>
													</div>
												</div>
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


	<!-- Scripts -->

	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>

</body>
<%@ include file="includeFooter.jsp"%>
</html>