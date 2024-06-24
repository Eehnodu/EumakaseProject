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
	href="assets/css/songDetail.css?ver=<%=System.currentTimeMillis()%>">


</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<!-- *** 곡 상세 정보 *** -->
					<div class="game-details">
						<div class="row">
							<div class="col-lg-12">
								<div class="heading-section">
									<h4>
										<em>곡</em> 정보
									</h4>

								</div>
								<div class="main-profile ">
									<div class="row">
										<div class="col-lg-3">
											<%-- <h3 id="musicTitle">${musicDetail.title}</h3> --%>
											<img src="${musicDetail.albumCov}">
										</div>

										<div class="col-lg-9 align-self-center">
											<div class="left-info">
												<%--  <span>가수명</span>
												<h4>${musicDetail.artist}</h4>
												<span>앨범명</span>
												<h4>${musicDetail.album}</h4>
												<span>장르명</span>
												<h4>${musicDetail.genre}</h4>
												<span>발매일</span>
												<h4>${musicDetail.releasedAt}</h4> --%>

												<table>
													<tbody>
														<h3>${musicDetail.title}</h3>
														<tr>
															<th scope="row"><span>아티스트</span></th>
															<td><h4>${musicDetail.artist}</h4></td>
														</tr>
														<tr>
															<th scope="row"><span>앨범명</span></th>
															<td><h4>${musicDetail.album}</h4></td>
														</tr>
														<tr>
															<th scope="row"><span>장르</span></th>
															<td><h4>${musicDetail.genre}</h4></td>
														</tr>
														<tr>
															<th scope="row"><span>발매일</span></th>
															<td><h4>${musicDetail.releasedAt}</h4></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12">
											<div id="songLyrics">
												<div class="heading-section">
													<h4>
														<em>가사</em>
													</h4>
												</div>
												<div id="player" data-iframe="${musicDetail.iframe}"></div>
												<span class="lyrics">${musicDetail.lyrics}</span>
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
	<script src="https://www.youtube.com/iframe_api"></script>
	<script src="assets/js/youtube.js"></script>


</body>
<%@ include file="includeFooter.jsp"%>
</html>