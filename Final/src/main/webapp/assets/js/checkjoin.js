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
	// 입력 필드의 값 확인
	let name = $("input[name='name']").val().trim();
	let gender = $("#genderInput").val().trim();
	let birth = $("input[name='birth']").val().trim();

	// 모든 조건이 충족되었는지 확인
	if (idChecked && pwChecked && name && gender && birth) {
		$("#btnPref").removeAttr("disabled");
		$("#btnPref").off("click").on("click", function(e) {
			e.preventDefault();


			$.ajax({
				url: `${cpath}/joiningProcess`,
				type: "post",
				data: $("form").serialize(),
				success: function(response) {


					$.ajax({
						url: `${cpath}/joiningSurvey`,
						type: "post",
						success: function(result) { // 결과 성공 콜백함수
							console.log(result[0]);
							console.log(result[0].surType);
							console.log("여기오냐?");

							// 선언된 변수에 초기 HTML 구조를 설정합니다.
							let htmlContent = `
            <div>
                선호도 조사
                <br>
                질문을 박으세요!
                <br>
                <form id="toggleForm" onsubmit="handleSubmit(event)">
        `;

							// result 배열을 반복하여 각 요소에 대한 버튼을 추가합니다.
							result.forEach((item, index) => {
								htmlContent += `
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="button" aria-pressed="false">
                    ${item.surDesc}
                </button>
            `;
							});

							// 폼 마감 태그와 추가 버튼을 문자열에 추가합니다.
							htmlContent += `
							<br>
                <button type="submit" class="btn btn-success mt-3">Submit</button>
                </form>
                <button type='button' class='btn btn-primary btn-sm' id='btnComplete'>가입 완료</button>
            </div>
        `;

							// 최종적으로 구성된 HTML 문자열을 #prefSurvey에 설정합니다.
							$("#prefSurvey").html(htmlContent);
						},
						error: function(xhr, status, error) {
							console.error('AJAX request failed:', status, error);
						}
					});



					$("#btnComplete").click(function() {
						window.location.href = "main";
					});
				},
				error: function(xhr, status, error) {
					alert("에러 발생: " + error);
				}
			});
		});
	} else {
		$("#btnPref").attr("disabled", "disabled");
	}
}


function handleSubmit(event) {
	event.preventDefault();  // 폼의 기본 제출 동작을 막음

	const buttons = $('button[data-bs-toggle="button"]');
	const activeButtons = buttons.filter('.active').map(function() {
		return $(this).text().trim();
	}).get();

	const formData = {};
	activeButtons.forEach((buttonText, index) => {
		formData[`button${index + 1}`] = buttonText;
	});

	$.ajax({
		url: '/joiningProcess',
		type: 'POST',
		data: formData,
		success: function(response) {
			console.log('Success:', response);
		},
		error: function(xhr, status, error) {
			console.error('Error:', error);
		}
	});
}









// 실시간으로 입력 필드의 변경사항을 감지하여 버튼 활성화 여부를 결정
$("input[name='name'], input[name='birth'], #genderInput").on("change keyup", completeJoin);



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

