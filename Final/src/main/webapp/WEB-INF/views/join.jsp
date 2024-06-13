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

<title>회원가입</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>

<!-- ***** css 연결 ***** -->
<link rel="stylesheet" href="assets/css/join.css">
<link rel="stylesheet" href="assets/css/preference.css?ver=<%=System.currentTimeMillis()%>">


</head>
<body data-cpath="${cpath}">


	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<!-- ***** 회원가입 ***** -->
					<div id="prefSurvey">
						<div class="row justify-content-center">
							<div class="col-12 text-center align-self-center">
								<div class="section pb-5 pt-5 pt-sm-2 text-center">
									<div class="card-3d-wrap mx-auto">
										<div class="card-3d-wrapper">
											<div class="center-wrap">
												<div class="section text-center">
													<h4 class="mb-4 pb-3">회원가입</h4>
													<form id="joinForm" action="${cpath}/joinProcess"
														method="post" novalidate>
														<div class="form-group inputId">
															<input type="text" name="memId" class="form-style"
																placeholder="아이디" autocomplete="off" maxlength="50" required>
															<i class="input-icon uil uil-at"></i>
															<button type="button" class="btn btn-sm"
																id="btnCheckId"><span>중복확인</span></button>
														</div>
														<div class="form-group mt-2">
															<input type="password" id="pw1" name="memPw"
																class="form-style" placeholder="비밀번호" autocomplete="off" required>
															<i class="input-icon uil uil-lock-alt"></i>
														</div>
														<div class="form-group mt-2">
															<input type="password" id="pw2" name="memPw2"
																class="pwcheck form-style" placeholder="비밀번호 확인"
																autocomplete="off"> <i
																class="input-icon uil uil-lock-alt" required></i> <span
																id="checkPw"></span>
														</div>
														<div class="form-group mt-4">
															<input type="text" name="name" class="form-style"
																placeholder="이름" autocomplete="off" maxlength="6" required>
															<i class="input-icon uil uil-user"></i>
														</div>


														<!-- 성별 드롭다운 -->
														<div id="genderDiv">
															<div class="dropdown mt-2 inputGender" id="exdiv">
																<div>
																	<span id="genderLabel">성별</span> <i class="input-icon uil uil-mars"></i> 
																</div>
															</div>
															<div class="dropdown w-100" required>
																<button
																	class="btn btn-secondary dropdown-toggle ms-2 mt-2"
																	type="button" id="dropdownGender"
																	data-bs-toggle="dropdown" aria-expanded="false">
																	<span id="genderPlaceholder">성별을 선택해주세요</span>
																	<div id="iconDiv">
																		<i class="fa-solid fa-caret-down"></i>
																	</div>
																</button>
																<ul class="dropdown-menu dropdown-menu-dark"
																	id="ddwGdMenu" aria-labelledby="dropdownGender">
																	<li><a id class="dropdown-item" href="#"
																		data-value="남">남자</a></li>
																	<li><a class="dropdown-item" href="#"
																		data-value="여">여자</a></li>
																</ul>
																<input type="hidden" name="gender" id="genderInput"
																	value="">
															</div>

														</div>


														<div class="form-group mt-2">
															<input id="inputBirth" type="text" name="birth"
																class="form-style" placeholder="생년월일 8글자"
																autocomplete="off" maxlength="8"> <i class="input-icon uil uil-calender"></i>
														</div>
														<button type="submit" class="btn mt-4" id="btnPref">선호도조사
															후 가입하기</button>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- ***** 회원가입 끝 ***** -->

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

	<script
		src="assets/js/checkjoin.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>

</body>
</html>