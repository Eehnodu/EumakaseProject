document.addEventListener('DOMContentLoaded', function() {
    // 이미지 정보를 배열에 저장
    let imageSources = [];
    document.querySelectorAll('.image-grid .thumb img').forEach(img => {
        imageSources.push(img.src);
    });

    // 세션 스토리지에 이미지 정보 저장
    sessionStorage.setItem('imageSources', JSON.stringify(imageSources));
});
