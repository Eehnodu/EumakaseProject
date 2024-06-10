/**
 * 플레이리스트 전체 항목이 보이도록 하는 기능
 */
$(document).ready(function() {
    // 모든 .songDetail 항목을 보여줌
    $(".songDetail").show();

    // #loadMore 버튼을 클릭했을 때의 이벤트 핸들러를 제거
    $("#loadMore").off("click");
});
