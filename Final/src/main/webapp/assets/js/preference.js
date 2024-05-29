// 다른 라이브러리와의 충돌 방지
let $jq = jQuery.noConflict();

$(document).ready(function() {
	$("#btnPref").click(function(event) {
		event.preventDefault(); // 폼의 기본 제출 동작을 방지

		$jq.ajax({
			url: `${cpath}/joinProcess`, // 요청을 보낼 서버의 URL
			type: "post", // HTTP 요청 방식
			data: $("form").serialize(), // 폼 데이터 직렬화
			success: function(response) {
				// 요청이 성공했을 때 실행될 함수
				// 서버로부터 받은 응답 데이터를 'prefSurvey' 요소에 삽입
				$("#prefSurvey").html("<div>선호도 조사<br><button type='button' class='btn btn-primary btn-sm' id='btnComplete'>가입 완료</button></div>");
				// 가입 완료 버튼 클릭 시 '/mypage'로 리디렉션
				$("#btnComplete").click(function() {
					window.location.href = "main";
				});

			},
			error: function(xhr, status, error) {
				// 요청이 실패했을 때 실행될 함수
				alert("에러 발생: " + error);
			}
		});
	});
});

