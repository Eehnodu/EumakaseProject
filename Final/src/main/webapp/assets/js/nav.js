document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMContentLoaded 이벤트 발생");

    let navMenu = document.querySelectorAll(".nav a");

    // 페이지 로드 시 Local Storage에 저장된 링크 ID가 있는지 확인하고 .pink 클래스 추가
    let savedLinkId = localStorage.getItem("selectedLinkId");
    if (savedLinkId) {
        let savedLink = document.getElementById(savedLinkId);
        if (savedLink) {
            savedLink.classList.add("pink");
        }
    } else {
        // Local Storage에 저장된 값이 없으면 Intro에 기본으로 설정된 .pink 제거
        let introLink = document.querySelector(".nav a.pink");
        if (introLink) {
            introLink.classList.remove("pink");
        }
    }

    navMenu.forEach(function(link, index) {
        console.log(`이벤트 리스너 추가: ${index}`);
        link.addEventListener("click", function(event) {
            event.preventDefault(); // 기본 동작 중지

            console.log(`클릭된 링크: ${link.id}`);

            navMenu.forEach(function(nav, navIndex) {
                console.log(`핑크 제거: ${nav.id}`);
                nav.classList.remove("pink");
            });

            console.log(`핑크 추가: ${link.id}`);
            this.classList.add("pink");

            // 클릭된 링크의 ID를 Local Storage에 저장
            localStorage.setItem("selectedLinkId", this.id);

            // 링크의 기본 동작 수행
            if (this.getAttribute('href')) {
                window.location.href = this.getAttribute('href');
            }
        });
    });

    // 로그인 버튼 클릭 시 Local Storage에서 selectedLinkId 삭제
    let btnLogin = document.getElementById("btnLogin");
    if (btnLogin) {
        btnLogin.addEventListener("click", function() {
            console.log("로그인 버튼 클릭됨, selectedLinkId 삭제");
            localStorage.removeItem("selectedLinkId");
        });
    }
});

// 프로필버튼 이름 길이만큼 늘리기
document.addEventListener('DOMContentLoaded', function() {
	let nameWidth = document.getElementById('memberName').offsetWidth;
	document.getElementById('profileDropdown').style.width = nameWidth + 40 + 'px';
});
