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

<title>메인</title>
<%@ include file="include.jsp"%>
<link rel="stylesheet" href="assets/css/main.css">
</head>
<body>

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="index.html" class="logo"> <img
							src="assets/images/logo.png" alt="">
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Search End ***** -->
						<div class="search-input">
							<form id="search" action="#">
								<input type="text" placeholder="Type Something" id='searchText'
									name="searchKeyword" onkeypress="handle" /> <i
									class="fa fa-search"></i>
							</form>
						</div>
						<!-- ***** Search End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li><a href="index.html" class="active">Home</a></li>
							<li><a href="browse.html">Browse</a></li>
							<li><a href="details.html">Details</a></li>
							<li><a href="streams.html">Streams</a></li>
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle active" href="profile.html"
								id="profileDropdown" role="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> Profile <img
									src="assets/images/profile-header.jpg" alt=""
									style="vertical-align: middle;">
							</a>
								<div class="dropdown-menu" aria-labelledby="profileDropdown">
									<a class="dropdown-item" href="${cpath}/update">프로필 수정</a> <a
										class="dropdown-item" href="${cpath}/mypage">나의 뮤직</a> <a
										class="dropdown-item" href="#">로그아웃</a>
								</div></li>

						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- ***** Header Area End ***** -->

</body>
</html>