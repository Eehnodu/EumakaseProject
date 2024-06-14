const swalWithBootstrapButtons = Swal.mixin({
	customClass: {
		confirmButton: "btn btn-success",
		cancelButton: "btn btn-danger"
	},
	buttonsStyling: false
});

let newPlaylistName;
let nowplyIdx;
let playlist = $("#playlist").text();

$("#submitbotton").on("click", function() {
	const newPlaylistName = $("#newPlaylistName").val();
	const nowplyIdx = $("#nowplyIdx").val();

	$.ajax({
		type: 'post',
		url: `updateMyPlayList`,
		data: {
			newPlaylistName: newPlaylistName,
			myplIdx: nowplyIdx
		},
		success: function() {
			$(".btn-close").click();
			$("#newPlaylistName").val(null);
			$("#playlist").html(newPlaylistName);

			Swal.fire({
				html: `플레이리스트 이름이<br> "${newPlaylistName}"(으)로 변경되었습니다.`,
				confirmButtonText: "확인",
				icon: "success"
			});

		}, error: (e) => {
			Swal.fire({
				title: "오류",
				text: "플레이리스트 이름 변경에 실패했습니다.",
				icon: "error"
			});
			console.log("서브밋 버튼 실패");
		}
	});
});

function showCancelAlert() {
	Swal.fire({
		title: "취소",
		text: `당신의 플레이리스트는 안전합니다 :)`,
		icon: "error"
	});
}

$(".btn-delete").on("click", function() {
	swalWithBootstrapButtons.fire({
		text: "정말 삭제할까요?",
		icon: "warning",
		showCancelButton: true,
		confirmButtonText: "삭제",
		cancelButtonText: "취소",
	}).then((result) => {
		if (result.isConfirmed) {

			nowplyIdx = $("#nowplyIdx").val()
			console.log(nowplyIdx)
			$.ajax({
				type: 'post',
				url: `deleteMyPlayList`,
				data: {
					myplIdx: nowplyIdx
				},
				success: function() {

					swalWithBootstrapButtons.fire({
						text: `플레이리스트가 삭제되었습니다.`,
						confirmButtonText: "확인",
						icon: "success"
					});
					$(".btn-success").on("click", () => {
						window.location.href = 'mypage'
					})
				}, error: (e) => {
					console.log("서브밋버튼실패")
				}
			})

		}
	});
})

$(".btn.btn-primary").on("click", function() {
	console.log("저장쌉가능?")
	swalWithBootstrapButtons.fire({
		html: `${playlist}(을)를<br> 저장할까요?`,
		icon: "warning",
		showCancelButton: true,
		confirmButtonText: "저장",
		cancelButtonText: "취소",
	}).then((result) => {
		if (result.isConfirmed) {

			// 현재 URL 가져오기
			var currentUrl = window.location.href;

			// URL에서 "myplIdx=" 다음 값 가져오기
			var urlParams = currentUrl.split("myplIdx=");
			if (urlParams.length > 1) {
				var urlParams = urlParams[1];
				console.log("myplIdx: " + urlParams);
			} else {
				console.log("myplIdx not found in URL");
			}
			nowplyIdx = urlParams


			// 가져온 memId를 이용하여 새로운 AJAX 요청 보내기
			$.ajax({
				type: 'POST',
				url: 'insertCopyPlayList',
				data: {
					myplIdx: nowplyIdx,
					plName: playlist
				},
				success: function() {
					swalWithBootstrapButtons.fire({
						text: `나의 플레이리스트에 저장되었습니다 :)`,
						confirmButtonText: "확인",
						icon: "success"
					});
					$(".btn-success").on("click", () => {
						window.location.href = 'mypage'
					});
				},
				error: (e) => {
					console.log("서브밋버튼실패");
				}
			});


		} 
	});


});