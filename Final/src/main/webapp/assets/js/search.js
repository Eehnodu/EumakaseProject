//<div class="search-input">
//	<form id="search" action="#">
//		<input type="text" placeholder="Type Something" id='searchText'
//			name="searchKeyword" onkeypress="handle" /> <i
//				class="fa fa-search"></i>
//	</form>
//</div>
const cpath = document.body.getAttribute('data-cpath');

const searchInput = document.getElementById('searchText');
const searchbtn = document.querySelector('.fa-search');

$(document).ready(function() {

	$("#searchText").on('input', function(inpuykey) {
		if (inpuykey.key === 'Enter'){
			$("#search").submit()
		}
		
		let keyword = $(this).val();
		console.log(keyword)

		$.ajax({
			url: `try`,
			data: { keyword: keyword },
			success: function(musiclist) {
				console.log(musiclist)
				displaySearchResults(musiclist);
			},
			error: function() {
				console.error('검색 요청 실패');
			}
		});


	})

	function displaySearchResults(data) {
		// 검색 결과 ul 요소 선택
		var $resultList = $('#search-results');
		
		$resultList.empty();

		// 새로운 검색 결과 HTML 생성
		var html = '';
		$.each(data, function(index, item) {
			var $img = $('<img>').attr('src', item.albumCov)
				.addClass('mr-2')
				.css('max-width', '50px');
			html += '<li class="search-result-item">' +
				'  <a class="search-result-link" href="songDetail?musicIdx='+item.musicIdx+'">' +
				'    ' + $img[0].outerHTML + item.title +' '+item.artist+
				'  </a>' +
				'</li>';
		});

		// 검색 결과 HTML을 ul 요소의 맨 앞에 추가
		$resultList.prepend(html);
	}









});
