const ipath = document.body.getAttribute('data-cpath');

$.ajax({
	url: `${ipath}/getIntro`,
	type: 'POST',
	dataType: 'json',
	success: function(data) {
		console.log('Data received:', data);
		console.log('Genre labels:', data.genre_labels);
		console.log('Emotion labels:', data.emotion_labels);

		let chartStatus = Chart.getChart('genreChart');
		if (chartStatus !== undefined) {
			chartStatus.destroy();
		}

		// Genre chart
		const genreCtx = document.getElementById('genreChart').getContext('2d');
		new Chart(genreCtx, {
			type: 'bar',
			data: {
				labels: data.genre_labels,
				datasets: [{
					label: 'Genre Count',
					data: data.genre_counts,
					backgroundColor: [
						'rgb(205, 180, 219)',
						'rgb(255, 200, 221)',
						'rgb(255, 175, 204)',
						'rgb(189, 224, 254)',
						'rgb(162, 210, 255)'
					],
					borderColor: [
						'rgb(205, 180, 219)',
						'rgb(255, 200, 221)',
						'rgb(255, 175, 204)',
						'rgb(189, 224, 254)',
						'rgb(162, 210, 255)'
					],
					borderWidth: 1
				}]
			},
			options: {
				responsive: false,
				maintainAspectRatio: false,
				animation: {
					duration: 0
				}
			}
		});

		let emotionChartStatus = Chart.getChart('emotionChart');
		if (emotionChartStatus !== undefined) {
			emotionChartStatus.destroy();
		}
		// Emotion chart
		const emotionCtx = document.getElementById('emotionChart').getContext('2d');
		new Chart(emotionCtx, {
			type: 'bar',
			data: {
				labels: data.emotion_labels,
				datasets: [{
					label: 'Emotion Count',
					data: data.emotion_counts,
					backgroundColor: [
						'rgb(205, 180, 219)',
						'rgb(255, 200, 221)',
						'rgb(255, 175, 204)',
						'rgb(189, 224, 254)',
						'rgb(162, 210, 255)'
					],
					borderColor: [
						'rgb(205, 180, 219)',
						'rgb(255, 200, 221)',
						'rgb(255, 175, 204)',
						'rgb(189, 224, 254)',
						'rgb(162, 210, 255)'
					],
					borderWidth: 1
				}]
			},
			options: {
				responsive: false,
				maintainAspectRatio: false,
				animation: {
					duration: 0
				}
			}
		});

		// Top songs by genre
		const topSongsByGenreDiv = $('#topSongsByGenre');
		topSongsByGenreDiv.empty();
		for (let genre in data.top_songs_by_genre) {
			let genreHeader = $('<h3>').text(`${genre} - Top Songs`);
			topSongsByGenreDiv.append(genreHeader);

			let genreList = $('<ul>');
			data.top_songs_by_genre[genre].forEach(song => {
				let listItem = $('<li>').text(song);
				genreList.append(listItem);
			});
			topSongsByGenreDiv.append(genreList);
		}
		consolelog(topSongsByGenreDiv)
		consolelog(topSongsByEmotionDiv)
		// Top songs by emotion (initially hidden)
		const topSongsByEmotionDiv = $('#topSongsByEmotion');
		topSongsByEmotionDiv.empty();
		for (let emotion in data.top_songs_by_emotion) {
			let emotionHeader = $('<h3>').text(`${emotion} - Top Songs`);
			topSongsByEmotionDiv.append(emotionHeader);

			let emotionList = $('<ul>');
			data.top_songs_by_emotion[emotion].forEach(song => {
				let listItem = $('<li>').text(song);
				emotionList.append(listItem);
			});
			topSongsByEmotionDiv.append(emotionList);
		}
	},
	error: function(xhr, status, error) {
		console.error('AJAX request failed:', status, error);
	}
});
