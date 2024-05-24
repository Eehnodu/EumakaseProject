<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<div>
	회원 이름 : ${member.memName}
	</div>
	
	<h1>회원정보수정</h1>
	<form action="${cpath}/update" method="post">
		<div>
		비밀번호 수정 : <input type="password" name="memPw">
		</div>
		<div>
			<button type="submit">수정하기</button>
		</div>
	</form>
	 
	<h1>회원탈퇴</h1>
	<form action="${cpath}/delete" method="post">
		<button type="submit">탈퇴하기</button>
	</form>
</body>
</html>