//<div class="search-input">
//	<form id="search" action="#">
//		<input type="text" placeholder="Type Something" id='searchText'
//			name="searchKeyword" onkeypress="handle" /> <i
//				class="fa fa-search"></i>
//	</form>
//</div>

const searchInput = document.getElementById('searchText');
const searchbtn = document.querySelector('.fa-search');

$(document).ready(function() {
	$("#searchText").on('keydown', function(inputkey) {
		if (inputkey.key === 'Enter') {
			inputkey.preventDefault(); // 폼 전송을 막습니다.
			$("#search").submit();
		}
	});

	$("#searchText").on('input', function() {
		let keyword = $(this).val();
		console.log(keyword);

		$.ajax({
			url: `try`,
			data: { keyword: keyword },
			success: function(musiclist) {
				console.log(musiclist);
				displaySearchResults(musiclist);
			},
			error: function() {
				console.error('검색 요청 실패');
			}
		});
	});

	function displaySearchResults(data) {
		var $resultList = $('#search-results');
		$resultList.empty();

		var html = '';
		$.each(data, function(index, item) {
			var $img = $('<img>').attr('src', item.albumCov)
				.addClass('mr-2')
				.css('max-width', '50px');
			html += '<li class="search-result-item">' +
				'  <a class="search-result-link" id="search-result-link" href="songDetail?musicIdx=' + item.musicIdx + '">' +
				'    ' + $img[0].outerHTML +
				'    <div class="search-result-text">' +
				'      <span class="searchTitle" title="' + item.title + '">' + item.title + '</span>' +
				'      <span class="searchArtist" title="' + item.artist + '">' + item.artist + '</span>' +
				'    </div>' +
				'  </a>' +
				'</li>';
		});

		$resultList.prepend(html);
	}

	$('#searchText').on('keydown', function(e) {
		var $links = $('#search-results .search-result-link');
		var $active = $links.filter('.active');
		var index = $links.index($active);

		switch (e.key) {
			case 'ArrowDown':
				e.preventDefault();
				if (index < $links.length - 1) {
					index++;
					$active.removeClass('active');
					$links.eq(index).addClass('active');
				} else if (index === 0) {
					$links.eq(index).addClass('active');
				}
				break;
			case 'ArrowUp':
				e.preventDefault();
				if (index > 0) {
					index--;
					$active.removeClass('active');
					$links.eq(index).addClass('active');
				}
				break;
			case 'Enter':
				e.preventDefault();
				if (index >= 0) {
					window.location.href = $links.eq(index).attr('href');
				}
				break;
		}
	});

	$(document).on('click', '.search-result-link', function() {
		$('#search-results .search-result-link').removeClass('active');
		$(this).addClass('active');
	});

	document.getElementById('search-icon').addEventListener('click', function() {
		document.getElementById('search').submit();
	});
});

document.addEventListener("DOMContentLoaded", function() {
	var searchResultItem = document.getElementById("search-result-item");
	var searchResults = document.getElementById("search-results");

	if (searchResultItem && searchResults) {
		var width = searchResultItem.offsetWidth;
		searchResults.style.width = width + "px";
	}
});