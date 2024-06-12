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
	swalWithBootstrapButtons.fire({
		title: "정말 변경할까요?",
		text: "이름좀 잘 지어주세요.",
		icon: "warning",
		showCancelButton: true,
		confirmButtonText: "예쓰! 변경해!",
		cancelButtonText: "안돼! 취소해!",
		reverseButtons: true
	}).then((result) => {
		if (result.isConfirmed) {

			newPlaylistName = $("#newPlaylistName").val()
			nowplyIdx = $("#nowplyIdx").val()
			
			console.log("들어온정보들은")
			console.log(newPlaylistName)
			console.log(nowplyIdx)
			
			$.ajax({
				type: 'post',
				url: `updateMyPlayList`,
				data: {
					newPlaylistName: newPlaylistName,
					myplIdx: nowplyIdx
				},
				success: function() {
					$(".btn-close").click()
					$("#newPlaylistName").val(null)
					$("#playlist").html(newPlaylistName)

					swalWithBootstrapButtons.fire({
						title: "변경!",
						text: `플레이리스트 이름이 "${newPlaylistName}" 으로 변경되었습니다.`,
						icon: "success"
					});

				}, error: (e) => {
					console.log("서브밋버튼실패")
				}
			})

		} else if (
			/* Read more about handling dismissals below */
			result.dismiss === Swal.DismissReason.cancel
		) {
			swalWithBootstrapButtons.fire({
				title: "취소",
				text: `당신의 플레이리스트 "${playlist}" 는 안전합니다 :)`,
				icon: "error"
			});
		}
	});
});


$(".btn-delete").on("click", function() {
	swalWithBootstrapButtons.fire({
		title: "정말 삭제할까요?",
		text: "데이터는 복구되지 않습니다.",
		icon: "warning",
		showCancelButton: true,
		confirmButtonText: "예쓰! 삭제해!",
		cancelButtonText: "안돼! 취소해!",
		reverseButtons: true
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
						title: "삭제!",
						text: `플레이리스트 가 삭제되었습니다.`,
						icon: "success"
					});
					$(".btn-success").on("click",()=>{
						window.location.href = 'mypage'
					})
				}, error: (e) => {
					console.log("서브밋버튼실패")
				}
			})

		} else if (
			/* Read more about handling dismissals below */
			result.dismiss === Swal.DismissReason.cancel
		) {
			swalWithBootstrapButtons.fire({
				title: "취소",
				text: `당신의 플레이리스트는 안전합니다 :)`,
				icon: "error"
			});
		}
	});
})

$("#plyinsert").on("click", ()=>{
	console.log("저장쌉가능?")
});
