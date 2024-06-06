
// 프로필버튼 이름 길이만큼 늘리기
document.addEventListener('DOMContentLoaded', function() {
	let memberName = document.getElementById('memberName');

	// memberName 요소가 존재하는지 확인
	if (memberName) {
		// memberName의 길이 가져오기
		let nameWidth = memberName.offsetWidth;
		document.getElementById('profileDropdown').style.width = nameWidth + 40 + 'px';
	}
});


// 네비바 메뉴색 변경
window.onload = function() {
	// URL을 검사하여 현재 페이지가 'mainPage'인지 확인
	if (window.location.href.endsWith("mainPage")) {
		// 모든 'nav-link' 클래스를 가진 요소를 찾아서 'active' 클래스 제거
		document.querySelectorAll('.nav-link').forEach(function(link) {
			link.classList.remove('active');
		});
		// 'navHome' 요소에 'active' 클래스 추가
		let navHome = document.getElementById("navHome");
		if (navHome) {
			navHome.classList.add('active');
		}
		// URL을 검사하여 현재 페이지가 'mypage'인지 확인
	} else if (window.location.href.endsWith("mypage")){
		// 모든 'nav-link' 클래스를 가진 요소를 찾아서 'active' 클래스 제거
		document.querySelectorAll('.nav-link').forEach(function(link) {
			link.classList.remove('active');
		});
		// 'navMypage' 요소에 'active' 클래스 추가
		let navMypage = document.getElementById("navMypage");
		if (navMypage) {
			navMypage.classList.add('active');
		}
		// URL을 검사하여 현재 페이지가 'AIrecommend'인지 확인
	} else if (window.location.href.endsWith("AIrecommend")) {
		// 모든 'nav-link' 클래스를 가진 요소를 찾아서 'active' 클래스 제거
		document.querySelectorAll('.nav-link').forEach(function(link) {
			link.classList.remove('active');
		});
		// 'navAi' 요소에 'active' 클래스 추가
		let navAi = document.getElementById("navAi");
		if (navAi) {
			navAi.classList.add('active');
		}
	} 
};
