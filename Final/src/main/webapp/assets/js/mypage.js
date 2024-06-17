$(document).ready(function() {
	// 차트 데이터를 로딩하는 함수
	function loadChartData() {
		// 차트 데이터 로딩 시작 시 프리로더 표시
		$('#js-preloader2').css('visibility', 'visible').css('opacity', '1');

		// 예시로 setTimeout을 사용하여 비동기 데이터 로드를 시뮬레이션
		setTimeout(function() {
			// 차트 데이터 로딩이 완료되면 프리로더 숨김
			$('#js-preloader2').animate({
				'opacity': '0'
			}, 600, function() {
				$('#js-preloader2').css('visibility', 'hidden');
			});
		}, 3000); // 3초 후에 데이터 로딩 완료
	}

	// 페이지 로딩 후 차트 데이터 로딩
	loadChartData();
});