/**
 * like 좋아요 - ID와 for 자동으로 증가하는 js코드
 */
document.addEventListener('DOMContentLoaded', () => {
    const heartList = document.getElementById('heartList');

    for (let i = 1; i <= 10; i++) { // 원하는 수만큼 반복
        const li = document.createElement('li');
        li.classList.add('heartbox');

        const checkbox = document.createElement('input');
        checkbox.type = 'checkbox';
        checkbox.classList.add('checkbox');
        checkbox.id = `checkbox${i}`;

        const label = document.createElement('label');
        label.setAttribute('for', `checkbox${i}`);

        // SVG 코드를 추가합니다.
        label.innerHTML = `
            <svg viewBox="0 0 52 52">
                <circle id="main-circ" class="circle" cx="26" cy="26" r="25" fill="none" stroke="#000" stroke-width="2"/>
                <path id="heart" class="heart" d="M24.5,32.5c0,0-5.5-4-8-7.5c-2.5-3.5-4-7.5-2-12c2-4.5,7-6.5,10.5-4.5c3.5-2,8.5,0,10.5,4.5c2,4.5,0.5,8.5-2,12C30,28.5,24.5,32.5,24.5,32.5z"/>
                <!-- 다른 SVG 요소들 추가 -->
            </svg>
        `;

        li.appendChild(checkbox);
        li.appendChild(label);
        heartList.appendChild(li);
    }
});
