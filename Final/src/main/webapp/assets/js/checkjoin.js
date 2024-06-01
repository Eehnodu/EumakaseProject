const cpath = document.body.getAttribute('data-cpath');


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

$(document).ready(function() {
	$('#btnCheckId').click(function() {
		let memId = $('input[name="memId"]').val(); // 아이디 필드에서 값 가져오기

		if (memId == '') {
			alert("아이디를 입력해주세요.");
			return;
		}

		// 다른 라이브러리와의 충돌 방지
		let $jq = jQuery.noConflict();

		$jq.ajax({
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
				completeJoin();
			},
			error: function(xhr, status, error) {
				alert("아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
				completeJoin();
			}
		});
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
	if (idChecked && pwChecked) {
		// 만약 아이디와 비밀번호의 유효성 검사를 마쳤다면
		$("#btnPref").click(function(e) {
			e.preventDefault(); // 폼의 기본 제출 동작을 방지

			// 다른 라이브러리와의 충돌 방지
			let $jq = jQuery.noConflict();

			$jq.ajax({
				url: `${cpath}/joinProcess`,
				type: "post",
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
	} else {
		$("#btnPref").attr("disabled", "disabled"); // 유효성 검사 실시하지 않았다면 버튼이 눌려지지 않도록
	}
	// 다시 검사 모두 완료되면 버튼 활성화
	if (idChecked && pwChecked) {
		$("#btnPref").removeAttr("disabled");
	}

}

completeJoin();

// 생년월일 8글자 확인
document.getElementById('joinForm').addEventListener('submit', function(e) {
	let inputBirth = document.getElementById('inputBirth').value;
	if (inputBirth.length !== 8) {
		e.preventDefault(); // 폼 제출 방지
		alert('생년월일을 반드시 8글자로 입력해 주세요.');
	}
});


// 드롭다운을 클릭 이벤트로만 활성화
$(document).ready(function() {

    // 드롭다운 메뉴 항목을 클릭했을 때 드롭다운 메뉴 숨기기
    $('.dropdown-item').click(function() {
        $(this).closest('#ddwGdMenu').removeClass('show'); // 드롭다운 메뉴를 숨깁니다.
    });

    // 바깥쪽을 클릭하면 드롭다운 메뉴 숨기기
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.dropdown').length) {
            $('.dropdown-menu').removeClass('show');
        }
    });
});

// 드롭다운으로 선택한 성별을 화면에 보여주기
$(document).ready(function() {
	$('.dropdown-item').click(function() {
		let selectedGender = $(this).text();
		$('#genderPlaceholder').text(selectedGender)
			.css({
				'color': '#c4c3ca',
				'font-weight': '500',
				'font-size': '14px',
				'opacity': '1'
			});
	});
});

// 드롭다운에서 선택한 value 넘겨주기
let genderDropdown = document.getElementById('dropdownGender');
let genderInput = document.getElementById('genderInput');
let genderPlaceholder = document.getElementById('genderPlaceholder');
let genderItems = document.querySelectorAll('.dropdown-item[data-value]');

// 각 성별 옵션 항목에 대해 클릭 이벤트 리스너 등록
genderItems.forEach(function(e) {
	e.addEventListener('click', function() {
		// 클릭한 항목의 data-value 속성 값을 selectedValue 변수에 저장
		let selectedValue = e.dataset.value;
		// 성별 입력 필드의 값을 selectedValue로 설정
		genderInput.value = selectedValue;
	});
});

