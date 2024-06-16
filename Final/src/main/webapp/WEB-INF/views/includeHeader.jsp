<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<link rel="stylesheet"
	href="assets/css/header.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v3.0.6/css/line.css">
<script src="assets/js/search.js?ver=<%=System.currentTimeMillis()%>"></script>


<!-- ***** Header Area Start ***** -->
<header class="header-area header-sticky">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<nav class="main-nav">
					<!-- ***** Logo Start ***** -->
					<%-- 비회원은 로고 클릭 시 소개페이지 --%>
					<c:if test="${member==null}">
						<a href="${cpath}/" class="logo"> <img
							src="assets/images/logo2.png" alt="">
						</a>
					</c:if>
					<%-- 로그인한 회원은 로고 클릭 시 메인페이지 --%>
					<c:if test="${member!=null}">
						<a href="${cpath}/mainPage" class="logo"> <img
							src="assets/images/logo2.png" alt="">
						</a>
					</c:if>
					<!-- ***** Logo End ***** -->
					<!-- ***** Search Start ***** -->
					<div class="search-input">
						<form id="search" action="${cpath}/search">
							<input type="text" id="searchText" name="searchKeyword"
								placeholder="Type Something" /> <i class="fa fa-search"></i>
							<ul class="nav flex-column" id=search-results>
								
							</ul>
						</form>
					</div>
					<!-- ***** Search End ***** -->
					<!-- ***** Menu Start ***** -->
					<ul class="nav nav-pills">
						<%-- 비회원은 Home 클릭 시 로그인 모달창 --%>
						<c:if test="${member==null}">
							<li class="nav-item"><a class="nav-link"
								data-bs-toggle="modal" data-bs-target="#loginModal">홈</a></li>
						</c:if>
						<%-- 로그인한 회원은 메인페이지로 이동 --%>
						<c:if test="${member!=null}">
							<li class="nav-item"><a href="${cpath}/mainPage"
								class="nav-link active" id="navHome">홈</a></li>
						</c:if>

						<%-- 비회원은 내 음악 클릭 시 로그인 모달창 --%>
						<c:if test="${member==null}">
							<li class="nav-item"><a id="navMypage"
								data-bs-toggle="modal" data-bs-target="#loginModal">마이뮤직</a></li>
						</c:if>
						<%-- 로그인한 회원은 내 음악 페이지로 이동 --%>
						<c:if test="${member!=null}">
							<li class="nav-item"><a href="${cpath}/mypage"
								class="nav-link" id="navMypage">마이뮤직</a></li>
						</c:if>

						<%-- 회원/비회원 모두 AI추천 가능 --%>
						<li class="nav-item"><a href="${cpath}/AIrecommend"
							class="nav-link" id="navAi">AI추천</a></li>

						<%-- 비회원은 로그인 버튼 --%>
						<c:if test="${member == null}">
							<button type="button" id="navLogin" data-bs-toggle="modal"
								data-bs-target="#loginModal">로그인</button>
						</c:if>
						<%-- 로그인 시 프로필 버튼 --%>
						<c:if test="${member != null}">
							<div class="dropdown">
								<button type="button" id="profileDropdown"
									class="btn dropdown-toggle" data-bs-toggle="dropdown">
									<span id="memberName">${member.name}님</span>
								</button>
								<ul class="dropdown-menu dropdown-menu-dark">
									<li><a class="dropdown-item" id="btnUpdate"
										href="${cpath}/update">프로필 수정</a></li>
									<li><a class="dropdown-item" id="btnMypage"
										href="${cpath}/mypage">마이뮤직</a></li>
									<li>
										<form action="${cpath}/logout" method="post">
											<button type="submit" class="dropdown-item" id="btnLogout">로그아웃</button>
										</form>
									</li>
								</ul>
							</div>
						</c:if>
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

<!-- 플레이리스트 수정 모달 -->

<div class="modal fade" id="plyupdate" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content modal-ed-content">
			<div class="modal-header modal-ed-header">
				<h5 class="modal-title" id="editModalTitle">
					"${defaultplName}"<br>(을)를 무엇으로 변경할까요?
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body mt-3">
				<div class="form-group ed-form-group">
					<input type="text" name="newPlaylistName"
						class="form-style ed-form-style" id="newPlaylistName"
						placeholder="${defaultplName}" autocomplete="off" maxlength="50">

					<input type="hidden" name="nowplyIdx" id="nowplyIdx"
						value="${nowplyIdx}"> <i
						class="input-icon fa-solid fa-music"></i>
					<button type="button" class="btn btn-confirm btnPink"
						id="submitbotton">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 플레이리스트 수정 모달 끝 -->

<!-- 로그인 Modal -->
<div class="modal" id="loginModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">

				<h4 class="modal-title">
					<img src="assets/images/logo2.png" alt="">
				</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="${cpath}/login" method="post">
					<div class="form-group inputId">
						<input type="text" name="loginId" class="form-style"
							placeholder="아이디" autocomplete="off" maxlength="50"> <i
							class="input-icon uil uil-at"></i>
					</div>
					<div class="form-group mt-3">
						<input type="password" name="loginPw" id="loginPw"
							class="form-style" placeholder="비밀번호" autocomplete="off">
						<i class="input-icon uil uil-lock-alt"></i>
					</div>
					<a id="txtJoin" href="${cpath}/join"> 회원가입 </a>
					<div>
						<button type="submit" class="btn btnPink w-100 mt-5" id="btnLogin">로그인</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>
<!-- 로그인모달 끝 -->


<script src="assets/js/nav.js?ver=<%=System.currentTimeMillis()%>"></script>
</html>