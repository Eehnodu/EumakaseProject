<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입</title>
<%@ include file="include.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

	<div id="prefSurvey">
		<h3>회원가입</h3>
		<form action="${cpath}/joinProcess" method="post">
			<div>
				아이디 : <input type="text" name="memId">
			</div>
			<div>
				비밀번호 : <input type="password" name="memPw">
			</div>
			<div>
				비밀번호 확인 : <input type="password" name="memPw">
			</div>
			<div>
				이름 : <input type="text" name="name">
			</div>
			<div>
				성별 : <input type="text" name="gender">
			</div>
			<div>
				생년월일 : <input type="text" name="birth">
			</div>
			<div>
				<button type="submit" class="btn btn-primary btn-sm" id="prefButton">선호도
					조사 후 가입하기</button>
			</div>
		</form>
	</div>
	<!-- 선호도 조사 ajax 불러오기 -->




	<script src="${cpath}/assets/js/preference.js?ver=<%=System.currentTimeMillis()%>"></script>

</body>
</html>