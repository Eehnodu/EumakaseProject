<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="include.jsp"%>

</head>
<body>

	<div>
		<a href="${cpath}/main">메인화면으로</a>
	</div>
	
	<br>

	<form action="${cpath}/logout" method="post">
		<button type="submit" class="btn btn-dark btn-sm">로그아웃</button>
	</form>
	
	<br>

	<div>
		<h3>회원정보</h3>
		이름 : ${member.name}
	</div>

	<br>
	<hr>
	<br>

	<div>즐겨듣는 장르</div>
	<div>내 플레이리스트</div>

	<br>
	<hr>
	<br>

	<h3>회원정보수정</h3>
	<form action="${cpath}/update" method="post">
		<div>
			비밀번호 수정 : <input type="password" name="memPw">
		</div>
		<div>
			<button type="submit" class="btn btn-primary btn-sm">수정하기</button>
		</div>
	</form>

	<br>
	<br>

	<h3>회원탈퇴</h3>
	<form action="${cpath}/delete" method="post">
		<button type="submit" class="btn btn-danger btn-sm">탈퇴하기</button>
	</form>
</body>
</html>