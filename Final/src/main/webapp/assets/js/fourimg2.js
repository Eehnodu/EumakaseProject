/**
 * 두 번쨰 페이지 이미지 
 */
document.addEventListener('DOMContentLoaded', function() {
	// 세션 스토리지에서 이미지 정보 불러오기
	const imageSources = JSON.parse(sessionStorage.getItem('imageSources'));

	if (imageSources && imageSources.length > 0) {
		const container = document.querySelector('.col-lg-3');
		if (container) {
			// 기존에 있는 이미지 태그는 모두 삭제
			container.innerHTML = '';

			// 이미지 컨테이너 생성
			const imageGrid = document.createElement('div');
			imageGrid.classList.add('image-grid');
			container.appendChild(imageGrid);

			// 각 이미지 소스에 대해 이미지를 생성하여 추가
			imageSources.forEach(src => {
				const thumbDiv = document.createElement('div');
				thumbDiv.classList.add('thumb');

				const newImg = document.createElement('img');
				newImg.src = src;
				newImg.alt = "";

				thumbDiv.appendChild(newImg);
				imageGrid.appendChild(thumbDiv);
			});
		} else {
			console.error("Container element not found");
		}
	} else {
		console.error("No image sources found in session storage");
	}
});
