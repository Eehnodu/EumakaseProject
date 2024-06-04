<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

	<link rel="stylesheet" href="assets/css/header.css?ver=<%=System.currentTimeMillis()%>">

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="${cpath}/" class="logo"> <img
							src="assets/images/logo.png" alt="">
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li><a href="${cpath}/" class="active">Intro</a></li>
							<%-- 비회원은 내 음악 클릭 시 로그인 모달창 --%>
							<c:if test="${member==null}">
								<li><a id="aMypage" data-bs-toggle="modal" data-bs-target="#loginModal">내
										음악</a></li>
							</c:if>
							<%-- 로그인한 회원은 내 음악 페이지로 이동 --%>
							<c:if test="${member!=null}">
								<li><a class="test" href="${cpath}/mypage">내 음악</a></li>
							</c:if>

							<%-- 비회원은 AI추천 클릭 시 로그인 모달창 --%>
							<c:if test="${member==null}">
								<li><a id="aAi" data-bs-toggle="modal" data-bs-target="#loginModal">AI추천</a></li>
							</c:if>
							<%-- 로그인한 회원은 AI추천 페이지로 이동 --%>
							<c:if test="${member!=null}">
								<li><a href="${cpath}/join">AI추천</a></li>
							</c:if>


							<%-- 로그인 안 했을 시 로그인,회원가입 버튼 --%>
							<c:if test="${member == null}">
								<button type="button" id="navLogin" data-bs-toggle="modal"
									data-bs-target="#loginModal">로그인</button>
							</c:if>
							<%-- 로그인 시 마이페이지,로그아웃 버튼 --%>
							<c:if test="${member != null}">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle active" href="${cpath}/mypage"
									id="profileDropdown" role="button" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"> ${member.name}님
								</a>
									<div class="dropdown-menu" aria-labelledby="profileDropdown">
										<button class="dropdown-item btnNav" id="btnUpdate">
											<a href="${cpath}/update">프로필 수정</a>
										</button>
										<button class="dropdown-item btnNav" id="btnMypage">
											<a href="${cpath}/mypage">나의 뮤직</a>
										</button>
										<form action="${cpath}/logout" method="post">
											<button type="submit" class="dropdown-item btnNav"
												id="btnLogout">로그아웃</button>
										</form>
									</div></li>
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


	<!-- 로그인 Modal -->
	<div class="modal" id="loginModal">
		<div class="modal-dialog" id=="modal-dialog">
			<div class="modal-content" id="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" id="modal-header">

					<h4 class="modal-title">
						<img src="assets/images/logo.png" alt="">
					</h4>
					<button type="button" class="btn-close" id="btn-close"
						data-bs-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" id="modal-body">
					<form action="${cpath}/login" method="post">
						<div class="form-group inputId">
							<input type="text" name="loginId" class="form-style"
								placeholder="아이디" autocomplete="off" maxlength="50"> <i
								class="input-icon uil uil-at"></i>
						</div>
						<div class="form-group mt-3">
							<input type="password" name="loginPw" class="form-style"
								placeholder="비밀번호" autocomplete="off"> <i
								class="input-icon uil uil-lock-alt"></i>
						</div>
						<a id="txtJoin" href="${cpath}/join"> 회원가입 </a>
						<div>
							<button type="submit" class="btn btnPink w-100 mt-5"
								id="btnLogin">로그인</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<!-- 로그인모달 끝 -->


	<script src="assets/js/nav.js?ver=<%=System.currentTimeMillis()%>"></script>
</html>