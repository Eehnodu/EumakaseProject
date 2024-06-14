/**
 * loadMore 
 */
$(document).ready(function() {
	// 처음 4개의 .item 요소만 보여줌
	$(".item").slice(0, 4).show();

	// 더보기 버튼 클릭 이벤트 핸들러
	$("#loadMore a").on("click", function(e) {
		e.preventDefault();

		// 현재 숨겨진 모든 .item 요소를 슬라이드 다운하여 보여줌
		$(".item:hidden").slideDown("slow", function() {
			// 애니메이션 완료 후 더보기 버튼 위치로 부드럽게 스크롤
			window.scrollTo({
				top: $('#loadMore').offset().top,
				behavior: 'smooth'
			});
		});

		// 더 이상 숨겨진 .item 요소가 없다면 버튼 텍스트 변경 및 클래스 추가
		if ($(".item:hidden").length == 0) {
			$("#loadMore a")
				.text("맨 처음으로")
				.addClass("noContent")
				.off("click") // 기존 클릭 이벤트 제거
				.on("click", function(e) {
					e.preventDefault();
					window.scrollTo({ top: 0, behavior: 'smooth' });
				});
		}
	});
});
