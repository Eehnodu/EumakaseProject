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
													<span>#신나는 #아이돌</span>
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
												<a href="#">이 플리 저장</a> <a href="#">다른 플리 보여줘</a>

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
																	<h4>${music.title}</h4> <span>${music.artist}</span>
																</li>
																<li>
																	<h4>${music.album}</h4> <span>앨범명</span>
																</li>
																<li>
																	<h4>${music.genre}</h4> <span>장르</span>
																</li>
																<li>
																	<c:choose>
												                        <c:when test="${music.releasedAt == '0001-01-01'}">
												                            <h4>-</h4>
												                        </c:when>
												                        <c:otherwise>
												                            <h4>${music.releasedAt}</h4>
												                        </c:otherwise>
												                    </c:choose> <span>발매일</span>
																</li>
																<li>
                                <div class="heartbox">
                                  <input type="checkbox" class="checkbox" id="checkbox1" />
                                  <label for="checkbox1">
                                    <svg id="heart-svg" viewBox="467 392 58 57" xmlns="http://www.w3.org/2000/svg">
                                      <g id="Group" fill="none" fill-rule="evenodd" transform="translate(467 392)">
                                        <path
                                          d="M29.144 20.773c-.063-.13-4.227-8.67-11.44-2.59C7.63 28.795 28.94 43.256 29.143 43.394c.204-.138 21.513-14.6 11.44-25.213-7.214-6.08-11.377 2.46-11.44 2.59z"
                                          id="heart" fill="#AAB8C2" />
                                        <circle id="main-circ" fill="#E2264D" opacity="0" cx="29.5" cy="29.5" r="1.5" />

                                        <g id="heartgroup7" opacity="0" transform="translate(7 6)">
                                          <circle id="heart1" fill="#9CD8C3" cx="2" cy="6" r="2" />
                                          <circle id="heart2" fill="#8CE8C3" cx="5" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup6" opacity="0" transform="translate(0 28)">
                                          <circle id="heart1" fill="#CC8EF5" cx="2" cy="7" r="2" />
                                          <circle id="heart2" fill="#91D2FA" cx="3" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup3" opacity="0" transform="translate(52 28)">
                                          <circle id="heart2" fill="#9CD8C3" cx="2" cy="7" r="2" />
                                          <circle id="heart1" fill="#8CE8C3" cx="4" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup2" opacity="0" transform="translate(44 6)">
                                          <circle id="heart2" fill="#CC8EF5" cx="5" cy="6" r="2" />
                                          <circle id="heart1" fill="#CC8EF5" cx="2" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup5" opacity="0" transform="translate(14 50)">
                                          <circle id="heart1" fill="#91D2FA" cx="6" cy="5" r="2" />
                                          <circle id="heart2" fill="#91D2FA" cx="2" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup4" opacity="0" transform="translate(35 50)">
                                          <circle id="heart1" fill="#F48EA7" cx="6" cy="5" r="2" />
                                          <circle id="heart2" fill="#F48EA7" cx="2" cy="2" r="2" />
                                        </g>

                                        <g id="heartgroup1" opacity="0" transform="translate(24)">
                                          <circle id="heart1" fill="#9FC7FA" cx="2.5" cy="3" r="2" />
                                          <circle id="heart2" fill="#9FC7FA" cx="7.5" cy="2" r="2" />
                                        </g>
                                      </g>
                                    </svg>
                                  </label>
                                </div>
                              </li>
															</ul>
														</div>
													</div>
													</c:forEach>
													
													<div class="main-button" id="loadMore">
														<a href="profile.html">더보기</a>
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


		<!-- Scripts -->
		

		<script src="assets/js/isotope.min.js"></script>
		<script src="assets/js/owl-carousel.js"></script>
		<script src="assets/js/tabs.js"></script>
		<script src="assets/js/popup.js"></script>
		<script src="assets/js/custom.js"></script>
		<script src="assets/js/loadMore.js"></script>
		<script src="assets/js/like.js"></script>

		<%@ include file="includeFooter.jsp"%>
</body>
</html>