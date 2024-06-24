const cpath = document.body.getAttribute('data-cpath');

$.ajax({
	url: `${cpath}/getIntro`,
	type: 'POST',
	dataType: 'json',
	success: function(data) {
		console.log('Success:', data);
		const genreData = data.genre_data;
		const emotionData = data.emotion_data;
		const topSongsByGenre = data.top_songs_by_genre;
		const topSongsByEmotion = data.top_songs_by_emotion;

		// Extract genre labels and counts
		const genreLabels = genreData.map(item => item.surDesc);
		const genreCounts = genreData.map(item => item.count);

		// Extract emotion labels and counts
		const emotionLabels = emotionData.map(item => item.surDesc);
		const emotionCounts = emotionData.map(item => item.count);

		// Destroy existing ge	nre chart if it exists
		let chartStatus = Chart.getChart('genreChart');
		if (chartStatus !== undefined) {
			chartStatus.destroy();
		}
		// Create genre chart
		const genreCtx = document.getElementById('genreChart').getContext('2d');
		new Chart(genreCtx, {
			type: 'bar',
			data: {
				labels: genreLabels,
				datasets: [{
					label: '',
					data: genreCounts,
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
				plugins: {
					legend: {
						display: false
					},
				},
				responsive: false,
				maintainAspectRatio: false,
				animation: {
					duration: 0
				},
				scales: {
					x: {
						ticks: {
							color: 'white'
						}
					},
					y: {
						ticks: {
							color: 'white'
						}
					}
				}
			}
		});

		// Destroy existing emotion chart if it exists
		let emotionChartStatus = Chart.getChart('emotionChart');
		if (emotionChartStatus !== undefined) {
			emotionChartStatus.destroy();
		}

		// Create emotion chart
		const emotionCtx = document.getElementById('emotionChart').getContext('2d');
		new Chart(emotionCtx, {
			type: 'bar',
			data: {
				labels: emotionLabels,
				datasets: [{
					label: '',
					data: emotionCounts,
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
				plugins: {
					legend: {
						display: false
					},
				},
				responsive: false,
				maintainAspectRatio: false,
				animation: {
					duration: 0
				},
				scales: {
					x: {
						ticks: {
							color: 'white'
						}
					},
					y: {
						ticks: {
							color: 'white'
						}
					}
				}
			}
		});
		// Display top songs by genre
		const topSongsByGenreDiv = $('#topSongsByGenre');
		topSongsByGenreDiv.empty();

		for (let genre in topSongsByGenre) {
			const borderDiv = $('<div>').addClass('introTopSongs');
			topSongsByGenreDiv.append(borderDiv);

			let genreHeader = $('<h5>').text(`${genre} Top 3`).addClass('introTopSongTxt');
			borderDiv.append(genreHeader);

			let genreList = $('<ul>').addClass('pink-text'); // Adding class for pink text
			topSongsByGenre[genre].forEach(song => {
				let listItem = $('<li>').text(`${song.title} - ${song.artist}`);
				genreList.append(listItem);
			});
			borderDiv.append(genreList);
		}

		const topSongsByEmotionDiv = $('#topSongsByEmotion');
		topSongsByEmotionDiv.empty();

		if (!topSongsByEmotion || Object.keys(topSongsByEmotion).length === 0) {
			let noSongsMessage = $('<p>').text('No playlist available yet.').addClass('pink-text'); // Adding class for pink text
			topSongsByEmotionDiv.append(noSongsMessage);
		} else {
			for (let emotion in topSongsByEmotion) {
				const borderDiv = $('<div>').addClass('introTopSongs');
				topSongsByEmotionDiv.append(borderDiv);

				let emotionHeader = $('<h5>').text(`${emotion} Top 3`).addClass('introTopSongTxt');
				borderDiv.append(emotionHeader);

				let emotionList = $('<ul>').addClass('pink-text'); // Adding class for pink text
				topSongsByEmotion[emotion].forEach(song => {
					let listItem = $('<li>').text(`${song.title} - ${song.artist}`);
					emotionList.append(listItem);
				});
				borderDiv.append(emotionList);
			}
		}
	},
	error: function(xhr, status, error) {
		console.error('AJAX request failed:', status, error);
		console.error('Response:', xhr.responseText);
	}
});
