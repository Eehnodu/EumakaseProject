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

					<div class="row">
						<div class="col-lg-12">
							<div class="heading-section">
								<h4>
									<em>곡</em> 정보
								</h4>
							</div>
							<div class="main-profile">
								<div class="row">
									<div class="col-lg-4">
										<img src="${musicDetail.albumCov}">
									</div>

									<div class="col-lg-8 align-self-center">
										<ul>
											<li>곡명 <span>${musicDetail.title}</span></li>
											<li>가수명 <span>${musicDetail.artist}</span></li>
											<li>앨범명 <span>${musicDetail.album}</span></li>
											<li>장르 <span>${musicDetail.genre}</span></li>
											<li>발매일 <span>${musicDetail.releasedAt}</span></li>
										</ul>
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
											<span>${musicDetail.lyrics}
											 </span>

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