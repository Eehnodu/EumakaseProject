/*const Mpath = document.body.getAttribute('data-cpath');

$.ajax({
    url: `${Mpath}/getIntroMusic`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('인트로뮤직 연결만성공 뮤직');
		
        // 장르 차트
        const genreCtx = document.getElementById('musicChart').getContext('2d');
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
                responsive: false,
                plugins: {
                    legend: false,
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + '개';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });

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
                responsive: false,
                plugins: {
                    legend: false,
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed + '개';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    },
    error: function() {
        console.log('인트로 페이지 실패');
    }
});
*/