const cpath = document.body.getAttribute('data-cpath');

$(document).ready(function() {
    $('button#redDiff').click(function(event) {
        event.preventDefault(); // 링크 기본 동작 방지

		var value = $(this).attr('value');
        $.ajax({
            type: "post",
            url: `${cpath}/otherPlaylist`, // URL을 적절히 변경하세요
            data : { value: value},
            success: function(data) {
                updatePlaylist(data);
            },
            error: function(e) {
                console.log(e);
            }
        });
    });
});

function formatTimestamp(timestamp) {
    var date = new Date(parseInt(timestamp));
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    return year + '-' + month + '-' + day;
}

function updatePlaylist(musicList) {
    const playlistContainer = $('#playlistList');
    playlistContainer.empty(); // 기존 내용 지우기

    musicList.forEach(function(music) {
        const formattedDate = music.releasedAt === '0001-01-01' ? '-' : formatTimestamp(music.releasedAt);
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
                        <li><h4>${formattedDate}</h4>
                            <span>발매일</span>
                        </li>
                    </ul>
                </div>
            </div>
        `;
        playlistContainer.append(musicItem);
    });
}
