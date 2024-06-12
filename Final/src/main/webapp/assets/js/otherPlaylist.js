const cpath = document.body.getAttribute('data-cpath');

$(document).ready(function() {
	$('#redDiff').click(function(event) {
		event.preventDefault(); // 링크 기본 동작 방지

		$.ajax({
			type: "post",
			url: `${cpath}/otherPlaylist`, // URL을 적절히 변경하세요
			success: function() {
				updatePlaylist();
				console.log("성공")
			},
			error: function(e) {
				console.log(e);
			}
		});
	});
});

function updatePlaylist() {
	const playlistContainer = $('#right-info');
	playlistContainer.empty(); // 기존 내용 지우기

	const musicItem = `
            <c:forEach var="music" items="${musicList}">
														<div class="col-lg-12 playlist">
															<div class="item songDetail">
																<ul>
																	<li><img src="${music.albumCov}" alt=""
																		class="templatemo-item"></li>
																	<%-- <li>

																		<h4>${music.artist}</h4> <span>가수명</span>
																	</li> --%>
																	<li>
																		<h4 class="songTitle">${music.title}</h4> <span>${music.artist}</span>
																	</li>
																	<li>
																		<h4 class="albumTitle">${music.album}</h4> <span>앨범명</span>
																	</li>
																	<li>
																		<h4>${music.genre}</h4> <span>장르</span>
																	</li>
																	<li><c:choose>
																			<c:when test="${music.releasedAt == '0001-01-01'}">
																				<h4>-</h4>
																			</c:when>
																			<c:otherwise>
																				<h4>${music.releasedAt}</h4>
																			</c:otherwise>
																		</c:choose> <span>발매일</span></li>
																</ul>
															</div>
														</div>

													</c:forEach>`
		playlistContainer.append(musicItem);
}