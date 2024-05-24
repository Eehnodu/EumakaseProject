<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="${cpath}/join" method="post">
		<div>
			아이디 : <input type="text" name="memId">
		</div>
		<div>
			비밀번호 : <input type="password" name="memPw">
		</div>
		<div>
			이름 : <input type="text" name="memName">
		</div>
		<div>
			<button type="submit">회원가입</button>
		</div>
	</form>
	<h1>로그인</h1>
	<form action="${cpath}/login" method="post">
		<div>
			아이디 : <input type="text" name="memId">
		</div>
		<div>
			비밀번호 : <input type="password" name="memPw">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
	</form>
</body>
</html>