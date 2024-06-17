var cpath = document.body.getAttribute('data-cpath');
$.ajax({
    url: `${cpath}/getMypage`,
    type: 'POST',
    dataType: 'json',
    success: function(data) {
        console.log('차트 1 데이터 로드 성공');
		const topSongsData = data.top_songs_by_genre;
        const labels = topSongsData.map(item => item.title);
        const values = topSongsData.map(item => item.play_count);

        const container = document.getElementById('labelsContainer2');
        const containerData = document.getElementById('labelsContainerData2');
        container.innerHTML = '';
        containerData.innerHTML = '';

        const heading = document.createElement('h4');
        heading.textContent = '내가 사랑한 노래';
        container.appendChild(heading);

        labels.forEach((label, index) => {
            const span = document.createElement('span');
            span.textContent = (index+1) + ". " + label;
            containerData.appendChild(span);
            if (index < labels.length - 1) {
                containerData.appendChild(document.createElement('br'));
            }
        });
		let chartStatus = Chart.getChart('myChart2');
			if (chartStatus !== undefined) {
			  chartStatus.destroy();
			}
        const prefernce = document.getElementById('myChart2').getContext('2d');
        new Chart(prefernce, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: '개수',
                    data: values,
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
                rotation: -90,
                circumference: 180,
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
    error: function(e) {
        console.log('차트 1 데이터 로드 실패');
         console.log(e);
    }
});