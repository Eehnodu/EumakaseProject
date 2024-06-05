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
<title>마이페이지</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet"
	href="assets/css/update.css?ver=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v3.0.6/css/line.css">
<script>
	window.onload = function() {
		// 서버 측에서 전달된 에러 메시지를 확인
		let errorMessage = '<c:out value="${errorMessage}" />';
		if (errorMessage && errorMessage.trim().length > 0) { // 에러메세지가 null값이 아닌 경우
			alert(errorMessage);
		}
	}
</script>

</head>
<body data-cpath="${cpath}">

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">

					<div class="row justify-content-center">
						<div class="col-12 text-center align-self-center">
							<div class="section pb-5 pt-5 mb-4 pt-sm-2 text-center">
								<div class="card-3d-wrap mx-auto">
									<div class="card-3d-wrapper">
										<div class="center-wrap">
											<div class="section text-center">
												<div>
													<h4 class="pb-3">비밀번호 수정</h4>
													<form action="${cpath}/update" method="post">
														<div class="form-group mt-2">
															<input type="password" name="oldPw"
																class="pwcheck form-style" placeholder="현재 비밀번호"
																autocomplete="off"> <i
																class="input-icon uil uil-lock-alt"></i>
																<span id="checkPw"></span>
														</div>
														<div class="form-group mt-2">
															<input type="password" name="newPw" class="form-style"
																placeholder="새 비밀번호" autocomplete="off"> <i
																class="input-icon uil uil-lock-alt"></i> <span
																id="checkPw"></span>
														</div>
														<button type="submit" class="btn mt-4" id="btnUpdateSmt">수정하기</button>
													</form>
												</div>
												<div class="pt-5" id="deleteSection">
													<h4 class="mt-5 pb-3">회원탈퇴</h4>
													<form action="${cpath}/delete" method="post">
														<div class="form-group mt-2">
															<input type="password" name="memPw" class="form-style"
																placeholder="비밀번호 입력" autocomplete="off"> <i
																class="input-icon uil uil-lock-alt"></i>
														</div>
														<button type="submit" class="btn mt-4" id="btnDeleteSmt">탈퇴하기</button>
													</form>
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
	</div>


	<!-- Scripts -->
	<!-- Bootstrap core JavaScript -->
	<script src="assets/js/isotope.min.js"></script>
	<script src="assets/js/owl-carousel.js"></script>
	<script src="assets/js/tabs.js"></script>
	<script src="assets/js/popup.js"></script>
	<script src="assets/js/custom.js"></script>

	<script src="assets/js/update.js?ver=<%=System.currentTimeMillis()%>"></script>

	<%@ include file="includeFooter.jsp"%>
</body>
</html>