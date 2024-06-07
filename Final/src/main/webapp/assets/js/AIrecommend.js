/**
 * AI가 추천하는 챗봇 페이지
 */
// 시작 인트로
function runQuestionIntro() {
	$('.intro p.first').addClass('loading').append('<i></i>');
	setTimeout(function() {
		$('p.first').removeClass('loading').addClass('is-complete').find('span').fadeIn(300); // 시간을 200ms에서 300ms로 조정
		setTimeout(function() {
			$('p.is-complete').next().addClass('loading').append('<i></i>');
			setTimeout(function() {
				$('p.loading').removeClass('loading').addClass('is-complete').find('span').fadeIn(250); // 시간을 150ms에서 250ms로 조정
				$('.question').first().addClass('active running');
				showQuestionBubble();
			}, 1500); // 시간을 1000ms에서 1500ms로 조정
		}, 900); // 시간을 600ms에서 900ms로 조정
	}, 200); // 초기 지연 시간을 조금 늘림
}

runQuestionIntro();

// 질문에 대한 선택지 표시
function transitionQuestion() {
	setTimeout(function() {
		$('p.loading').removeClass('loading').addClass('is-complete').find('span').fadeIn(300); // 시간을 200ms에서 300ms로 조정
		$('.question.active .confirm-container').fadeIn(300); // 시간을 200ms에서 300ms로 조정
	}, 1500); // 시간을 1000ms에서 1500ms로 조정
}

// 현재 실행중인 질문
function showQuestionBubble() {
	if ($('.question').hasClass('running')) {
		$('.question.running').find('p:first-child').addClass('loading').append('<i></i>');
		transitionQuestion();
	}
}

// 사용자 응답에 따른 답변
$('.confirm-button').one('click', function(e) {
	$(this).addClass('selected');
	$('.confirm-container > div').slideUp(600).fadeOut(600); // 시간을 500ms에서 600ms로 조정
	// 첫 번째 질문 슬라이드 업
	$(this).closest('.question').find('.q-wrap').slideUp(600); // 시간을 500ms에서 600ms로 조정

	// intro 클래스 요소 슬라이드 업 및 페이드 아웃
	$('.intro').slideUp(600).fadeOut(600); // 시간을 500ms에서 600ms로 조정

	// 반응 텍스트 설정 및 애니메이션
	var responseText = $(this).data('response');
	$(this).closest('.question').find('.response').addClass('is-complete').text(responseText);

	// 다른 버튼들 페이드 아웃
	$(this).siblings('.confirm-button').fadeOut(300); // 시간을 150ms에서 300ms로 조정

	$(this).closest('.question').removeClass('running').next().addClass('active running');
	showQuestionBubble();
});

// 결과 표시
function showResultBubble() {
	if ($('.result').hasClass('running')) {
		$('.result.running').find('p:first-child').addClass('loading').append('<i></i>');
		transitionQuestion();
	}
}

// 값 클릭후 넘기기
let selectedResponses = [];

function addResponse(response) {
    selectedResponses.push(response);
}

function goToPlaylistDetail() {
    const params = selectedResponses.map(response => `response=${encodeURIComponent(response)}`).join('&');
    window.location.href = `playlistDetail?${params}`;
}
