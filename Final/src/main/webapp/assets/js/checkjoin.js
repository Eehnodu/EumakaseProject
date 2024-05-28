// 엔터를 눌렀었을 때 다음 입력란으로 이동
$(document).ready(function() {
    $('input').keydown(function(event) {
        if (event.keyCode === 13) { // Enter 키 코드
            event.preventDefault(); // 기본 Enter 동작 방지
            let inputs = $('input'); // 모든 input 필드 선택
            let currentIndex = inputs.index(this); // 현재 input 필드의 인덱스
            let nextIndex = currentIndex + 1; // 다음 input 필드의 인덱스

            if (this.name == 'memId') {
                // 현재 입력 필드의 ID가 'userId'인 경우
                $('#btnCheckId').click(); // 중복 확인 버튼에 포커스
            } else if (nextIndex < inputs.length) {
                inputs.eq(nextIndex).focus(); // 다음 입력 필드에 포커스
            } else {
                // 마지막 입력 필드에서 엔터를 누른 경우
                $('#btnPref').focus(); // 제출 버튼에 포커스
            }
        }
    });
});

// 아이디 중복체크
let idChecked = false;
$('#btnCheckId').click(function() {
	let memId = $('input[name="memId"]').val(); // 아이디 필드에서 값 가져오기

	if (memId == '') {
		alert("아이디를 입력해주세요.");
		return;
	}

	$.ajax({
		type: "post",
		url: `${cpath}/checkId`,
		data: {
			"memId": memId
		},
		success: function(data) {
			// data : checkId에서 넘겨준 결과값
			// 반환된 data 값이 "YES"인 경우
			if (data == "YES") {
				alert("사용 가능한 아이디입니다.");
				idChecked = true; // id체크 true
			} else {
				alert("중복된 아이디입니다.");
				$('input[name="memId"]').focus();
				idChecked = false;
			}
		},
		error: function(xhr, status, error) {
			alert("아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
});


// 비밀번호 확인
let pwChecked = false;
// 비밀번호를 입력한 후 중복검사 실행
$(".pwcheck").focusout(function() {
	checkPw($(this).val())
})
function checkPw(pw) {
	// 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않음
	if (pw == "") {
		$("#checkId").text("");
		return;
	}
	// 만약 pw1과 pw2가 알치하지 않는다면
	if ($('#pw1').val() != $('#pw2').val()) {
		$("#checkPw").html('비밀번호가 일치하지 않습니다');
		$("#checkPw").css('color', 'red');
		$('#pw2').val(''); // 값을 비움
		$('#pw2').focus(); // 포인터를 pw2 로 맞춘다
		pwChecked = false;
	}
	else {
		$("#checkPw").html('비밀번호가 일치합니다'); // 문구 출력
		$("#checkPw").css('color', 'green');
		pwChecked = true; // pw체크 true
	}
	completeJoin();
}


// 아이디,비번 검사 확인 후 가입완료
function completeJoin() {
	console.log("idChecked : " + idChecked + "\npwChecked : " + pwChecked);
	if (idChecked && pwChecked) {
		// 만약 아이디와 비밀번호의 유효성 검사를 마쳤다면
		$("#btnPref").removeAttr("disabled");
	} else {
		$("#btnPref").attr("disabled", "disabled"); // 유효성 검사 실시하지 않았다면 button이 눌려지지 않도록
	}
}


