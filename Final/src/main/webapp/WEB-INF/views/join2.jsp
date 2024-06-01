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
<title>가입</title>
<%@ include file="include.jsp"%>
<%@ include file="includeHeader.jsp"%>
<link rel="stylesheet" href="assets/css/join.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	let cpath = "${cpath}"
</script>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-content">
					<div id="prefSurvey">
						<h3>회원가입</h3>
						<form action="${cpath}/joinProcess" method="post">
							<table>
								<tr>
									<td>아이디:</td>
									<td><input type="text" name="memId"></td>
									<td><button type="button" class="btn btn-primary btn-sm"
											id="btnCheckId">중복확인</button></td>
								</tr>
								<tr>
									<td>비밀번호:</td>
									<td><input type="password" id="pw1" name="memPw"></td>
								</tr>
								<tr>
									<td>비밀번호 확인:</td>
									<td><input type="password" id="pw2" class="pwcheck"
										name="memPw2"></td>
									<td><span id="checkPw"></span></td>
								</tr>
								<tr>
									<td>이름:</td>
									<td><input type="text" name="name"></td>
								</tr>
								<tr>
									<td>성별:</td>
									<td>남자 <input type="radio" name="gender" value="남">
										여자 <input type="radio" name="gender" value="여">
									</td>
								</tr>
								<tr>
									<td>생년월일:</td>
									<td ><input type="text" placeholder="생년월일 8글자" name="birth"></td>
								</tr>
								<tr>
									<td colspan="3">
										<button type="submit" class="btn btn-primary btn-sm"
											id="btnPref">선호도조사 후 가입하기</button>
									</td>
								</tr>
							</table>
						</form>
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

	<script
		src="assets/js/checkjoin.js?ver=<%=System.currentTimeMillis()%>"></script>
	<script
		src="assets/js/preference.js?ver=<%=System.currentTimeMillis()%>"></script>


	<%@ include file="includeFooter.jsp"%>




</body>
</html>