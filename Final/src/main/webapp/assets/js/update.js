
// 엔터를 눌렀었을 때 다음 입력란으로 이동
$(document).ready(function() {
	$('input').keydown(function(event) {
		if (event.keyCode === 13) { // Enter 키 코드
			event.preventDefault(); // 기본 Enter 동작 방지
			let inputs = $('input'); // 모든 input 필드 선택
			let currentIndex = inputs.index(this); // 현재 input 필드의 인덱스

			if (this.name === 'newPw') {
				// 새 비밀번호 입력 필드에서 엔터를 누른 경우
				$('#btnUpdateSmt').click(); // 수정하기 버튼 클릭
			} else if (this.name === 'memPw') {
				// 비밀번호 입력 필드에서 엔터를 누른 경우
				$('#btnDeleteSmt').click(); // 탈퇴하기 버튼 클릭
			} else {
				let nextIndex = currentIndex + 1; // 다음 input 필드의 인덱스
				if (nextIndex < inputs.length) {
					inputs.eq(nextIndex).focus(); // 다음 입력 필드에 포커스
				}
			}
		}
	});
});


// input 모두 입력해야 버튼 활성화
$(document).ready(function() {
	 function toggleUpdateButton() {
        let oldPw = $('input[name="oldPw"]').val();
        let newPw = $('input[name="newPw"]').val();
        if (oldPw && newPw) {
            $('#btnUpdateSmt').removeAttr('disabled');
        } else {
            $('#btnUpdateSmt').attr('disabled', 'disabled');
        }
    }

    $('input[name="oldPw"], input[name="newPw"]').on('input', toggleUpdateButton);
});


$(document).ready(function() {
    // 페이지 로드 시 'btnDeleteSmt' 버튼 비활성화
    $('#btnDeleteSmt').attr('disabled', 'disabled');

    // 사용자가 'memPw' 입력 필드에 텍스트를 입력할 때 이벤트 핸들러 실행
    $('input[name="memPw"]').on('input', function() {
        // 입력 필드에 값이 있을 경우
        if ($(this).val()) {
            $('#btnDeleteSmt').removeAttr('disabled');
        } else {
            // 입력 필드가 비어있을 경우 버튼을 다시 비활성화
            $('#btnDeleteSmt').attr('disabled', 'disabled');
        }
    });
});