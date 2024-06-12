const cpath = document.body.getAttribute('data-cpath');

$(document).ready(function() {
    $('#redDiff').click(function(event) {
        event.preventDefault(); // 링크 기본 동작 방지

        $.ajax({
            type: "post",
            url: `${cpath}/otherPlaylist`, // URL을 적절히 변경하세요
            success: function(data) {
                updatePlaylist(data);
            },
            error: function(e) {
                console.log(e);
            }
        });
    });
});

function updatePlaylist(musicList) {
    const playlistContainer = $('#playlistList');
    playlistContainer.empty(); // 기존 내용 지우기

    musicList.forEach(function(music) {
        const musicItem = `
            <div class="col-lg-12 playlist">
                <div class="item songDetail" style="display:block;">
                    <ul>
                        <li><img src="${music.albumCov}" alt="" class="templatemo-item"></li>
                        <li>
                            <h4 class="songTitle">${music.title}</h4>
                            <span>${music.artist}</span>
                        </li>
                        <li>
                            <h4 class="albumTitle">${music.album}</h4>
                            <span>앨범명</span>
                        </li>
                        <li>
                            <h4>${music.genre}</h4>
                            <span>장르</span>
                        </li>
                        <li>${music.releasedAt === '0001-01-01' ? '<h4>-</h4>' : '<h4>' + music.releasedAt + '</h4>'}
                            <span>발매일</span>
                        </li>
                    </ul>
                </div>
            </div>
        `;
        playlistContainer.append(musicItem);
    });
}
