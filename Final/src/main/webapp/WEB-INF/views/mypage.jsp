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

<title>음악하세</title>
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
</head>
<body data-cpath="${cpath}">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<div class="row" id="chartArea">
						<div class="col-lg-12">
							<div class="main-profile">
								<div class="row" id="chartArea">
									<div class="col-lg-12 position-relative">
										<div class="row">
											<div class="col-lg-12">
												<div class="heading-section">
													<h4>
														<em>나의</em> 선호도
													</h4>
												</div>
											</div>
											<div class="row chartPref">
												<div class="col-lg-6 d-flex justify-content-end">
													<!-- 차트 영역 -->
													<form id="getmygenre" action="/getMypage" method="post"
														novalidate>
														<canvas id="myChart1" width="400" height="400"
															style="margin-right: 30px; margin-top: -40px"></canvas>
													</form>
													<form id="getmymusic" action="/getMypage"
														method="post" novalidate>
														<canvas id="myChart2" width="400" height="400"
															style="margin-right: 30px; margin-top: -40px"></canvas>
													</form>
													<form id="getmyemotion" action="/getMypage"
														method="post" novalidate>
														<canvas id="myChart3" width="400" height="400"
															style="margin-right: 30px; margin-top: -40px"></canvas>
													</form>
												</div>
												<div
													class="col-lg-6 align-self-center justify-content-center"
													id="wrapTable">
													<ul class="showLabelsContainer" id="firstLabelsContainer">
														<li id="labelsContainer1"></li>
														<li id="labelsContainerData1"></li>
													</ul>
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
											<i class="fa-solid fa-backward-step"></i>
										</button>
										<button id="nextChart" class="btn-arrow">
											<i class="fa-solid fa-forward-step"></i>
										</button>
									</div>



								/div>

								<div class="row">
									<div class="col-lg-12">
										<div class="clips">
											<div class="row">
												<div class="col-lg-12">
													<div class="heading-section">
														<h4>
															<em>나의</em> 플레이리스트
														</h4>
													</div>
												</div>
												<c:forEach var="myply" items="${myplayList}" varStatus="loop">
													<div class="col-lg-3 col-sm-6">
													<a id="playlistbutton" href="${cpath}/userPlaylist?myplIdx=${myply.myplIdx}">
														<div class="item">
															<div class="thumb">
																<div class="image-grid">
																	<c:forEach var="cov" items="${myplayListalbumCov}"
																		begin="${loop.index * 4}"
																		end="${(loop.index * 4) + 3}">
																		<img src="${cov.albumCov}" alt="">
																	</c:forEach>
															
																	
																	<div class="hover-effect2">
																		<h6>상세 보기</h6>
																	</div>
																</div>
																<div class="down-content">
																	<h4>${myply.plName}</h4>
																</div>
																<div>
																	<span>
															<c:forEach items="${contextList}" var="context"
															begin="${loop.index}" end="${loop.index}">
															    #${context.surDesc1}
															    #${context.surDesc2}
															    #${context.surDesc3}
															    #${context.surDesc4}
															    #${context.surDesc5}
															</c:forEach>
															
														</span>
																</div>
															</div>
															</a>
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
		<script src="assets/js/chartEmotion.js"></script>
		<script src="assets/js/chartfunction.js"></script>

		<script
			src="assets/js/userPlaylist.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/isotope.min.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/owl-carousel.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script src="assets/js/tabs.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script src="assets/js/popup.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script src="assets/js/custom.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/loadMore.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/chartGenre.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/chartPrefernce.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/chartfunction.js?ver=<%=System.currentTimeMillis()%>"></script>
		<script
			src="assets/js/mypage.js?ver=<%=System.currentTimeMillis()%>"></script>
		<%@ include file="includeFooter.jsp"%>
</body>
</html>