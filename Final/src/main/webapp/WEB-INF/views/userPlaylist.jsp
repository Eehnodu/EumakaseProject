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

<!-- 부트스트랩 프레임워크를 상속받는 새로운 스타일러 문제시 삭제가능 쓸꺼면 나중에 includeHeader로 옮겨야함 그냥쓸땐 include header 아래에 넣어야함-->
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.all.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.1/dist/sweetalert2.min.css"
	rel="stylesheet">
<!-- 부트스트랩 프레임워크를 상속받는 새로운 스타일러 문제시 삭제가능 -->

<!-- ***** css 연결 ***** -->
<link rel="stylesheet"
	href="assets/css/userPlaylist.css?ver=<%=System.currentTimeMillis()%>">

<!-- Bootstrap Tags Input CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css">

<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Bootstrap Tags Input JS -->
<script
	src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>

<!-- FontAwesome CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<!-- Material Icons CSS -->
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@400&display=swap"
	rel="stylesheet">

</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<div class="game-details">
						<div class="row">
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
												<c:forEach var="albumCov" items="${userAlbumCovList}"
													varStatus="status">
													<c:if test="${status.index < 4}">
														<div class="thumb">
															<img src="${albumCov}" alt="">
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
										<div class="col-lg-9">
											<div class="left-info">
												<div class="left" id="left">
													<h3 id="playlist">${userPl.plName}</h3>
													<h4>작성자</h4>
													<span>${name}</span>
													<h4>작성일자</h4>
													<span>${userPl.createdAt}</span>
													<h4>${userSurDescList}</h4>
												</div>
												<c:choose>
													<c:when test="${crud}">
														<div class="rightbutton">
															<button type="button" class="btn btn-edit"
																data-bs-toggle="modal" data-bs-target="#plyupdate">
																<i class="fas fa-pencil-alt"></i> 이름 수정
															</button>
															<button type="button" class="btn btn-delete"
																id="#plydelete">
																<i class="fas fa-trash-alt"></i>플리 삭제
															</button>
														</div>
													</c:when>
													<c:otherwise>
														<!-- <button type="button" class="btn btn-primary btn-outline-primary" id="plyinsert">
															<span class="material-symbols-outlined">playlist_add</span> 플리저장
														</button> -->
														<button type="button" class="btn btn-primary btn-outline-primary btn-slide2" id="plyinsert">
															<span class="material-symbols-outlined circle2">playlist_add</span>
															<span class="title2">플리 저장</span> 
															<span class="title-hover2">플리 저장</span>
														</button>

													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>

									<!-- *** 곡 상세 정보 Start *** -->
									<!-- 두 번째 페이지 HTML 구조 -->
									<div class="col-lg-12">
										<div class="gaming-library" id="gaming-playlist">
											<div class="right-info">
												<!-- 각 곡의 정보를 반복해서 출력 -->
												<c:forEach var="music" items="${userPlaylistList}"
													varStatus="status">
													<div class="col-lg-12 playlist">
														<div class="item songDetail">
															<ul>
																<li><a
																	href="<c:url value='/songDetail?musicIdx=${music.musicIdx}'/>">
																		<img src="${music.albumCov}" alt=""
																		class="templatemo-item">
																</a></li>
																<li>
																	<h4 class="songTitle">${music.title}</h4> <span>${music.artist}</span>
																</li>
																<li>
																	<h4 class="albumTitle">${music.album}</h4> <span>앨범명</span>
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

	<!-- Scripts -->

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
		src="assets/js/showplaylist.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script src="assets/js/intro.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>