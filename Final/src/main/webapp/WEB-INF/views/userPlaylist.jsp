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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap Tags Input JS -->
<script src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>



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
											<img src="assets/images/stream-01.jpg" alt=""
												style="border-radius: 23px;">
										</div>
										<div class="col-lg-9">
											<div class="left-info">
												<div class="left" id="left">
													<h3 id="playlist">플레이리스트 제목</h3>
													<h4>작성자</h4>
													<span>누구게</span>
													<h4>작성일자</h4>
													<span>2024.06.06</span>
													<div class="inputContainer">
													<h4>태그</h4>
														<input class="input-tags" type="text"
															data-role="tagsinput" value="신나는, 랩">
													</div>
												</div>
												<div class="right" id="right">
													<ul>
														<li><div class="main-button" id="buttonDownload">
																<a href="#">수정</a>
															</div></li>
														<li><div class="main-button" id="buttonDownload">
																<a href="#">삭제</a>
															</div></li>
													</ul>
												</div>
											</div>
										</div>
									</div>

									<!-- *** 곡 상세 정보 Start *** -->
									<div class="col-lg-12">
										<div class="gaming-library" id="gaming-playlist">
											<div class="right-info">
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>New Jeans</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>곡명</span>
															</li>
															<li>
																<h4>NewJeans 2nd EP 'Get Up'</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>댄스</h4> <span>장르</span>
															</li>
															<li>
																<h4>2023.07.21</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-02.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-03.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-02.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-03.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
												</div>
												<div class="col-lg-12 playlist">
													<div class="item songDetail">
														<ul>
															<li><img src="assets/images/game-01.jpg" alt=""
																class="templatemo-item"></li>
															<li>
																<h4>Doja cat</h4> <span>가수명</span>
															</li>
															<li>
																<h4>Date Added</h4> <span>곡명</span>
															</li>
															<li>
																<h4>Hours Played</h4> <span>앨범명</span>
															</li>
															<li>
																<h4>Currently</h4> <span>장르</span>
															</li>
															<li>
																<h4>Supery Shy</h4> <span>발매일</span>
															</li>
														</ul>
													</div>
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