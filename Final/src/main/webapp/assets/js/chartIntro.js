const ipath = document.body.getAttribute('data-cpath');

$.ajax({
    url: `${ipath}/getIntro`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('인트로 연결만 성공 인트로');
        console.log(data.genre_labels);
        console.log(data.emotion_labels);

        // 장르 차트
        const genreCtx = document.getElementById('genreChart').getContext('2d');
        new Chart(genreCtx, {
            type: 'bar',
            data: {
                labels: data.genre_labels,
                datasets: [{
                    label: '장르 개수',
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
                responsive: true,
                maintainAspectRatio: false,
                animation: {
                    duration: 0
                }
            }
        });
		console.log('장르차트 완료')
        // 감정 차트
        const emotionCtx = document.getElementById('emotionChart').getContext('2d');
        new Chart(emotionCtx, {
            type: 'bar',
            data: {
                labels: data.emotion_labels,
                datasets: [{
                    label: '감정 개수',
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
                responsive: true,
                maintainAspectRatio: false,
                animation: {
                    duration: 0
                }
            }
        });
		console.log('감정차트 완료')
		console.log(data.emotion_labels)		
        // 장르별 상위 5개의 노래 목록을 표시합니다.
        const topSongsByGenreDiv = document.getElementById('topSongsByGenre');
        topSongsByGenreDiv.innerHTML = '';
        for (let genre in data.top_songs_by_genre) {
            let genreHeader = document.createElement('h3');
            genreHeader.textContent = `${genre} - Top Songs`;
            topSongsByGenreDiv.appendChild(genreHeader);

            let genreList = document.createElement('ul');
            data.top_songs_by_genre[genre].forEach(song => {
                let listItem = document.createElement('li');
                listItem.textContent = song;
                genreList.appendChild(listItem);
            });
            topSongsByGenreDiv.appendChild(genreList);
        }

        // 감정별 상위 5개의 노래 목록을 표시합니다.
        const topSongsByEmotionDiv = document.getElementById('topSongsByEmotion');
        topSongsByEmotionDiv.innerHTML = '';
        for (let emotion in data.top_songs_by_emotion) {
            let emotionHeader = document.createElement('h3');
            emotionHeader.textContent = `${emotion} - Top Songs`;
            topSongsByEmotionDiv.appendChild(emotionHeader);

            let emotionList = document.createElement('ul');
            data.top_songs_by_emotion[emotion].forEach(song => {
                let listItem = document.createElement('li');
                listItem.textContent = song;
                emotionList.appendChild(listItem);
            });
            topSongsByEmotionDiv.appendChild(emotionList);
        }
    },
    error: function(xhr, status, error) {
        console.error('AJAX request failed:', status, error);
        // Handle the error gracefully (e.g., display an error message to the user)
    }
});
